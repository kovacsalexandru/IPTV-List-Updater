##!/bin/sh
# 18.03.2014 testi: added
# 09.04.2014 szudena: fix Player URL
# 25.04.2014 nobody28: fix Bouquetname for Ver. 1.60
# 26.04.2014 nobody28: remove teledunet.cks
# 10.05.2014 testi: fix ID0
# 16.05.2014 testi/szudena: changes id0 to the old format
# 23.05.2014 testi: fix ID0
# 24.05.2014 szudena: changes E+13 to E+12 due to weppage changes
# 02.09.2014 Nobody28: fix ID0
#Get time_player
#
curl -c "teledunet.cks" "http://www.teledunet.com" > /dev/null 2>&1
id0=`curl -A "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14" -b "teledunet.cks" -e "http://www.teledunet.com" "http://www.teledunet.com/mobile/?con" 2>/dev/null | tr -d '\r' | grep 'var aut='`
#echo $id0

id0=`echo $id0 | sed -e "s/var aut='?id0=//g" | sed -e "s/';//g" | sed -e "s/\n//g"`

echo $id0
#
#now let`s update the id0 in the channellist
#
sed -i "s/id0=[0-9]\{12\}/id0="$id0/g /etc/enigma2/userbouquet.ilu_teledunet.tv
#
#now reload servicelist
wget -q -O - http://127.0.0.1/web/servicelistreload?mode=2 > /dev/null 2>&1
echo "id0 updated "
#
rm -f teledunet.cks
exit 0  
