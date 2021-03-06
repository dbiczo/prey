#!/bin/bash
####################################################################
# Prey Report Module - by Tomas Pollak (bootlog.org)
# URL : http://preyproject.com
# License: GPLv3
####################################################################
if [ $connected == 1 ]; then

echo "$STRING_GET_IP"
get_public_ip
add_trace public_ip $public_ip

echo "$STRING_GET_LAN_IP"
get_internal_ip
add_trace internal_ip $internal_ip

echo "$STRING_GET_MAC_AND_WIFI"
get_network_info

# traceroute=`which traceroute` <-- disabled since its TOO DAMN SLOW!
if [ -n "$traceroute" ]; then
	echo "$STRING_TRACE"
	trace_route
fi

echo "$STRING_UPTIME_AND_PROCESS"
get_uptime_and_processes

echo "$STRING_MODIFIED_FILES"
get_modified_files

echo "$STRING_ACTIVE_CONNECTIONS"
get_active_connections

# echo "$STRING_WRITE_EMAIL" // Trash.. saquemoslo despues.
# write_email
# add_trace report_body $report_body
do_report

echo "$STRING_TAKE_IMAGE"
get_images
if [ -f "$picture" ]; then
	add_file picture "$picture"
fi
if [ -f "$screenshot" ]; then
	add_file screenshot "$screenshot"
fi
echo "$STRING_TAKE_IMAGE_DONE"

####################################################################
# all set, lets send the report
####################################################################

echo "$STRING_SENDING_EMAIL"
post_data

else 
	echo "$NO_RUN_CONNECTION"
fi