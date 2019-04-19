#!/bin/bash
#ANDROID_DEVICES="<test device>"
if [ ! -z "$ANDROID_DEVICES" ]; then
    curl -X POST \
      http://10.25.218.114/api/v1/user/devices \
      -H 'Authorization: Bearer 4b7e07db209549419d3d1441449c243d6d0edf08839145b8b30995b965d739ce' \
      -H 'Content-Type: application/json' \
      -d '{"serial":"'$ANDROID_DEVICES'"}'
    response=$(curl -s -X GET   http://10.25.218.114/api/v1/devices/$ANDROID_DEVICES   -H 'Authorization: Bearer 4b7e07db209549419d3d1441449c243d6d0edf08839145b8b30995b965d739ce'   -H 'cache-control: no-cache')
    connect_url=$( jq -r .device.remoteConnectUrl <<< "${response}" )
    echo ${connect_url}
    adb connect ${connect_url}
    echo "Success!"
    sleep 1
    adb devices
fi 
