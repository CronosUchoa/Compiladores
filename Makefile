#g++ -o glf sintatico.tab.c -ll
#no windows é flex
#SCANNER := lex
SCANNER := flex
SCANNER_PARAMS := lexico.l
#PARSER := yacc
PARSER := bison
PARSER_PARAMS := -d sintatico.y

all: compile translate

compile:
		$(SCANNER) $(SCANNER_PARAMS)
		$(PARSER) $(PARSER_PARAMS)
		g++ -o glf sintatico.tab.c -lfl

run: 	glf
		clear
		compile
		translate

debug:	PARSER_PARAMS += -Wcounterexamples
debug: 	all

#translate:glf
translate:
	./glf < exemplo.blue

clean:
	rm sintatico.tab.c
	rm sintatico.tab.h
	rm lex.yy.c
	rm glf