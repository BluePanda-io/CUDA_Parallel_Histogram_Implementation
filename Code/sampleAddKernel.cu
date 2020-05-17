#include <math.h>
#include <stdio.h>


__global__ void sampleAdd(int const * const A, int *B, int m) {

  
  //===========Initialize Variables====================
  
  int Bins=255; // How many cells your Histogram has (It is Image so hase 255)
  
  int L_Hist[256]; // TODO: Change the length of this image with Variable
  for (int PP=0;PP<=255;PP++){
	L_Hist[PP]=0; // Initialize the cells with the number 0
  }
  
  
  
  int cellsEveryThread=m/blockDim.x; // How much of the starter Array A Every thread will work with 
  
  
  int i = cellsEveryThread*threadIdx.x; // Where in the Array A every thread will start working
  
  
  //===========Initialize Variables END====================
  
  
  
  // ======================Create the Histogram==================
  int Posit;
  for (int Count=0;Count<cellsEveryThread;Count++)// Read all the 
  {
      if (i+Count<m)
	  {
		  Posit = A[i+Count];
		  L_Hist[Posit]=L_Hist[Posit]+1; // We don't need Atomic ADD because every 
		  
	  }
  }
  __syncthreads();
  
  
  
  __shared__ int L_PositionArray[8]; // Aftos o pinakas prepi na mirazete anamesa sta threads kai dimiourgite mesa apo ena bin olon ton threads
  
  int DD;
  for (int ki=0;ki<Bins;ki++){ // ki<Bins
	
	DD=L_Hist[ki];
	
	L_PositionArray[threadIdx.x]=DD;// Perno kathe fora ena simio apo ola ta Histogram olon ton threads
    
	__syncthreads();
	
	//==================Sum the Numbers and Right the Final Result to the table===============
	
	int tid=threadIdx.x;
	
	for (int s=blockDim.x/2;s>0;s>>=1){
	
	
		if (tid<s){
			
			int kks=tid+s;
			
			L_PositionArray[tid]=L_PositionArray[tid]+L_PositionArray[kks];
		}
		
		__syncthreads();
	}
	
	
	B[ki]=L_PositionArray[0];
	
	
	//==================Sum the Numbers and Right the Final Result to the table===============
	
	
	__syncthreads();
	
  }
  
  
 
}
  




















