SHELL := /bin/bash # Use bash syntax

CC = sm_20
#NVCC	= nvcc -arch compute_11
NVCC	= nvcc -arch=$(CC)
#NVCC	= nvcc -arch=$(CC) -v kernel.cu -o kernel.o
#NVCC = nvcc -arch=sm_11 -v kernel.cu -o kernel.o
SAMPLE	= sampleAddKernel
ARGS	= -ptx

all: sample

sample:
	$(NVCC) $(ARGS) $(SAMPLE).cu

clean:
	rm -rf *~ *.ptx
