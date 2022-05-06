#include <stdio.h>

using namespace std;
extern FILE * yyin;
int yyparse();

int main(int argc, char*argv[]){

    if (argc != 2)
    {
        fprintf(stderr, "Missing input file %s \n", argv[0]);
        return 1;
    }

    for(int i=0; i < argc; i++){

        FILE * f = fopen(argv[i], "r");
        if (f == NULL)
        {
            fprintf(stderr, "Couldn't open file %s \n", argv[i]);
            return 1;
        }
        
        yyin = f;

        yyparse();
    
    }
    return 0;
}