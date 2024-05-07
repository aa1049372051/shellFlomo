#!/bin/sh

usage()
{
   # Display Help
   echo "flomo shell app"
   echo
   echo "usage: flomo -k/--key Authorization"
   echo "usage: flomo -t/--tag TAG -m/--msg MSG"
   echo "usage: flomo -m/--msg MSG"
   echo "usage: flomo MSG"
   echo "usage: flomo -h"
   echo
   echo "options:"
   echo "-k/--key 添加 flomo Authorization key"
   echo "-t/--tag flomo 信息标签"
   echo "-m/--msg flomo 信息"
   echo "-h/--help 帮助信息"
   echo "homePath ${EXPAND_PATH}"
   echo 
}

function expand(){
  echo `sh -c "echo $1"`
}

FLOMO_PATH='$HOME/.flomo'
EXPAND_PATH=`expand $FLOMO_PATH`
API_PATH=`expand $EXPAND_PATH/key`
LOG_PATH=`expand $EXPAND_PATH/log`

touchapi() {
    if [ -d "$EXPAND_PATH" ]; then
        touch $API_PATH
    else
        mkdir $HOME/.flomo
        touch $API_PATH
    fi
}

api() {
    if [ -z $1 ]; then
        API=`head -n 1 $API_PATH`
        echo $API
        exit
    fi

    if [ -f "$API_PATH" ]; then
        echo $1 > $API_PATH
    else
        touchapi
        echo $1 > $API_PATH
    fi
}

msg() {
    #   echo send msg $*
    t=`date +%s`
    if [ -f "$API_PATH" ]; then
        API=`head -n 1 $API_PATH`
        MSG=$*
        echo 'send "'$*'" to flomo'
        #curl -s $API -H 'Content-Type: application/json' -d '{"content": "'"$*"'"}' > /dev/null 2>&1
        curl 'https://flomoapp.com/api/v1/memo' \
          -X 'PUT' \
          -H 'accept: application/json, text/plain, */*' \
          -H 'accept-language: zh-CN,zh;q=0.9' \
          -H 'authorization: Bearer '"$API" \
          -H 'cache-control: no-cache' \
          -H 'content-type: application/json;charset=UTF-8' \
          -H 'origin: https://v.flomoapp.com' \
          -H 'pragma: no-cache' \
          -H 'referer: https://v.flomoapp.com/' \
          -H 'sec-ch-ua: "Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"' \
          -H 'sec-ch-ua-mobile: ?0' \
          -H 'sec-ch-ua-platform: "Windows"' \
          -H 'sec-fetch-dest: empty' \
          -H 'sec-fetch-mode: cors' \
          -H 'sec-fetch-site: same-site' \
          -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36' \
          --data-raw '{"content":"'"$*"'","created_at":'$t',"source":"web","file_ids":[],"tz":"8:0","timestamp":'$t',"api_key":"flomo_web","app_version":"4.0","platform":"web","webp":"1","sign":"ca1978989f9d06ab505ea9d2476a6c7e"}'
    else
        echo "!!! Please set api first !!!"
        echo 
        usage
        exit 1
    fi
}

tag=
while [ "$1" != "" ]; do
    case $1 in
        -k | --key )            shift
                                api $1
                                exit
                                ;;
        -t | --tag )            shift
                                tag=" #$1"
                                ;;
        -m | --msg )            shift
                                msg $1$tag
                                exit
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     msg $@
                                exit
                                ;;
    esac
    shift
done
usage
