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
	// device 메모리를 할당.
// 할당된 메모리 공간의 시작 주소가 dDataPtr 포인터 변수에 저장.
// 주의: dDataPtr이 가리키는 주소는 device 메모리상의 주소이므로 
// 호스트 코드에서 dDataPtr을 통해 device 메모리에 직접 접근할 수는 없다.

	printf("cudaMalloc - %s\n", cudaGetErrorName(errorCode));
	checkDeviceMemory();

	errorCode = cudaMemset(dDataPtr, 0, sizeof(int) * 1024 * 1024 * 1024 * 12);
	//메모리 공간의 값을 초기화. 0으로 초기화.
	printf("cudaMemset - %s\n", cudaGetErrorName(errorCode));


	errorCode = cudaFree(dDataPtr);
	printf("cudaFree - %s\n", cudaGetErrorName(errorCode));
	checkDeviceMemory();

	cudaFree(dDataPtr);
	// device 메모리 해제


}