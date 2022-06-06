#!/bin/bash

touch $PWD/Makefile

echo "Enter executable file to be run"
read executable

file=$PWD/Makefile
echo "CFLAGS=-Wall -g" >> $file
echo "" >> $file
echo "all: clean" $executable >> $file
echo "" >> $file
echo "clean:" >> $file
echo "	rm -f" $executable >> $file
