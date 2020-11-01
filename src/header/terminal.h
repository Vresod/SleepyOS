/* Taken from https://github.com/microNET-OS/microCORE/blob/9109cef7ca7efd0263e68fc2ab2c745db3376dd0/src/HardwareAbstractionLayer/Headers/Terminal.h */
// THIS IS NOT MY CODE.
// THIS IS RIZET'S.
// I'M USING THIS BECAUSE I CAN (BOTH OUR REPOS ARE LICENSED UNDER GPLV3) (FAIR USE)
#pragma once

#include "stddef.h"
#include "stdint.h"

    #define status_pend "$WHITE![$LIGHT_BLUE!-$WHITE!] $LIGHT_GREY!\0"
    #define status_good "$WHITE![$LIGHT_GREEN!+$WHITE!] $LIGHT_GREY!\0"
    #define status_fail "$WHITE![$RED!X$WHITE!] $LIGHT_GREY!\0"
    #define status_eol "\n"

class Terminal {
        static const size_t VGA_WIDTH = 80;
        static const size_t VGA_HEIGHT = 25;

        uint16_t* buffer;

public:
	size_t row;
	size_t column;
    static Terminal &instance();
    void put_entry_at(char c, uint8_t color, size_t x, size_t y);
    void put_char(char c, uint8_t color);
    void write(const char* data, size_t size);
    void write(const char* data);
    void write(int num);
    void println(const char* data = "");
    void shift();
	void clear();
	void setCursor(size_t columnc, size_t rowc);
	bool staticLogo = false;

private:
        Terminal();
        Terminal(Terminal const&);
        void operator=(Terminal const&);
};

template<typename T>
Terminal& operator<<(Terminal& term, T data) {
        term.write(data);
        return term;
}

template<typename T>
Terminal* operator<<(Terminal* term, T data) {
        term->write(data);
        return term;
}