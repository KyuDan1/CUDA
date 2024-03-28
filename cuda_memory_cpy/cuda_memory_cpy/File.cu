#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

//printData kernel
//입력이 포인터인데 이것이 배열의 첫번째 요소 주소임.
__global__ void printData(int* _dDataPtr) {
	printf("%d", _dDataPtr[threadIdx.x]);
}

__global__ void setData(int* _dDataPtr) {
	_dDataPtr[threadIdx.x] = 2;
}



int main(void) {
	
	// Define in host(CPU)
	int data[10] = { 0 };
	for (int i = 0; i < 10; i++) data[i] = 1;

	int* dDataPtr;

	// int형 10개가 들어갈 메모리공간을 gpu에서 할당.
	// 할당한 메모리의 시작 주소는 dDataPtr 포인터 변수에 조장된다.
	cudaMalloc(&dDataPtr, sizeof(int) * 10);

	// 그 공간을 0으로 초기화.
	cudaMemset(dDataPtr, 0, sizeof(int) * 10);

	printf("Data in device: ");
	printData << <1, 10 >> > (dDataPtr);

	// data 배열의 값을 dDataPtr 배열로 복사. 방향은 Host에서 Device로
	cudaMemcpy(dDataPtr, data, sizeof(int) * 10, cudaMemcpyHostToDevice);
	printf("\nHost ->Device: ");
	printData << <1, 10 >> > (dDataPtr);

	setData << <1, 10 >> > (dDataPtr);

	cudaMemcpy(data, dDataPtr, sizeof(int) * 10, cudaMemcpyDeviceToHost);
	printf("\nDevice -> Host: ");
	for (int i = 0; i < 10; i++) printf("%d", data[i]);

	cudaFree(dDataPtr);

}