#!/bin/bash
#simple manager script to ensure most upto date version of repository is being used and to upload changes at end of session

staging_path="C/Learn_C_The_Hard_Way"
current_git_token=""

echo 'To start session type s'
echo 'To end session type e'

read user_input

if [ "$user_input"  = "s" ]; then
	echo "Start session"
	cd $staging_path
	ls -alt
	git pull
	$SHELL
else
	echo "End session"
	#https://www.cyberciti.biz/faq/xclip-linux-insert-files-command-output-intoclipboard/
	echo $current_git_token | xclip
	xclip -o
	cd $staging_path
	git add *
	git commit -m"update"
	git push
fi

