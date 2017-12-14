bison -d naple.y
flex -o naple.lex.c naple.l
gcc -g naple.tab.c naple.lex.c naplefuncs.c -lm
