#!/bin/bash

declare -a StringArray=("https://github.com/PaulAmbrose/plan.git"_
_"https://github.com/PaulAmbrose/bash_scripts.git"_
_"https://github.com/PaulAmbrose/Learn_C_The_Hard_Way.git" "https://github.com/PaulAmbrose/shaw_Learn_C_The_Hard_Way.git"_
_"https://github.com/PaulAmbrose/python.git", "https://github.com/PaulAmbrose/lambert-cards.git", "https://github.com/PaulAmbrose/PaulAmbrose.git" )








# Iterate the string array using for loop
for val in ${StringArray[@]}; do
   echo $val
done
