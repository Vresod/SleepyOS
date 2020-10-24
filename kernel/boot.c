/* Bootloader for Sleepy OS.
 * I am not 100% sure it's a bootloader
 * though */

#include <efi.h>
#include <efilib.h>
 

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable){
    EFI_STATUS Status;
    EFI_INPUT_KEY Key;
     ST = SystemTable;
    Status = ST->ConOut->OutputString(ST->ConOut, L"Welcome to SleepyOS\n\r");
    Status = ST->ConOut->OutputString(ST->ConOut, L"Please choose an option below.\n\r"); // We can rewrite the status
    // variable twice to print out more information
    if (EFI_ERROR(Status))
        return Status;
    Status = ST->ConIn->Reset(ST->ConIn, FALSE);
    if (EFI_ERROR(Status))
        return Status;
    while ((Status = ST->ConIn->ReadKeyStroke(ST->ConIn, &Key)) == EFI_NOT_READY);
 
    return Status;
}
