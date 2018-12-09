/* --------------------------- Declaraciones -------------------------------- */

%option noyywrap
%{
#include <stdio.h>

char * procesado;
char * elem;
int i = 0;
int j = 0;
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
"borrar "{variable}" "({letra}|{digito})		{procesado = yytext; procesado += 7; char *lista = malloc(strlen(procesado)); for(int i=0; i<strlen(procesado)-2; i++) lista[i] = procesado[i]; elem = procesado; elem += (strlen(procesado)-1); printf("%s.remove(%s)", lista, elem);}
"obtener "{variable}" "{numero}		{procesado = yytext; procesado += 8; char *lista = malloc(strlen(procesado)); for(int i=0; i<strlen(procesado)-2; i++) lista[i] = procesado[i]; elem = procesado; elem += (strlen(procesado)-1); printf("printf(%s[%s])", lista, elem);}
"copiar "{variable}" "{variable}		{procesado = yytext; procesado += 7; char *orig = malloc(strlen(procesado)); char *dest = malloc(strlen(procesado)); for(i=0; i<strlen(procesado) && procesado[i] != ' '; i++) orig[i] = procesado[i]; for(i=i+1, j=0; i<strlen(procesado); i++, j++) dest[j] = procesado[i]; printf("%s = %s", dest, orig);}
"concatenar "{variable}" "{variable}" "{variable}	{procesado = yytext; procesado += 11; char *l1 = malloc(strlen(procesado)); char *l2 = malloc(strlen(procesado)); char *dest = malloc(strlen(procesado)); for(i=0; i<strlen(procesado) && procesado[i] != ' '; i++) l1[i] = procesado[i]; for(i=i+1, j=0; i<strlen(procesado) && procesado[i] != ' '; i++, j++) l2[j] = procesado[i]; for(i=i+1, j=0; i<strlen(procesado); i++, j++) dest[j] = procesado[i]; printf("%s = %s + %s", dest, l1, l2);}
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
