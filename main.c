#include <stdio.h>
#include <stdlib.h>

extern void fizzbuzz(int n);
int	main (int argc, char *argv[])
{
	#define USAGE	"Usage: fizzbuzz <number above 1>\n"
	#define INPUT_ERROR(x) if (x) { printf(USAGE);	return 0; }
	
	INPUT_ERROR(argc==1)
	int N = atoi(argv[1]);
	INPUT_ERROR(N < 1)
	
	fizzbuzz(N);	return 0;
}
