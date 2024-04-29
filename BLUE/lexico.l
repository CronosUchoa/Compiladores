%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'({LETRA}|{NUM})\'
ID {LETRA}({LETRA}|{NUM})*

%%

"\n"		{}

{DELIM} 	{}

"main"		{return TK_MAIN;}

"bool"      {return TK_TIPO_BOOL;}

"int"		{return TK_TIPO_INT;}

"float"		{return TK_TIPO_FLOAT;}

"char"		{return TK_TIPO_CHAR;}

"||"        {return TK_OR;}

"&&"        {return TK_AND;}

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }

"="		    { return '='; }

[<]         { return *yytext; }

[>]         { return *yytext; }

"<="        { yylval.traducao = " <= "; return TK_MENOR_IGUAL; }

"=>"        { yylval.traducao = " => "; return TK_MAIOR_IGUAL; }

"!="        { yylval.traducao = " != "; return TK_DIFERENTE; }

"=="        { yylval.traducao = " == "; return TK_IGUALDADE; }

"++"        {yylval.traducao = "++" ; return TK_MAIS_MAIS;}  

"--"        {yylval.traducao = "--"; return TK_MENOS_MENOS;}

"**"        {yylval.traducao = "**"; return TK_POTENCIA;}

"+="        {yylval.traducao = "+="; return TK_MAIS_IGUAL;}

"-="        {yylval.traducao = "-="; return TK_MENOS_IGUAL;}

"*="        {yylval.traducao = "*="; return TK_MULTI_IGUAL;}

"/="        {yylval.traducao = "/="; return TK_DIV_IGUAL;}

{NUM}		{ yylval.label = yytext; return TK_NUM; }
{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%