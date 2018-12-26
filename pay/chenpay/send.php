<?php
require_once '../inc.php';


$orderid = $payDao->req->get('orderid');
if (!$orderid) exit();
//查询订单是否存在
$order = (new \YS\app\libs\Model())->select('s.status')->from('orders s')->where(array('fields' => 'orderid=?', 'values' => array($orderid)))->fetchRow();
exit(json_encode($order));