#!/bin/bash

TIMESTAMP=`date +%Y%m%d%H%M%S`
CURRENT_HTML=/var/www/html/${TIMESTAMP}.html
CURRENT_INDEX=/var/www/html/index.html
LN=/bin/ln
RM=/bin/rm
SERVER_LIST=/root/exercise2/server_list

cat <<EOF > $CURRENT_HTML
<html>
<head>
<title>Server Alive Monitor</title>
</head>

<body>
<table width="50%" border="1" cellpading="1" cellspaceing="0" align="center">
<caption><h2>Server Alive Status</h2></caption>
<tr><th>Server IP</th><th>Server Status</th></tr>
EOF

while read SERVERS
do
ping $SERVERS -c 3
if [ $? -eq 0 ]; then
    STATUS=OK
    COLOR=blue
else
    STATUS=FALSE
    COLOR=red
fi
echo "<tr><td>$SERVERS</td><td><font color=$COLOR>$STATUS</td></tr>" >> $CURRENT_HTML
done < $SERVER_LIST

cat <<EOF >> $CURRENT_HTML
</table>
</body>

</html>
EOF
$LN -sf $CURRENT_HTML $CURRENT_INDEX
