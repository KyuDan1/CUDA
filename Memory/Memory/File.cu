#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
void checkDeviceMemory(void) {
	size_t free, total;
	cudaMemGetInfo(& free, &total);	
	printf("Device memroy (free/total) = %lld/%lld bytes\n", free, total);
}



int main(void)
{
	int* dDataPtr;
	cudaError_t errorCode;

	checkDeviceMemory();
	errorCode = cudaMalloc(&dDataPtr, sizeof(int) * 1024 * 1024 * 1024 * 12);
	// device �޸𸮸� �Ҵ�.
// �Ҵ�� �޸� ������ ���� �ּҰ� dDataPtr ������ ������ ����.
// ����: dDataPtr�� ����Ű�� �ּҴ� device �޸𸮻��� �ּ��̹Ƿ� 
// ȣ��Ʈ �ڵ忡�� dDataPtr�� ���� device �޸𸮿� ���� ������ ���� ����.

	printf("cudaMalloc - %s\n", cudaGetErrorName(errorCode));
	checkDeviceMemory();

	errorCode = cudaMemset(dDataPtr, 0, sizeof(int) * 1024 * 1024 * 1024 * 12);
	//�޸� ������ ���� �ʱ�ȭ. 0���� �ʱ�ȭ.
	printf("cudaMemset - %s\n", cudaGetErrorName(errorCode));


	errorCode = cudaFree(dDataPtr);
	printf("cudaFree - %s\n", cudaGetErrorName(errorCode));
	checkDeviceMemory();

	cudaFree(dDataPtr);
	// device �޸� ����


}