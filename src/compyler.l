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
entero			\-?{digito}+
numero			{entero}(\.{digito}+)?
delimitador		"'"[^\t\n]+"'"
cadena			("'"({letra}|{digito}|{espacio})*"'")
variable		({letra}|{digito})+

%%

"crear "{variable}(" "({numero}|{cadena}|{espacio})+)? 				{procesado = yytext + 6;
																		char * lista = malloc(strlen(procesado));
																		elem = malloc(strlen(procesado) * 2);
																		for (i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		j = 0;
																		int cambiar_espacio_coma = 0;
																		for (i = 0; i < strlen(procesado); i++) {
																			if (procesado[i] == ' ') {
																				if (cambiar_espacio_coma != 0) {
																					elem[j] = ',';
																					j++;
																					elem[j] = ' ';
																					j++;
																					cambiar_espacio_coma = 0;
																				}
																			} else {
																				elem[j] = procesado[i];
																				j++;
																				cambiar_espacio_coma = 1;
																			}
																		}
																		printf("%s = [%s]", lista, elem);}
"longitud "{variable}												{procesado = yytext + 9; printf("len(%s)", procesado);}
"imprimir "{variable}												{procesado = yytext + 9; printf("print(%s)", procesado);}
"recorrer "{variable}(" "{delimitador})?							{procesado = yytext + 9;
																		char * lista = malloc(strlen(procesado));
																		char * delim;
																		int usar_delim = 0;
																		for (i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		if (strlen(procesado) >= i + 1)
																			usar_delim = 1;
																		procesado += i + 1;
																		delim = procesado;
																		printf("for item in %s:\n    print(item", lista);
																		if (usar_delim)
																			printf(", end = %s", delim);
																		printf(")");
																	}
"insertar "{variable}" "({cadena}|{numero})							{procesado = yytext + 9;
																		char * lista = malloc(strlen(procesado));
																		for (i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		elem = procesado;
																		printf("%s.append(%s)", lista, elem);}
"borrar "{variable}" "({cadena}|{numero})							{procesado = yytext + 7;
																		char *lista = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		elem = procesado;
																		printf("%s.remove(%s)", lista, elem);}
"obtener "{variable}" "{entero}										{procesado = yytext; procesado += 8;
																		char *lista = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		elem = procesado;
																		printf("print(%s[%s])", lista, elem);}
"copiar "{variable}" "{variable}									{procesado = yytext + 7;
																		char *orig = malloc(strlen(procesado));
																		char *dest = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			orig[i] = procesado[i];
																		procesado += i + 1;
																		dest = procesado;
																		printf("%s = %s", dest, orig);}
"concatenar "{variable}" "{variable}" "{variable}					{procesado = yytext + 11;
																		char *l1 = malloc(strlen(procesado));
																		char *l2 = malloc(strlen(procesado));
																		char *dest = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			l1[i] = procesado[i];
																		procesado += i + 1;
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			l2[i] = procesado[i];
																		procesado += i + 1;
																		dest = procesado;
																		printf("%s = %s + %s", dest, l1, l2);}
.																	{}

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
