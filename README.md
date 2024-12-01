# x86-to-C-interface

## Getting Started

First, open cmd in respective root folder:

```bash
nasm -f win64 -o asmfile.obj asmfile.asm
gcc -m64 cfile.c asmfile.obj -o program.exe
program.exe
```
