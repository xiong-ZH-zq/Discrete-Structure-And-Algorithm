# 耐心排序算法相关算法代码

# TODO 寻找最长子字符串 时间复杂度 O(n log(n))
# TODO 利用耐心排序给任意排列排序

from collections import deque    # 更快的双向队列
import numpy as np    # 测试用

def binary_search(arr:list[list],target:int) -> int:
    """利用二分查找法查找顶部元素比 target 大的最小位置
    
    - `arr` 查找数组
    - `target` 目标数值
    """
    # 验证边界情况
    if not arr or arr[-1][-1]<target:
        return -1

    # 这里使用了 len(arr) ，本身就是 O(n) 的复杂度
    # 如果想更高效率，可以传入长度.
    left, right = 0, len(arr)-1

    while left < right:
        mid = (left+right)//2
        
        if arr[mid][-1] <= target:
            # 让左部偏移多一位，可以使得我们想要的
            left = mid+1
        elif arr[mid][-1] > target:
            right = mid
        
    return left


def find_longest_subsequence(arr:list[int],ascend:bool=True) -> list:
    """寻找数组当中的最长子递增/递减序列，返回一个可能的最长子递增/递减字符串

    - `arr` 目标数组
    - `ascend` 是否递增，默认为 True
    """
    if not ascend:
        arr = arr[::-1]    # 递减序列即为反向递增

    # 放牌堆的牌桌
    table = deque()
    subsequence = deque()
    length = 0
    # 使用双向队列加快弹出速度
    arr = deque(arr)

    # 循环迭代
    while arr:
        num = arr.popleft()
        index = binary_search(table,num)

        if index == -1:
            # 如果为空或者比最后一个还要更大，就需要增加牌堆
            # 此时需要向子序列添加相应的数
            table.append([num])
            length += 1
        else:
            table[index].append(num)

    for i in range(length-1,-1,-1):
        pile = table.pop()
        num = pile[-1]
        while subsequence and pile and pile[-1] < subsequence[0]:
            num = pile.pop()

        subsequence.appendleft(num)
    return list(subsequence) if ascend else list(subsequence)[::-1]


if __name__ == '__main__':

    # 利用随机数测试
    arr = np.random.choice(50,10,replace=False)
    print(arr)
    print(find_longest_subsequence(list(arr),ascend=False))