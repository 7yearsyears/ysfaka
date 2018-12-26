#!/bin/bash
while true
do
    php ./pay/chenpay/wxPay.php
    php ./pay/chenpay/aliPay.php
    sleep 10
done