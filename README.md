# Compiladores BLUE
O compilador foi criado para transformar o código criado em BLUE em um código intermediário na linguaguem c++ . É utilizado um padrão de três endereços para a criação dos códigos intermediários.
## Vídeos usados como recursos

1. Flex: https://youtu.be/c9WLbVZ5T3w
2. Bison: https://youtu.be/ATW-mq0ahaA
3. Código Intermediário: https://youtu.be/xLqb5RqXANQ
4. Video com a construção desse código: https://youtu.be/FmR3p1-tzoc

## Instalação

É necessário as ferramentas [flex](https://gnuwin32.sourceforge.net/packages/flex.htm), [bison](https://gnuwin32.sourceforge.net/packages/bison.htm) e ``gpp``.

## Execução

Foi criado um [Makefile](https://gnuwin32.sourceforge.net/packages/make.htm) com os comandos para a execução e o arquivo exemplo.foca será direcionado para a entrada do compilador gerado ao final do script.

```console
make
```
## Trabalho - Entrega I
**Especificação:**
* Expressão
* Tipos
    * Boolean
    * Int
    * Float
    * Char
* Conversão
  * Implícita
  * Explícita
* Operadores
  * Lógico
  * Aritmético
  * Relacional
* Variável
* Atribuição
