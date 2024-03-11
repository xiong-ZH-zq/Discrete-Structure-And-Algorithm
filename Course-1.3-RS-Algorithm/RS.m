clc;clear;close all;
%%

p=integerPartitions(10); %拆分测试
[q,v]=RS_sort({[1,4,6,9],[2,8,10],[7]},3); %RS算法测试
[q1,v1]=RS_sort_inv(q,v);%RS算法逆过程测试


function partitions = integerPartitions(n)  
%本函数用于实现正整数的全部拆分，（不计顺序）
%n-正整数
%partitions-元胞数组，包含n的全部拆分

    % 初始化结果数组  
    partitions = {};  
      
    % 递归辅助函数  
    function findPartitions(remaining, currentPartition)  
        % 基准情况：当剩余数为0时，将当前划分添加到结果中  
        if remaining == 0  
            partitions{end+1} = currentPartition;  %对已有数组进行操作
            return;  
        end  
          
        % 递归情况：对每一个可能的划分数进行递归调用  
        for i = 1:remaining  

            % 添加当前数到当前划分中  
            if ~isempty(currentPartition)
                if i>=currentPartition(end) %去除重复情况
                    newPartition = [currentPartition, i];  
                else
                    continue
                end
            else
                newPartition = [currentPartition, i];
            end
            
            % 递归调用，剩余数减去当前数  
            findPartitions(remaining-i, newPartition);  
        end  
    end  
      
    % 从第一个数开始递归查找所有划分  
    findPartitions(n, []);  
end

function [output,u]=RS_sort(input,n)
%本函数用于RS算法向杨表中插入元素
%input-元胞数组，表示输入的杨表,n-插入的正整数且在input中未出现
%output-元胞数组，表示输出的杨表，u-最终运行到第几行
m=n;
for i=1:length(input)+1
    if i==length(input)+1 %判断是否溢出最后一行
        input{i}=m;u=i;
        break
    end

    sortmatrix=input{i};
    sortmatrix=sort([sortmatrix,m]);

    if sortmatrix(end)==m %是否比当前行都大
        input{i}=sortmatrix;u=i;
        break
    end

    idex=find(sortmatrix==m);
    m=sortmatrix(idex+1);sortmatrix(idex+1)=[]; %将m顶掉
    input{i}=sortmatrix;
end

output=input;

end

function [output,u]=RS_sort_inv(input,n)
%本函数用于RS算法排序的逆运算
%input-输入的杨表，n-锁定的行数
%output-输出的杨表，u-最终挤出的数

m=input{n}(end);
input{n}(end)=[];

for i=1:n-1
    sortmatrix=input{n-i};
    sortmatrix=sort([sortmatrix,m]);
    idex=find(sortmatrix==m);
    m=sortmatrix(idex-1);sortmatrix(idex-1)=[];
    input{n-i}=sortmatrix;
end
u=m;
output=input;

end


