#include "terminal.h"
#include "macro.h"


#ifndef ARCH
    #define ARCH "$RED!UNKNOWN"
#endif

extern "C" {

void kernel_main() {
    Terminal& terminal = Terminal::instance();
    terminal.setCursor(0, 0);
    terminal << EOL;

    terminal << OP_OK << " SleepyOS has booted." << EOL;
}
}
