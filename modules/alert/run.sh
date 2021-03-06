#!/bin/bash
####################################################################
# Prey Alert Module - by Tomas Pollak (bootlog.org)
# URL : http://preyproject.com
# License: GPLv3
####################################################################

if [ $alert_user == 'y' ]; then
	echo "$STRING_SHOW_ALERT"
	alert_user
fi

if [ $change_wallpaper == 'y' ]; then
	echo "$STRING_CHANGE_WALLPAPER"
	# we need the full path to the files (and we'll asume the script is being run from prey's folder)
	wallpaper=`pwd`/$wallpaper
	change_wallpaper
fi

