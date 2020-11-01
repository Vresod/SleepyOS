#include "header/terminal.h"
#include "header/macro.h"

#ifndef ARCH
    #define ARCH "$RED!UNKNOWN"
#endif


extern "C" {

void kernel_main(){
	Terminal& terminal = Terminal::instance();
	terminal.setCursor(0, 0);
	terminal << status_pend << "Loading SleepyOS. If you see this, gg." << status_eol;
}

}