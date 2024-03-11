clc;clear;close all;
%%
num=9;
Perm=perms(1:num);
[x,~]=size(Perm);
times=[];
for i=1:x
    out=Perm(i,:);
    k=0;
    while ~isequal(out,1:num)
        out=stack_code(out);
        k=k+1;
    end
    times=[times,k];
    %disp(['输入：',num2str(in),'，输出：',num2str(out),'是否为单位排列：',num2str(isequal(out,1:num))])
end

stat=tabulate(times); %计数

figure
bar(stat(:,1),stat(:,2))
xlabel('排列次数')
ylabel('排列数')
ylim([0,max(stat(:,2))*1.2])
% text(stat(:,1)-0.5,stat(:,2)+800,num2str(stat(:,2)))
% text(stat(:,1)-0.8,stat(:,2)+400,num2str(stat(:,3)/100))
title(['堆栈排成单位排列所需次数','，n=',num2str(num)])


function [Output]=stack_code(input)
    stack0=[];Output=[];
    for i=1:length(input)
        passenger=input(i);
        m=find(stack0-passenger<0);
        if isempty(m)
            k=1;
        else
            k=m(end)+1;
        end
        Out=stack0(1:k-1);
        stack0=[passenger,stack0(k:end)];
        Output=[Output,Out];
    end
    Output=[Output,stack0];
end



