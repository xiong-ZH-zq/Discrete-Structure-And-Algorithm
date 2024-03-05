// 堆栈排序 - stack sorting
// 输入数组后进行堆栈排序
#include<stdio.h>
#include<stdlib.h>

int* stackSorting(int* arr,int N){
	/* 堆栈排序 
	:param arr: 待排序数组
	:param N: 待排数组的长度
	*/
	
	int* stack = (int *)malloc(sizeof(int)*N);
	int* result = (int *)malloc(sizeof(int)*N);
	int stack_elem = 0;    // 栈内的元素个数
	int result_elem = 0;
	
	for(int i=0;i<N;i++){
		int num = arr[i];
		while(stack_elem && num > stack[stack_elem-1]){
			printf("弹出 %d！\n",stack[stack_elem-1]);
			result[result_elem] = stack[stack_elem-1];
			stack_elem--;
			result_elem++;
		}
		
		stack[stack_elem] = num;
		stack_elem++;
	}
	
	// 弹出栈中剩余元素
	while(stack_elem){
		printf("弹出 %d！\n",stack[stack_elem-1]);
		result[result_elem] = stack[stack_elem-1];
		stack_elem--;
		result_elem++;
	}
	
	return result;
	
}

int main(void){
	
	int arr[5] = {4,3,2,5,1};
	
	int* newarr = (int *)malloc(5*sizeof(int));
	newarr = stackSorting(arr,5);
	
	for(int i=0;i<5;i++){
		printf("%d\n",newarr[i]);
	}
	return 0;
}
