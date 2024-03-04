%% 提供者：https://github.com/Madeceline
clc;clear;close all;
%%
num=5;
Perm=perms(1:num);
[x,~]=size(Perm);
Out={};
for i=1:x
    origin_data=Perm(i,:);
    stack=patience_sort(Perm(i,:));
    longest=find_longest(Perm(i,:));
    Out{i}={origin_data,stack,longest};
end

function output=patience_sort(input)
%本函数用于耐心排序
%input-待排序列，为行向量
    q=input(:,1);p=input(:,2:end);
    loop=0;
    output={[q]};
    for i=1:size(p,2)
        q=p(:,1);p=p(2:end);
        for j=1:length(output)
            stack=output{j};
            if q<stack(1)
                stack=[q,stack];
                output{j}=stack;
                loop=1;
                break
            end
        end
        if loop==1
            loop=0;
            continue
        end
        output{length(output)+1}=q;
    end
end

function output=find_longest(input)
%本函数用于寻找最长递增子列
%input-待寻找序列-行向量
    output=[];input0=input;stack0=patience_sort(input);
    for i=1:length(stack0)
        patience_stack=patience_sort(input0);
        k=patience_stack{length(stack0)+1-i}(1);
        output=[k,output];
        index=find(input==k);
        input0=input(1:index);
    end
end
