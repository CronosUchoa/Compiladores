%{
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <map>
#define YYSTYPE atributos

using namespace std;

int var_temp_qnt;

struct atributos
{
    string label;
    string traducao;
    string tipo; 
};

typedef struct
{
    string nome;
    string tipo;
} TIPO_SIMBOLO;

vector<TIPO_SIMBOLO> tabela_simbolos;

int yylex(void);
void yyerror(string);
string gentempcode();
void insere_simbolo(string nome, string tipo);
string busca_tipo(string nome); 
%}

%token TK_NUM
%token TK_MAIN TK_ID TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_CHAR
%token TK_FIM TK_ERROR

%start S

%left '+'

%%

S           : TK_TIPO_INT TK_MAIN '(' ')' BLOCO
            {
                string codigo = "/*Compilador Blue*/\n"
                                "#include <iostream>\n"
                                "#include<string.h>\n"
                                "#include<stdio.h>\n"
                                "int main(void) {\n";
                                
                codigo += $5.traducao;
                                
                codigo +=   "\treturn 0;"
                            "\n}";

                cout << codigo << endl;
            }
            ;

BLOCO       : '{' COMANDOS '}'
            {
                $$.traducao = $2.traducao;
            }
            ;

COMANDOS    : COMANDO COMANDOS
            {
                $$.traducao = $1.traducao + $2.traducao;
            }
            |
            {
                $$.traducao = "";
            }
            ;

COMANDO     : E ';'
            | TK_TIPO_INT TK_ID ';'
            {
                insere_simbolo($2.label, "int"); // Insere o símbolo na tabela de símbolos com tipo int
            }
			| TK_TIPO_FLOAT TK_ID ';'
            {
                insere_simbolo($2.label, "float"); // Insere o símbolo na tabela de símbolos com tipo int
            }
			| TK_TIPO_CHAR TK_ID ';'
			{
				insere_simbolo($2.label, "char"); // Insere o símbolo na tabela de símbolos com tipo int
			}
            ;

E           : E '+' E
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
                if (busca_tipo($1.label) == "int" || "float" || "char") // Verifica o tipo do identificador na tabela de símbolos
                    $$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + $3.label + ";\n";
                else
                    yyerror("Erro de tipo: Atribuição inválida.");
            }
            | TK_NUM
            {
                $$.label = gentempcode();
                $$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
            }
            | TK_ID
            {
                if (busca_tipo($1.label) == "int" || "float" || "char") // Verifica o tipo do identificador na tabela de símbolos
                {
                    $$.label = gentempcode();
                    $$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
                }
                else
                    yyerror("Erro de tipo: Variável não declarada.");
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

void insere_simbolo(string nome, string tipo)
{
    TIPO_SIMBOLO simbolo;
    simbolo.nome = nome;
    simbolo.tipo = tipo;
    tabela_simbolos.push_back(simbolo);
}

string busca_tipo(string nome)
{
    for (TIPO_SIMBOLO simbolo : tabela_simbolos)
    {
        if (simbolo.nome == nome)
            return simbolo.tipo;
    }
    return ""; // Retorna uma string vazia se o símbolo não for encontrado
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
