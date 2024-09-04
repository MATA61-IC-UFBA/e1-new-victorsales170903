/* just like Unix wc */
%option noyywrap nodefault yylineno

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int chars = 0;
int words = 0;
int lines = 0;
%}

%%

[^ \n\t\r\f\v]+  { words++; chars+=strlen(yytext); }
\n         { chars++; lines++; }
.          { chars++; }

%%

int main(int argc, char **argv)
{
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            exit(1);
        }
        yyin = file;  
    }

    yylex();  // Run the lexer

    printf("%8d%8d%8d\n", lines, words, chars);

    if (yyin != stdin) {
        fclose(yyin);
    }

    return 0;
}
