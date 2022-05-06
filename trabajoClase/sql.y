%{
    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;

    void yyerror(const char * err){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, err);
    }
%}

%union{
    const char* string_t;
    int int_t;
    float float_t;
}

%token<string_t> TK_ID TK_LIT_STRING
%token<int_t> TK_LIT_INT
%token<float_t> TK_LIT_FLOAT
%token TK_SELECT TK_UPDATE TK_DELETE TK_INSERT TK_WHERE TK_GROUP_BY TK_IN TK_FROM TK_ORDER_BY
%token TK_AND TK_OR TK_NOT_EQUALS TK_NULL TK_DESC TK_LESS_OR_EQUAL TK_ASC TK_NOT TK_EOL TK_GREATER_OR_EQUAL  TK_SEMICOLON TK_SET TK_INTO TK_VALUES

%%
input: sql_statement_list
    ;


sql_statement_list: sql_statement_list statement ';'
    | statement ';'
    ;

statement:  select_statement
        |   update_statement
        |   delete_statement
        |   insert_statement
        ;

select_statement:   TK_SELECT expr_list TK_FROM TK_ID where_opt groupby_opt orderby_opt;

update_statement:   TK_UPDATE TK_ID TK_SET expr_list where_opt orderby_opt;

delete_statement:   TK_DELETE TK_FROM TK_ID where_opt ;

insert_statement:   TK_INSERT TK_INTO TK_ID '(' expr_list ')' TK_VALUES '(' expr_list ')';

expr_list:  expr 
        |   expr_list ',' expr
        |   '*'
        ;

expr:   expr TK_IN '('select_statement')'
    |   expr TK_IN '('expr_list')'
    |   TK_ID
    |   TK_LIT_INT
    |   TK_LIT_FLOAT
    |   TK_LIT_STRING
    |   expr '+' expr
    |   expr '-' expr
    |   expr '*' expr
    |   expr '/' expr
    |   expr TK_OR expr
    |   expr TK_AND expr
    |   expr '<' expr
    |   expr '>' expr
    |   expr TK_GREATER_OR_EQUAL expr
    |   expr TK_LESS_OR_EQUAL expr
    |   expr '=' expr
    |   expr TK_NOT_EQUALS expr
    ;


groupby_opt: 
    | TK_GROUP_BY TK_ID
    ;

orderby_opt:
    | TK_ORDER_BY expr_list orderby_param
    ;    

orderby_param: /* nil */
    |   TK_DESC
    |   TK_ASC
    ;


where_opt: 
    | TK_WHERE expr
    ;
%%

