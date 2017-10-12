%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
int yyerror(char *s);
int yylex();
%}

%token IF THEN ELSE WHILE FOR AND OR ASIGNACION EQ ID NUMREAL NEQ
%token NUMINT PARENTESISLEFT PARENTESISRIGHT PUNTCOM MAS VARIAR CON
%token MENOS MULTI DIVI EXPO SQRT INICIO FIN FIN_SI FIN_MIENTRAS FIN_PARA MOD

%%

programa : INICIO declaraciones FIN ;

declaraciones :	declaraciones PUNTCOM declaracion 
	| declaracion
	;

declaracion : abierta_declaracion
	| cerrada_declaracion
	;

abierta_declaracion : if_abierto
	| while_abierto
	| for_abierto
	;

declaraciones_delimitadas : declaraciones
	;

cerrada_declaracion : expresion
	| declaraciones_delimitadas
	| if_cerrado
	| while_cerrado
	| for_cerrado
	|
	;

while_abierto : WHILE expresiones_booleanas THEN abierta_declaracion
	;

while_cerrado : WHILE expresiones_booleanas THEN cerrada_declaracion
	;

if_abierto : IF expresiones_booleanas THEN declaracion
	| IF expresiones_booleanas THEN cerrada_declaracion ELSE abierta_declaracion |
	;

if_cerrado : IF expresiones_booleanas THEN cerrada_declaracion ELSE cerrada_declaracion
	;

for_abierto : FOR variable_control ASIGNACION NUMINT CON expresiones_booleanas VARIAR expresion  abierta_declaracion
	;

for_cerrado : FOR variable_control ASIGNACION NUMINT CON expresiones_booleanas VARIAR expresion cerrada_declaracion
	;

variable_control : ID
	;

valor_final : NUMINT
	;

expresiones_booleanas : expresion_booleana
	| PARENTESISLEFT expresion_booleana PARENTESISRIGHT AND expresiones_booleanas
	| PARENTESISLEFT expresion_booleana PARENTESISRIGHT OR expresiones_booleanas
	;

expresion_booleana : ID EQ ID | ID NEQ ID
	| ID EQ NUMINT | ID NEQ NUMINT
	| ID EQ NUMREAL | ID NEQ NUMREAL
	| ID EQ PARENTESISLEFT operacionl1 PARENTESISRIGHT | ID NEQ PARENTESISLEFT operacionl1 PARENTESISRIGHT
	| PARENTESISLEFT operacionl1 PARENTESISRIGHT EQ PARENTESISLEFT operacionl1 PARENTESISRIGHT | PARENTESISLEFT operacionl1 PARENTESISRIGHT NEQ PARENTESISLEFT operacionl1 PARENTESISRIGHT
	;

expresion: ID ASIGNACION operacionl1  
	| ID ASIGNACION ID
	;

operacionl1: operacionl1 MAS operacionl2	{ $$ = $1 + $3; }
	| operacionl1 MENOS operacionl2	{ $$ = $1 - $3; }
	| operacionl1 MOD operacionl2 { $$ = $1 % $3; }
	| operacionl2
	;

operacionl2: operacionl2 MULTI operacionl3 { $$ = $1 * $3; }
	| operacionl2 DIVI operacionl3 { $$ = $1 / $3; }
	| operacionl3
	;

operacionl3: operacionl3 EXPO nente  { $$ = pow($1, $3); }
	| SQRT PARENTESISLEFT operacionl1 PARENTESISRIGHT	{ $$ = sqrt($3); }
	| nente
	;

nente: PARENTESISLEFT operacionl1 PARENTESISRIGHT	{ $$ = $2;}
	| NUMREAL
	| NUMINT
	;

%%

extern int line_no;
extern char *yytext;

int yyerror(char *s){
	printf("\nError en el programa\n");
	return 1;
}

int main(){
	if(!yyparse()) printf("Programa compilado exitosamente\n");
	else printf("Error en la sintaxis\n");
	return 0;
}
