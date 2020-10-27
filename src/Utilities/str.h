#pragma once

#include "stddef.h"

size_t strlen(const char* str) { // Checks how long a string is
  size_t length = 0; // Length
  while(str[length /* The length */] && str[length] != '\0' /* Null terminator */){
    // Add one to length
    length++;
  }
  return length; // Return
}
bool strcomp(const char* lhs, const char *rhs) { // Checks if one string is the same as
  // the other
    for (; *lhs; lhs++) {
          if (*lhs != *rhs) {
                  return false;
          }
          rhs++;
   }
   return true;
}
