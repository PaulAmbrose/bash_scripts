#!/bin/bash

touch $PWD/temp_name
file_ext=".c"

echo "Enter executable file to be run"
read executable

filename_and_ext=$executable$file_ext
mv $PWD/temp_name $PWD/$filename_and_ext

file=$PWD/$filename_and_ext
echo "#include <stdio.h>" >> $file
echo "" >> $file
echo "//program description" >> $file
echo "" >> $file
echo "" >> $file
echo "int main(int argc, char *argv[])" >> $file
echo "{" >> $file
echo "">> $file
echo "	return 0;">> $file
echo "">> $file
echo "}" >> $file

chmod 775 $filename_and_ext
