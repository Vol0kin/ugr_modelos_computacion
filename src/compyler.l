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
variable		({letra}|{digito}|_)+
crear			"crear "{variable}(" "({numero}|{cadena}|{espacio})+)?
longitud		"longitud "{variable}
imprimir		"imprimir "{variable}
recorrer		"recorrer "{variable}(" "{delimitador})?
insertar		"insertar "{variable}" "({cadena}|{numero})
borrar			"borrar "{variable}" "({cadena}|{numero})
obtener			"obtener "{variable}" "{entero}
copiar			"copiar "{variable}" "{variable}
concatenar		"concatenar "{variable}" "{variable}" "{variable}
ordenar			"ordenar "{variable}" reves"?
suma			{variable}" mas "{variable}(" mas "{variable})*
operador		"igual"|"diferente"|"menor"|"menor igual"|"mayor"|"mayor igual"
expresion		{longitud}|{suma}|{obtener}|{variable}|{ordenar}
comparar		"comparar "{expresion}" "{operador}" "{expresion}

%%

{crear}																{procesado = yytext + 6;
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
{longitud}															{procesado = yytext + 9; printf("len(%s)", procesado);}
{imprimir}															{procesado = yytext + 9; printf("print(%s)", procesado);}
{recorrer}															{procesado = yytext + 9;
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
{insertar}															{procesado = yytext + 9;
																		char * lista = malloc(strlen(procesado));
																		for (i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		elem = procesado;
																		printf("%s.append(%s)", lista, elem);}
{borrar}															{procesado = yytext + 7;
																		char *lista = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		elem = procesado;
																		printf("%s.remove(%s)", lista, elem);}
{obtener}															{procesado = yytext; procesado += 8;
																		char *lista = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		procesado += i + 1;
																		elem = procesado;
																		printf("print(%s[%s])", lista, elem);}
{copiar}															{procesado = yytext + 7;
																		char *orig = malloc(strlen(procesado));
																		char *dest = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			orig[i] = procesado[i];
																		procesado += i + 1;
																		dest = procesado;
																		printf("%s = %s", dest, orig);}
{concatenar}														{procesado = yytext + 11;
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
{ordenar}															{procesado = yytext + 8;
																		char *lista = malloc(strlen(procesado));
																		for(i = 0; i < strlen(procesado) && procesado[i] != ' '; i++)
																			lista[i] = procesado[i];
																		if (strlen(procesado) >= i + 1)
																			printf("%s.sort(reverse=True)", lista);
																		else
																			printf("%s.sort()", lista);}
{suma}																{procesado = yytext + 0;
																		char *l1 = malloc(strlen(procesado));
																		char *l2 = malloc(strlen(procesado));
																		l1 = procesado;
																		int primera_vuelta = 0;
																		int k = 0;
																		for(i = 0; i < strlen(procesado); i++, j++) {
																			if(procesado[i] == ' ') {
																				j = 0;
																				l1 += i + 5;
																				k += 5;
																				if(primera_vuelta == 0) {
																					printf("%s", l2);
																					primera_vuelta = 1;
																				}
																				else
																					printf(" + %s", l2);
																			}
																			l2[j] = l1[k];
																			k++;
																		}};
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
