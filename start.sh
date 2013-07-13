#!/bin/sh
ID=`cat /var/www/wechat/tmp/pids/unicorn.pid`
kill $ID
unicorn -c /var/www/wechat/config/unicorn.rb -D -E production
