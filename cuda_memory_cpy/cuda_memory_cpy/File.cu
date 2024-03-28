#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

//printData kernel
//�Է��� �������ε� �̰��� �迭�� ù��° ��� �ּ���.
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

	// int�� 10���� �� �޸𸮰����� gpu���� �Ҵ�.
	// �Ҵ��� �޸��� ���� �ּҴ� dDataPtr ������ ������ ����ȴ�.
	cudaMalloc(&dDataPtr, sizeof(int) * 10);

	// �� ������ 0���� �ʱ�ȭ.
	cudaMemset(dDataPtr, 0, sizeof(int) * 10);

	printf("Data in device: ");
	printData << <1, 10 >> > (dDataPtr);

	// data �迭�� ���� dDataPtr �迭�� ����. ������ Host���� Device��
	cudaMemcpy(dDataPtr, data, sizeof(int) * 10, cudaMemcpyHostToDevice);
	printf("\nHost ->Device: ");
	printData << <1, 10 >> > (dDataPtr);

	setData << <1, 10 >> > (dDataPtr);

	cudaMemcpy(data, dDataPtr, sizeof(int) * 10, cudaMemcpyDeviceToHost);
	printf("\nDevice -> Host: ");
	for (int i = 0; i < 10; i++) printf("%d", data[i]);

	cudaFree(dDataPtr);

}