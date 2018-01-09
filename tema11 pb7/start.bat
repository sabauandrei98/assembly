nasm -fobj tema.asm
nasm -fobj main.asm

alink main.obj tema.obj -oPE -subsys console -entry start
main

pause