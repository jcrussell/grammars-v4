// Author: Mustafa Said Ağca
// License: MIT

lexer grammar SystemVerilogLexer;

// Numbers

REAL_NUMBER : UNSIGNED_NUMBER DOT UNSIGNED_NUMBER | UNSIGNED_NUMBER (DOT UNSIGNED_NUMBER)? EXP SIGN? UNSIGNED_NUMBER ;
fragment EXP : [eE] ;
DECIMAL_NUMBER : UNSIGNED_NUMBER | SIZE? DECIMAL_BASE DECIMAL_VALUE ;
BINARY_NUMBER : SIZE? BINARY_BASE BINARY_VALUE ;
OCTAL_NUMBER : SIZE? OCTAL_BASE OCTAL_VALUE ;
HEX_NUMBER : SIZE? HEX_BASE HEX_VALUE ;
fragment SIGN : [-+] ;
fragment SIZE : NON_ZERO_UNSIGNED_NUMBER ;
fragment NON_ZERO_UNSIGNED_NUMBER : NON_ZERO_DECIMAL_DIGIT (UNDERSCORE | DECIMAL_DIGIT)* ;
UNSIGNED_NUMBER : DECIMAL_DIGIT (UNDERSCORE | DECIMAL_DIGIT)* ;
fragment DECIMAL_VALUE : UNSIGNED_NUMBER | (X_DIGIT | Z_DIGIT) UNDERSCORE* ;
fragment BINARY_VALUE : BINARY_DIGIT (UNDERSCORE | BINARY_DIGIT)* ;
fragment OCTAL_VALUE : OCTAL_DIGIT (UNDERSCORE | OCTAL_DIGIT)* ;
fragment HEX_VALUE : HEX_DIGIT (UNDERSCORE | HEX_DIGIT)* ;
fragment DECIMAL_BASE : APOSTROPHE [sS]? [dD] ;
fragment BINARY_BASE : APOSTROPHE [sS]? [bB] ;
fragment OCTAL_BASE : APOSTROPHE [sS]? [oO] ;
fragment HEX_BASE : APOSTROPHE [sS]? [hH] ;
fragment NON_ZERO_DECIMAL_DIGIT : [1-9] ;
fragment DECIMAL_DIGIT : [0-9] ;
fragment BINARY_DIGIT : X_DIGIT | Z_DIGIT | [01] ;
fragment OCTAL_DIGIT : X_DIGIT | Z_DIGIT | [0-7] ;
fragment HEX_DIGIT : X_DIGIT | Z_DIGIT | [0-9a-fA-F] ;
fragment X_DIGIT : [xX] ;
fragment Z_DIGIT : [zZ?] ;
//UNBASED_UNSIZED_LITERAL : APOSTROPHE [01xXzZ] ;
fragment DOT : '.' ;
fragment APOSTROPHE : '\'' ;

// Strings

STRING_LITERAL : DOUBLE_QUOTE ~["\r\n]* DOUBLE_QUOTE ;
fragment DOUBLE_QUOTE : '"' ;

// Comments

ONE_LINE_COMMENT : DOUBLE_SLASH COMMENT_TEXT NEWLINE -> channel(HIDDEN) ;
BLOCK_COMMENT : SLASH_ASTERISK COMMENT_TEXT ASTERISK_SLASH -> channel(HIDDEN) ;
fragment COMMENT_TEXT : .*? ;
fragment DOUBLE_SLASH : '//' ;
fragment SLASH_ASTERISK : '/*' ;
fragment ASTERISK_SLASH : '*/' ;
fragment NEWLINE : CARRIAGE_RETURN? LINE_FEED ;

// Identifiers

ESCAPED_IDENTIFIER : BACKSLASH ASCII_PRINTABLE_EXCEPT_SPACE+ WHITE_SPACE ;
SIMPLE_IDENTIFIER : (LETTER | UNDERSCORE) (LETTER | UNDERSCORE | DECIMAL_DIGIT | DOLLAR_SIGN)* ;
SYSTEM_TF_IDENTIFIER : DOLLAR_SIGN (LETTER | UNDERSCORE | DECIMAL_DIGIT | DOLLAR_SIGN) (LETTER | UNDERSCORE | DECIMAL_DIGIT | DOLLAR_SIGN)* ;
fragment ASCII_PRINTABLE_EXCEPT_SPACE : [\u0021-\u007e] ;
fragment UNDERSCORE : '_' ;
fragment DOLLAR_SIGN : '$' ;
fragment BACKSLASH : '\\' ;
fragment LETTER : [a-zA-Z] ;

// White space

WHITE_SPACE_REGION : WHITE_SPACE+ -> channel(HIDDEN) ;
fragment WHITE_SPACE : SPACE | TAB | CARRIAGE_RETURN | LINE_FEED ;
fragment SPACE : ' ' ;
fragment TAB : '\t' ;
fragment CARRIAGE_RETURN : '\r' ;
fragment LINE_FEED : '\n' ;

// Time literal

TIME_LITERAL : TIME_NUMBER TIME_UNIT ;
fragment TIME_NUMBER : '1' | '10' | '100' ;
fragment TIME_UNIT : [mnpf]? 's' ;
