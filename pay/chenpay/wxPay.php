<?php
/**
 * Created by PhpStorm.
 * User: chen
 * Date: 2018/12/26
 * Time: 下午2:15
 */

use YS\app\libs\Model;

require_once __DIR__ . '/../inc.php';

$payconf = $payDao->checkAcp('chenwxpay');

$time = time() - 3 * 60;
$lists = (new Model())->select()->from('orders')->where(array('fields' => '`paytype`="chenwxpay" and `status`=0 and `ctime`>' . $time))
    ->orderby('ctime desc')->fetchAll();
$log = '';
try {
    $run = (new \ChenPay\WxPay($payconf['userkey']))->getData($payconf['userid'])->DataHandle();
    if ($lists) foreach ($lists as $item) {
        $order = $run->DataContrast($item['cmoney'], $item['ctime'] + 3 * 60, 3, false);
        if ($order) {
            $log .= "{$order}订单有效！\n";
            $payDao->updateOrder($item['orderid'], 'chenwxpay', $order);
        }
        unset($order, $item);// 摧毁变量防止内存溢出
    }
    $log .= "微信运行中。。。\n";
} catch (\ChenPay\PayException\PayException $e) {
    $log .= $e->getMessage() . "\n";
}
file_put_contents(__DIR__ . "/../../logs/chenpay.log", $log, FILE_APPEND);