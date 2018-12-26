<?php
/**
 * Created by PhpStorm.
 * User: chen
 * Date: 2018/12/26
 * Time: 下午2:15
 */

use YS\app\libs\Model;

require_once __DIR__ . '/../inc.php';

$payconf = $payDao->checkAcp('chenalipay');
if (!$payconf['userid']) $payconf['userid'] = time();

$time = time() - 3 * 60;
$lists = (new Model())->select()->from('orders')->where(array('fields' => '`paytype`="chenalipay" and `status`=0 and `ctime`>' . $time))
    ->orderby('ctime desc')->fetchAll();
$log = '';
if ($payconfig['AliStatus'] > time() && !$lists) return;
try {
    $run = (new \ChenPay\AliPay($payconf['userkey']))->getData(time() % 2 == 1 ? true : false)->DataHandle();
    if ($lists) foreach ($lists as $item) {
        $order = $run->DataContrast($item['cmoney'], $item['ctime'] + 3 * 60, 3, false);
        if ($order) {
            $log .= "支付宝{$order}订单有效！\n";
            $payDao->updateOrder($item['orderid'], 'chenalipay', $order);
        }
        unset($order, $item);// 摧毁变量防止内存溢出
    }
    $log .= "支付宝运行中。。。\n";
    $payconf['userid'] = time() + 2 * 60;

    (new Model())->select()->from('acp')->updateSet([
        'userid' => $payconf['userid']
    ])->where(array('fields' => 'code = "chenalipay"'))->update();
} catch (\ChenPay\PayException\PayException $e) {
    $log .= $e->getMessage() . "\n";
}
file_put_contents(__DIR__ . "/../../logs/chenpay.log", $log, FILE_APPEND);