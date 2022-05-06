%option yylineno
%option noyywrap
%option caseless

%{
   #include "tokens.h"
%}

DIGIT [0-9]

%%
[\t \r] {}
"select" {return TK_SELECT;}
"update" {return TK_UPDATE;}
"delete" {return TK_DELETE;}
"insert" {return TK_INSERT;}
"where" {return TK_WHERE;}
"from" {return TK_FROM;}
"set" {return TK_SET;}
"into" {return TK_INTO;}
"values" {return TK_VALUES;}
"group by" {return TK_GROUP_BY;}
"in " {return TK_IN;}
"order by" {return TK_ORDER_BY;}
">" {return '>';}
"<" {return '<';}
"=" {return '=';}
"!" {return '!';}
"*" {return '*';}
"'" {return '\'';}
"(" { return '('; }
")" { return ')'; }
">=" {return TK_GREATER_OR_EQUAL;}
"<=" {return TK_LESS_OR_EQUAL;}
"!=" {return TK_NOT_EQUALS; }
";" { return TK_SEMICOLON;}
"and" {return TK_AND;}
"or" {return TK_OR;}
"null" {return TK_NULL;}
"desc" {return TK_DESC;}
"asc" {return TK_ASC;}
"not" {return TK_NOT;}
\n { return TK_EOL;}
{DIGIT}+ { yylval.int_t = atoi(yytext); return TK_LIT_INT;}
{DIGIT}+"."{DIGIT}+ { yylval.float_t = atof(yytext); return TK_LIT_FLOAT; }
[a-zA-Z]({DIGIT}|[a-zA-Z_0-9]|_)* { yylval.string_t = strdup(yytext); 
return TK_ID;}
\'.*\' { yylval.string_t = strdup(yytext); return TK_LIT_STRING; }
. {printf("Invalid character %c, line %d\n", yytext[0], yylineno);}
%%
