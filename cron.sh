#!/bin/bash
for((i=1;i<=5;i++));do php ./pay/chenpay/wxPay.php;sleep 10;done
for((i=1;i<=5;i++));do php ./pay/chenpay/aliPay.php;sleep 10;done