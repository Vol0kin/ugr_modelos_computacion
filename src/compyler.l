/* --------------------------- Declaraciones -------------------------------- */

%option noyywrap
%{
#include <stdio.h>

char * procesado;
%}

letra			[a-zA-Z]
digito			[0-9]
espacio			[ ]
numero			{digito}+
cadena			("'"({letra}|{digito}|{espacio})*"'")
variable		({letra}|{digito})+

%%


"crear "{variable}("("({numero}|{cadena}|{espacio})+")")? 			{procesado = yytext; procesado += 6; printf("%s = []", procesado);}
"longitud "{variable}		{procesado = yytext; procesado += 9; printf("len(%s)", procesado);}
"imprimir "{variable}		{procesado = yytext; procesado += 9; printf("print(%s)", procesado);}
"recorrer "{variable}		{procesado = yytext; procesado += 9; printf("for item in %s:\n    print(item)", procesado);}
"insertar "{variable}" "({cadena}|{numero})	{procesado = yytext; procesado += 9; printf("%s.append()", procesado);}
.							{}

%%

int main(int argc, char *argv[]) {

	if (argc == 2) {
		yyin = fopen(argv[1], "rt");

		if (yyin == NULL) {
			printf("El fichero %s no se pudo abrir\n", argv[1]);
			exit(-1);
		}
	} else
		yyin = stdin;

	yylex();

	return 0;
}
