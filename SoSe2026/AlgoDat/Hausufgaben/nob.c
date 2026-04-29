
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NOB_IMPLEMENTATION
#define NOB_STRIP_PREFIX
#include "nob.h"

Nob_Cmd cmd = { 0 };

#define JAVAC( ) cmd_append( &cmd, "javac" );
#define JAVA( )  cmd_append( &cmd, "java" );

int blatt00( ) {
  nob_log( NOB_INFO, "Blatt00:" );
  nob_log( NOB_INFO, "gehe zu den Aufgabn von Blatt00" );
  set_current_dir( "Blatt00" );

  nob_log( NOB_INFO, "kompiliere die src/Aufgabe0.java" );

  JAVAC( );
  cmd_append( &cmd, "src/Aufgabe0.java" );
  if ( !cmd_run( &cmd ) ) {
    return 1;
  }

  nob_log( NOB_INFO, "führe die src/Aufgabe0.java aus" );

  JAVA( );
  cmd_append( &cmd, "src/Aufgabe0.java" );
  if ( !cmd_run( &cmd ) ) {
    return 1;
  }

  nob_log( NOB_INFO, "src/Aufgabe0.java erfolgreich ausgeführt" );

  return 0;
}

int blatt01( ) {

  nob_log( NOB_INFO, "Blatt01:" );
  nob_log( NOB_INFO, "gehe zu den Aufgabn von Blatt01" );
  set_current_dir( "Blatt01" );

  nob_log( NOB_INFO, "######## Aufgabe 2: Generics ########" );

  nob_log( NOB_INFO, "kompiliere die src/Pair.java" );
  JAVAC( );
  cmd_append( &cmd, "src/Pair.java" );

  if ( !cmd_run( &cmd ) ) {
    return 1;
  }

  nob_log( NOB_INFO, "führe die src/Pair.java aus" );

  JAVA( );
  cmd_append( &cmd, "src/Pair.java" );
  if ( !cmd_run( &cmd ) ) {
    return 1;
  }

  nob_log( NOB_INFO, "src/Pair.java erfolgreich ausgeführt" );

  nob_log( NOB_INFO, "######## Aufgabe 3: Vererbung ########" );

  // Compile all source files in src/
  nob_log( NOB_INFO, "kompiliere alle Aufgabe 3 Java-Dateien" );
  JAVAC( );
  cmd_append( &cmd, "src/Shape.java" );
  cmd_append( &cmd, "src/Vector2D.java" );
  cmd_append( &cmd, "src/Polygon.java" );
  cmd_append( &cmd, "src/ConvexPolygon.java" );
  cmd_append( &cmd, "src/Triangle.java" );
  cmd_append( &cmd, "src/Tetragon.java" );
  cmd_append( &cmd, "src/RegularPolygon.java" );
  if ( !cmd_run( &cmd ) ) {
    nob_log( NOB_ERROR, "Kompilierung der Aufgabe 3 Dateien fehlgeschlagen" );
    return 1;
  }

  nob_log( NOB_INFO, "führe Triangle main aus" );
  JAVA( );
  cmd_append( &cmd, "-cp" );
  cmd_append( &cmd, "src" );
  cmd_append( &cmd, "Triangle" );
  if ( !cmd_run( &cmd ) ) {
    nob_log( NOB_ERROR, "Triangle main fehlgeschlagen" );
    return 1;
  }

  nob_log( NOB_INFO, "führe RegularPolygon main aus" );
  JAVA( );
  cmd_append( &cmd, "-cp" );
  cmd_append( &cmd, "src" );
  cmd_append( &cmd, "RegularPolygon" );
  if ( !cmd_run( &cmd ) ) {
    nob_log( NOB_ERROR, "RegularPolygon main fehlgeschlagen" );
    return 1;
  }

  nob_log( NOB_INFO, "######## Aufgabe 3: Unit Tests (via Maven) ########" );

  // Go back to parent directory for Maven
  set_current_dir( ".." );

  nob_log( NOB_INFO, "führe Maven Tests für Blatt01 aus" );
  Nob_Cmd mvn_cmd = { 0 };
  cmd_append( &mvn_cmd, "mvn" );
  cmd_append( &mvn_cmd, "clean" );
  cmd_append( &mvn_cmd, "test" );
  cmd_append( &mvn_cmd, "-pl" );
  cmd_append( &mvn_cmd, "Blatt01" );
  cmd_append( &mvn_cmd, "-q" );
  if ( !cmd_run( &mvn_cmd ) ) {
    nob_log( NOB_ERROR, "Maven Tests fehlgeschlagen" );
    return 1;
  }

  nob_log( NOB_INFO, "Blatt01 erfolgreich abgeschlossen (Aufgabe 2 & 3)" );

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
    if ( blatt01( ) ) {
      return 1;
    }

  } else if ( sv_eq( blatt, sv_from_cstr( "Blatt00" ) ) ) {
    return blatt00( );
  } else if ( sv_eq( blatt, sv_from_cstr( "Blatt01" ) ) ) {
    return blatt01( );
  } else {
    UNREACHABLE( "keine gültige Aufgabe angegeben" );
  }

  return 0;
}
