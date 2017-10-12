%{
#include <stdlib.h>
#include <stdio.h>
#include "lengua.tab.h"
int numero_linea = 1;
int FINAL = 0;
%}

%%

("con") { return CON; }
("si")	{ return IF; }
(":") { return THEN; }
("::") { return VARIAR; } 
("sino")	{ return ELSE; }
("mientras")	{ return WHILE; }
("para")	{ return FOR; }
("INICIO")    { return INICIO; }
("FIN")       { FINAL = 1; return FIN; } 
("fin_si") { return FIN_SI; }
("fin_mientras") { return FIN_MIENTRAS; }
("fin_para") { return FIN_PARA; }
("sqrt")        {return SQRT; }
("&&"|"y")	{ return AND; }
("||"|"o")	{ return OR; }
("==")   { return EQ; }
("!=") { return NEQ; }
("=")   { return ASIGNACION; }
("%%") { return MOD; }
[a-zA-Z]([A-Za-z0-9_])*   { return ID; }
[0-9]+"."[0-9]+	{ return NUMREAL; }
[1-9]([0-9])*|("0")	{ return NUMINT; }
("(")   { return PARENTESISLEFT; }
(")")   { return PARENTESISRIGHT; }
(";")	{ return PUNTCOM; }
("+")   { return MAS; }
("-")   { return MENOS; }
("*")   { return MULTI; }
("/")   { return DIVI; }
("^")	{ return EXPO; }
[ \t\f]	;
\n	{ numero_linea++; }
.	{ fprintf(stderr, "'%c' (0%o): Error de sintaxis en linea %d\n",yytext[0], yytext[0], numero_linea); }
%%


int yywrap(){
    return 1;
}

