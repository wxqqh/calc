#include <stdio.h>
#include "./gen/lexer.h"
#include "./gen/parser.h"

int main(int argc, char **argv) {
    char *str = "1+1\n";
    // Insert the string into the input stream.
    YY_BUFFER_STATE bufferState = yy_scan_string(str);

    // Parse the string.
    yyparse();

    // flush the input stream.
    yy_delete_buffer(bufferState);

    return 1;
}