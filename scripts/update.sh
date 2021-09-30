#!/bin/bash

case ${NETDISCO_HOME-} in '') echo "$0: Need a value in NETDISCO_HOME" >&2; exit 1;; esac

echo -n 'netdisco home: '
echo $NETDISCO_HOME
sleep 2

rm -rf lib/App
cp -r ${NETDISCO_HOME}/lib/App lib/App

rm -rf lib/Dancer
cp -r ${NETDISCO_HOME}/lib/Dancer lib/Dancer

rm -rf lib/auto/share/dist/App-Netdisco/*
cp -r ${NETDISCO_HOME}/share/* lib/auto/share/dist/App-Netdisco/

rm -rf lib/bin/*
cp -r ${NETDISCO_HOME}/bin/* lib/bin/

cat ${NETDISCO_HOME}/Build.PL | sed '/  requires/,$!d' | sed '/  },/,$d' | grep -v SNMP::Info | grep -v requires | sed 's/^   /requires/' | sed 's/,/;/' > cpanfile

git add .
git commit -m 'updated from upstream netdisco'
git push

sleep 3
heroku logs
