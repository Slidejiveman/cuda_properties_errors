
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

int main()
{
	// Fetch device properties and display them to the screen.
	int nDevices;

	// All CUDA API calls have a return value that indicate
	// whether or not an error occurred during the execution
	// of the function.
	cudaError_t err = cudaGetDeviceCount(&nDevices);
	// Code like this will handle errors in the CPU calls.
	// Kernel errors are more difficult to handle than this
	// since they are executing asynchronously with respect
	// to the host (CPU). Debugging macros in the in the 
	// asynchronous portions of your code prevents concurrency,
	// so be wise when checking those. Probably not good for 
	// release builds.
	if (err != cudaSuccess) {
		printf("%s\n", cudaGetErrorString(err));
	}

	for (int i = 0; i < nDevices; i++) {
		cudaDeviceProp prop; // Note: this struct has many other fields
		cudaGetDeviceProperties(&prop, i);
		printf("Device Number: %d\n", i);
		printf("  Device name: %s\n", prop.name);
		printf("  Memory Clock Rate (KHz): %d\n", prop.memoryClockRate);
		printf("  Memory Bus Width (bits): %d\n", prop.memoryBusWidth);
		
		// This calculation represents the theoretical peak memory bandwidth
		// which is based on the given hardware specs.
		printf("  Peak Memory Bandwidth (GB/s): %f\n\n", 
			2.0 * prop.memoryClockRate * (prop.memoryBusWidth / 8) / 1.0e6);
	}
    return 0;
}
