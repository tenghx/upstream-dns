#!/usr/bin/env bash

# accelerated_china
ACCELERATED_CHINA_URL='https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf'
# apple_china
APPLE_CHINA_URL='https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf'
# google_china
GOOGLE_CHINA_URL='https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf'

HEAD_FILTER_PATTERN='s#^server=/##g'
TAIL_FILTER_PATTERN='s#/114.114.114.114$##g'

UPSTREAM_DNS_PATTERN_1='s#^.*$#https://1.1.1.1/dns-query\nhttps://[2606:4700:4700::1001]/dns-query\n[/&]https://223.5.5.5/dns-query\ https://[2400:3200:baba::1]/dns-query#g'
UPSTREAM_DNS_PATTERN_2='s#^.*$#\n[/&]https://223.5.5.5/dns-query\ https://[2400:3200:baba::1]/dns-query#g'

UPSTREAM_DNS_SPECIAL='\n[/g.cn/gkecnapps.cn/google.cn/googleapis.cn/googlecnapps.cn/gstatic.cn/gstaticcnapps.cn/]#'

UPSTREAM_DNS_FILE='upstream_dns.conf'

mkdir -p publish
cd publish

curl $ACCELERATED_CHINA_URL | sed '/#/d' | sed -r $HEAD_FILTER_PATTERN | sed -r $TAIL_FILTER_PATTERN | sed '#^$#d' | sort -u | tr "\n" "/" | sed -r $UPSTREAM_DNS_PATTERN_1 > $UPSTREAM_DNS_FILE
curl $APPLE_CHINA_URL | sed '/#/d' | sed -r $HEAD_FILTER_PATTERN | sed -r $TAIL_FILTER_PATTERN | sed '#^$#d' | sort -u | tr "\n" "/" | sed -r $UPSTREAM_DNS_PATTERN_2 >> $UPSTREAM_DNS_FILE
#curl $GOOGLE_CHINA_URL | sed '/#/d' | sed -r $HEAD_FILTER_PATTERN | sed -r $TAIL_FILTER_PATTERN | sed '#^$#d' | sort -u | tr "\n" "/" | sed -r $UPSTREAM_DNS_PATTERN_2 >> $UPSTREAM_DNS_FILE
printf $UPSTREAM_DNS_SPECIAL >> $UPSTREAM_DNS_FILE
