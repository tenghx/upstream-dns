#!/usr/bin/env bash

ACCELERATED_CHINA='https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf'
APPLE_CHINA='https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf'
#GOOGLE_CHINA='https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf'

DEFAULT_DNS='https://1.1.1.1/dns-query\nhttps://[2606:4700:4700::1001]/dns-query'
CHINA_DNS='s#^.*$#\n[/&]https://223.5.5.5/dns-query https://[2400:3200:baba::1]/dns-query#g'
#EXCLUDED='\n[/g.cn/gkecnapps.cn/google.cn/googleapis.cn/googlecnapps.cn/gstatic.cn/gstaticcnapps.cn/]#'

OUTFILE='upstream_dns.conf'

mkdir -p publish
cd publish

printf $DEFAULT_DNS > $OUTFILE
curl $ACCELERATED_CHINA | awk -F/ 'BEGIN{ORS="/"} {print $2}' | sed -r "$CHINA_DNS" >> $OUTFILE
curl $APPLE_CHINA | awk -F/ 'BEGIN{ORS="/"} {print $2}' | sed -r "$CHINA_DNS" >> $OUTFILE
#curl $GOOGLE_CHINA | awk -F/ 'BEGIN{ORS="/"} {print $2}' | sed -r "$CHINA_DNS" >> $OUTFILE
#printf $EXCLUDED >> $OUTFILE