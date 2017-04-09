%{
  open Ast;;
%}

/* literals and identifiers */
%token <int> INT
%token <float> FLOAT
%token <string> IDENT
%token <string> STR

/* keywords */
%token USING, AS
%token LET, MATCH, WHEN, WHERE

/* operators */
%token DOT, COMMA, BANG, COLON, SEMICOLON
%token ASSIGN, SET, FATARROW, ARROW, PIPE, APPLY
%token LPAREN, RPAREN, LCURLY, RCURLY
%token EQ, NEQ, LT, GT, LEQ, GEQ
%token ADD, SUB, MUL, DIV

/* utility */
%token EOF

%start main
%type <Ast.ast option> main

%%

main:
  | EOF { None }
  | v = expr; EOF { Some v }

expr:
  /* literals */
  | s = STR { String s }
  | n = INT { Number (`Int n) }
  | n = FLOAT { Number (`Float n) }


  | lhs=expr; op=binary_op; rhs=expr; { BinaryOp (op, lhs, rhs) }

%inline binary_op:
  | ADD { Addition }
  | SUB { Subtraction }
  | MUL { Multiplication }
  | DIV { Division }

  | EQ { Equal }
  | NEQ { NotEqual }

  | GT { GreaterThan }
  | LT { LessThan }
  | GEQ { GreaterThanEqual }
  | LEQ { LessThanEqual }
;
