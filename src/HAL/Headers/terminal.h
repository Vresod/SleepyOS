/* Terminal class for SleepyOS
 * HEAVILY INSPIRED BY MICRO CORE
 * WRITTEN BY RIZXT 
 
 
 * I did not steal his code. */


#pragma once 


#include "stddef.h"
#include "stdint.h"

  // STATUSES
  #define OP_BAD  "$WHITE![$RED!bad$WHITE!] $LIGHT_GREY!\0"      // When something goes bad
  #define OP_OK   "$WHITE![$GREEN!:)$WHITE!] $LIGHT_GREY!\0"     // When something is ok.
  #define OP_FAIL "$WHITE![$ORANGEfailed$WHITE!] $LIGHT_GREY!\0" // When something failed.
  
  // END OF LINE
  #define EOL     "\n"
