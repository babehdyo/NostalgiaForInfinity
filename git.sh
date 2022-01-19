#!/bin/bash

ROOT_PATH="/home/babehdyo"
NFI_PATH="${ROOT_PATH}/NostalgiaForInfinity/NostalgiaForInfinityX.py"
FT_PATH="${ROOT_PATH}/freqtrade/user_data/strategies/NostalgiaForInfinityX.py"
FT_PATHC="${ROOT_PATH}/freqtrade/user_data/data"
FT_PATHH="${ROOT_PATH}/freqtrade/a.py"
TG_TOKEN=""
TG_CHAT_ID=""

cd $(dirname ${NFI_PATH})

GITRESPONSE=`git pull`
UPDATED='Already up to date.'

echo $GITRESPONSE;
if [[ $GITRESPONSE != $UPDATED ]]; then
        # sleep 120

        GITCOMMITTER=`git show -s --format='%cn'`
        GITVERSION=`git show -s --format='%h'`
        GITCOMMENT=`git show -s --format='%s'`
        
        cp NostalgiaForInfinityX.py ${FT_PATH}
        cp configs/blacklist-binance.json ${FT_PATHC}
        cp configs/pairlist-volume-binance-usdt.json ${FT_PATHC}
        cp configs/exampleconfig.json ${FT_PATHC}
	      cp configs/exampleconfig-rebuy.json ${FT_PATHC}
	      curl -s --data "text=🆕 <b>New <i>NostalgiaForInfinity</i> version</b> by <code>${GITCOMMITTER}</code>!%0ACommit: <code>$GITVERSION</code>%0AComment: <code>${GITCOMMENT}</code>%0A⏳ Please wait for reload..." \
                --data "parse_mode=HTML" \
                --data "chat_id=$TG_CHAT_ID" \
                "https://api.telegram.org/bot${TG_TOKEN}/sendMessage"
        /usr/bin/docker restart dryrun > /dev/null &&
	      curl -s --data "text=🆗 NFI reload has been completed!" \
                --data "parse_mode=HTML" \
                --data "chat_id=$TG_CHAT_ID" \
                "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" 
        # docker system prune --volumes -af > /dev/null &&
        # sleep 20 
fi
