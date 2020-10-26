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

// Terminal Class
class Terminal {
  // height and width
  static const size_t VGA_WIDTH = 80;
  static const size_t VGA_HEIGHT = 25;
  
  // the buffer
  uint16_t* buffer;

public: // Public variables / functions
  static Terminal &instance(); // Create an instance of the terminal
  void put_entry_at(char c, uint8_t color, size_t x, size_t y);
  void put_char(char c, uint8_t color);
  void write(const char* data, size_t size);
  void write(const char* data);
  void write(int num);
  void println(const char* data =""); // Print stuff aswell as a \n
  void shift();
    void clear();
    void setCursor(size_t columnc, size_t rowc);
    bool staticLogo = false;

private: // Private functions
    Terminal();
    Terminal(Terminal const&);
    void operator=(Terminal const&);
};


// define stuffs
template<typename T>
Terminal& operator<<(Terminal& term, T data){
  term.write(data);
  return term;
}

template<typename T>
Terminal* operator<<(Terminal* term, T data){
  term->write(data);
  return term;
}



