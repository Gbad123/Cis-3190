#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/timeb.h>
int main(int argc, char * argv[]){
  int n = 0, run = 1;
  FILE *f = fopen("output.txt", "a");
  if(f == NULL){
    printf("File doesn't exisit\n");
    exit(0);
  }
  do{
    //getting and checking user input
    //starting the time
    struct timeb timeStart, timeEnd;
    ftime(&timeStart);
    printf("Enter the range or 0 to end\n");
    scanf("%d",&n);
    //printf("%d\n", n);
    if(n == 0){
      run = 0;
      exit(0);
    }
    //setting default true for the entire array
    bool prime[n+1];
    memset(prime, true, sizeof(prime));
    for(int i = 2; i * i <= n; i++){
      //if the number remains unchanged it's a prime number
      if(prime[i] == true){
        //update the mulitple of the number to false
        for(int j = i * 2; j <= n; j += i){
          prime[j] = false;
        }
      }
    }
    const char *text = "in C";
    const char *text2 = "end C";
    fprintf(f, "%s \n", text);
    //prints out the remaining numbers
    for(int i = 2; i <= n; i++){
      if(prime[i] == true){
        //flags to make sure not more then 10 numbers are displayed per line
        fprintf(f, "%d, ", i);
      }
    }
    fprintf(f, "\n%s\n", text2);
    ftime(&timeEnd);
    int sortElapsed;
    sortElapsed = (int)(1000.0*(timeEnd.time-timeStart.time)+(timeEnd.millitm-timeStart.millitm));
    printf("\n%d milli second\n", sortElapsed);
  }while(run == 1);
  exit(0);
}
