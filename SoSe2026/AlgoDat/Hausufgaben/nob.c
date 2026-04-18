
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NOB_IMPLEMENTATION
#define NOB_STRIP_PREFIX
#include "nob.h"

Nob_Cmd cmd = { 0 };

int     blatt00( ) {
  nob_log( NOB_INFO, "Blatt00:" );
  nob_log( NOB_INFO, "gehe zu den Aufgabn von Blatt00" );
  set_current_dir( "Blatt00/src" );

  nob_log( NOB_INFO, "kompiliere die Aufgabe0.java" );

  cmd_append( &cmd, "javac" );
  cmd_append( &cmd, "Aufgabe0.java" );
  if ( !cmd_run( &cmd ) ) {
    return 1;
  }

  nob_log( NOB_INFO, "führe die Aufgabe0.java aus" );

  cmd_append( &cmd, "java" );
  cmd_append( &cmd, "Aufgabe0.java" );
  if ( !cmd_run( &cmd ) ) {
    return 1;
  }

  nob_log( NOB_INFO, "Aufgabe0.java erfolgreich ausgeführt" );

  return 0;
}

int main( int argc, char **argv ) {
  NOB_GO_REBUILD_URSELF( argc, argv );

  nob_set_log_handler( nob_cancer_log_handler );

  if ( argc < 2 ) {  // <-- Geändert von > auf <
    nob_log( NOB_ERROR, "Usage: %s [Blatt]", argv[ 0 ] );
    return 1;
  }

  String_View blatt = sv_from_cstr( argv[ 1 ] );

  if ( sv_eq( blatt, sv_from_cstr( "alle" ) ) ) {
    if ( blatt00( ) ) {
      return 1;
    }

  } else if ( sv_eq( blatt, sv_from_cstr( "Blatt00" ) ) ) {
    return blatt00( );
  } else {
    UNREACHABLE( "keine gültige Aufgabe angegeben" );
  }

  return 0;
}
