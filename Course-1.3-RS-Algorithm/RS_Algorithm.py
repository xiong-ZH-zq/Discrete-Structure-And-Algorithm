"""
RS 算法及其实现

@xzqbear
"""

from collections import deque

class YoungTableau():
    """杨表数据结构"""

    def __init__(self,rows:list=[]) -> None:
        """生成杨表，每行维护大小关系"""
        self.rows = rows
    
    def __add__(self,num):
        """重载+运算符"""

        # 验空
        if not self.rows:
            self.rows.append([num])
            return self
        
        # 不为空时，寻找一个最小的大于 num 的值并替换进
        next = num
        for i in range(len(self.rows)):
            next, self.rows[i] = find_smallest(next,self.rows[i])
            if next is None:
                return self
        
        if next is not None:
            self.rows.append([next])
            return self
    
    def __str__(self) -> str:
        return str(self.rows)


def find_smallest(num:int,arr:list[int]) -> list:
    """查找列表中最小的比 num 大的值.
    - `num` : 待操作数
    - `arr` : 对应列表
    """
    is_greater = [0 if num>a else 1 for a in arr ]
    
    # num 比 arr 都大的情形，直接放在末尾即可
    if not any(is_greater):
        arr.append(num)
        return [None,arr]
    
    # 否则，需要找到最小的那个数并替换
    for i in range(len(is_greater)):
        if is_greater[i] == 1:
            arr[i],num = num, arr[i]
            return [num,arr]

def insert_young_tableau(s:list[int]) -> YoungTableau:
    """插入杨表的生成
    已经假定 s 当中不存在重复元素

    - `s`: 整数可迭代对象，表示要操作的排列
    """
    seq = deque(s)
    result = YoungTableau()

    while seq:
        item = seq.popleft()
        result += item
    
    return result

if __name__ == '__main__':
    num = 3
    arr = [3,1,4,2,6,9,10,8]
    young = insert_young_tableau(arr)


    print(f"""最长递增子列的长度为{len(young.rows[0])}
最长递减子列的长度为{len(young.rows)}""")
    
    print(f"最终的插入杨表为：{young}")
    