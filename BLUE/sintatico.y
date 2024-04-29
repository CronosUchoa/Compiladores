%{
#include <iostream>
#include <string>
#include <sstream>

#define YYSTYPE atributos

using namespace std;

int var_temp_qnt;

struct atributos
{
	string label;
	string traducao;
};

int yylex(void);
void yyerror(string);
string gentempcode();
%}

%token TK_MAIN TK_ID 
%token TK_NUM
%token TK_TIPO_INT TK_TIPO_BOOL TK_TIPO_FLOAT TK_TIPO_CHAR
%token TK_OR TK_AND
%token TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_DIFERENTE TK_IGUALDADE TK_MAIS_MAIS TK_MENOS_MENOS 
%token TK_POTENCIA TK_MAIS_IGUAL TK_MENOS_IGUAL TK_MULTI_IGUAL TK_DIV_IGUAL
%token TK_FIM TK_ERROR

%start S

%left '+' '-'
%right '='

%%

S 			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				string codigo = "/*Compilador BLUE*/\n"
								"#include <iostream>\n"
								"#include<string.h>\n"
								"#include<stdio.h>\n"
								"int main(void) {\n";
								
				codigo += $5.traducao;
								
				codigo += 	"\treturn 0;"
							"\n}";

				cout << codigo << endl;
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO COMANDOS
			{
				$$.traducao = $1.traducao + $2.traducao;
			}
			|
			{
				$$.traducao = "";
			}
			;

COMANDO 	: E ';'
			{
				$$.traducao = $1.traducao;
			}
			;

E 			: E '+' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label + 
					" = " + $1.label + " + " + $3.label + ";\n";
			}
			| E '-' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label + 
					" = " + $1.label + " - " + $3.label + ";\n";
			}
			| TK_ID '=' E
			{
				$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + $3.label + ";\n";
			}
			| TK_NUM
			{
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}
			| TK_ID
			{
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}
			|TK_TIPO_INT TK_ID
			{	
				$$.label = gentempcode();
				$$.traducao = "\tint " + $$.label + ";\n\t" + $$.label + " = " + $2.label + ";\n";
			}
			|TK_TIPO_INT TK_ID '=' TK_NUM
			{	
				$$.label = gentempcode();
				string temp_num = gentempcode();
				$$.traducao = "\tint " + $$.label + ";\n\t"+"int " + temp_num + ";\n\t"
				  +	$$.label  + " = " + $2.label + ";\n\t" + temp_num  + " = " +  $4.label + ";\n\t" 
				  + $$.label + " = " + temp_num + ";\n\t";
			}
			;

%%

#include "lex.yy.c"

int yyparse();

string gentempcode()
{
	var_temp_qnt++;
	return "t" + to_string(var_temp_qnt);
}

int main(int argc, char* argv[])
{
	var_temp_qnt = 0;

	yyparse();

	return 0;
}

void yyerror(string MSG)
{
	cout << MSG << endl;
	exit (0);
}				