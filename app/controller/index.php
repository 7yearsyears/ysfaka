<?php

namespace YS\app\controller;

use YS\app\libs\Controller;
use Endroid\QrCode\QrCode;

/**首页控制器
 * Class index
 * @package YS\app\controller
 */
class index extends Controller
{
    public function index()
    {
        //总订单
        $data['ctOrder'] = $this->model()->select()->from('orders')->where(array('fields' => '`status` > 0'))->count();
        $cmoney = $this->model()->select(['cmoney' => 'cmoney'])->from('orders')->where(array('fields' => '`status` > 0 '))->sum();
        $data['ctMoney'] = $cmoney['cmoney'];
        //已完成订单
        $data['okOrder'] = $this->model()->select()->from('orders')->where(array('fields' => '`status` = 3'))->count();
        $day1 = date('Y-m-d');
        $day2 = $this->config['ctime'];
        $data['ctime'] = diffBetweenTwoDays($day1, $day2);
        $class = $this->model()->select()->from('gdclass')->orderby('ord DESC')->fetchAll();
        $data = [
            'class' => $class,
            'data' => $data
        ];
        $this->put('index.php', $data);
    }

    public function typegd()
    {
        $data = $this->getReqdata($_POST) ? $this->getReqdata($_POST) : 0;//分类id
        $lists = $this->model()->select()->from('goods')->where(array('fields' => 'cid=? and is_ste = 1', 'values' => array($data['cid'])))->orderby('ord desc')->fetchAll();
        $html = "";
        if ($lists) {
            foreach ($lists as $key=>$v) {
                $html .= "<option value=" . $v['id'] . " ".($key==0?'selected':'').">" . $v['gname'] . "</option>";
            }
            echo json_encode(array('status' => 1, 'html' => $html));
            exit;
        }
        echo json_encode(array('status' => 0, 'html' => $html));
        exit;
    }

    public function getGoodsInfo()
    {
        $id = $this->req->post('id');
        $data = $this->model()->select()->from('goods')->where(array('fields' => 'id=? and is_ste = 1', 'values' => array($id)))->fetchRow();
        if (!$data) resMsg(0);
        //判断是否是自动发卡
        if ($data['type'] == 0) {
            $html = "<div class=\"am-form-group ajaxdiv\">
                                      <label for=\"account\" class=\"am-u-sm-2 am-form-label\">邮箱</label>
                                        <div class=\"am-u-sm-10\">
                                            <input type=\"text\" id=\"account\" class=\"am-form-field am-round\"
                                                 placeholder=\"请仔细输入正确邮箱，接收卡密使用\"   value=\"\">
                                        </div>
                     </div>
                     <div class=\"am-form-group ajaxdiv\">
                                        <label for=\"chapwd\" class=\"am-u-sm-2 am-form-label\">查询密码</label>
                                        <div class=\"am-u-sm-10\">
                                            <input type=\"text\" id=\"chapwd\" class=\"am-form-field am-round\"
                                                placeholder=\"请仔细查询密码，作为查询重要依据\"    value=\"\">
                                        </div>
                                    </div>";

        }else{
            //手工订单
            $html = "<div class=\"am-form-group ajaxdiv\"><label for=\"account\" class=\"am-u-sm-2 am-form-label\">".$data['onetle']."</label>
                                        <div class=\"am-u-sm-10\">
                                            <input type=\"text\" id=\"account\" class=\"am-form-field am-round\"
                                                    value=\"\">
                                        </div>
                     </div>";
            $ripu = explode(',',$data['gdipt']);
            if($ripu[0]){
                $ipu = 1;
                foreach ($ripu as $v){
                    $html.="<div class=\"am-form-group ajaxdiv\"><label for=\"ipu".$ipu."\" class=\"am-u-sm-2 am-form-label\">".$v."</label>
                                        <div class=\"am-u-sm-10\">
                                            <input type=\"text\" id=\"ipu".$ipu."\" class=\"am-form-field am-round\"
                                                    value=\"\">
                                        </div>
                     </div>";
                    $ipu = $ipu+1;
                }

            }
        }
        $res = [
            'info' => $data,
            'html' => $html
        ];
        resMsg(1, $res);
    }

    /**
     * 删除订单
     */
    public function delOrder()
    {
        $get = $this->getReqdata($_GET);
        if($get['id'] ==""){
            resMsg(0,null,'');
        }

        $this->model()->select()->from('orders')->where(array('fields' => '`status`=0 and `orderid`="'.$get['id'].'"'))->delete();
    }

    /**
     * 删除订单
     */
    public function setOrder()
    {
        $get = $this->getReqdata($_GET);
        if($get['id'] ==""||$get['type'] ==""){
            resMsg(0,null,'');
        }

        $this->model()->select()->from('orders')->updateSet([
            'paytype' => $get['type']
        ])->where(array('fields' => '`status`=0 and `orderid`="'.$get['id'].'"'))->update();
    }
    /**
     * 提交订单
     */
    public function postOrder()
    {
        $post = $this->getReqdata($_POST);
        $post['number'] = intval($post['number']);
        if($post['gid'] =="" || intval($post['number']) <=0 || $post['account'] == ""){
            resMsg(0,null,'充值账号、数量、商品不能为空，请仔细填写');
        }
        $goods = $this->model()->select()->from('goods')->where(array('fields' => 'id=?', 'values' => array($post['gid'])))->fetchRow();
        if(!$goods || $goods['is_ste'] == 0) resMsg(0,null,'商品不存在或已下架');
        if($goods['kuc'] < $post['number'])resMsg(0,null,'库存不足');


        $payset = $this->model()->select()->from('acp')->where(array('fields' => ' is_ste > 0', 'values' => array()))->fetchAll();

        if($payset[0]['code']=='chenalipay'||$payset[0]['code']=='chenwxpay'){
            $time = time() - 3 * 60;
            $order = $this->model()->select()->from('orders')->where(array('fields' => '`paytype`="'.$payset[0]['code'].'" and `status`=0 and `ctime`>'.$time))
                ->fetchRow();
            if($order)resMsg(0,null,'正在排队，请稍后');
        }
        /**
         * 自动发卡
         */
        if($goods['type'] == 0){
            if($post['chapwd'] == ""){
                resMsg(0,null,'查询密码不能为空');
            }
            if(!filter_var($post['account'],FILTER_VALIDATE_EMAIL)){
                resMsg(0,null,'邮箱格式错误，未确保能够收到邮件提醒请仔细填写');
            }
            $orderid = $this->zdOrder($post,$goods);
        }else{
            $ripu = explode(',',$goods['gdipt']);
            $ctnum = $ripu[0] != "" ?count($ripu):0;
            if($ctnum >0){
                if(trim($post['ipu1']) == "")resMsg(0,null,$ripu[0].'不能为空');
            }
            if($ctnum >1){
                if(trim($post['ipu2']) == "")resMsg(0,null,$ripu[1].'不能为空');
            }
            if($ctnum >2){
                if(trim($post['ipu3']) == "")resMsg(0,null,$ripu[2].'不能为空');
            }
            if($ctnum >3){
                if(trim($post['ipu4']) == "")resMsg(0,null,$ripu[3].'不能为空');
            }
            $orderid = $this->sgOrder($post,$goods);

        }

        $html = "<div class=\"am-form-group\" id=\"sgoktips\">
                <div class=\"am-alert am-alert-success\"><strong>订单保存成功，请点击以下方式在线付款：</strong></div>
                </div>
                <div class=\"am-form-group\">
                <div class=\"am-u-sm-12 am-u-sm-push-2\">";
        /**
         * 支付方式选择
         */
        if($payset){
            foreach ($payset as $v){
                switch ($v['code']){
                    case 'zfbf2f':
                        $html.= "<a  href=\"/pay/index?id=".$orderid."&type=alipay&paycode=".$v['code']."\" class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">支付宝当面付</a>";
                        break;
                    case 'alipay':
                        $html.= "<a  href=\"/pay/index?id=".$orderid."&type=alipay&paycode=".$v['code']."\" class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">支付宝即时到账</a>";
                        break;
                    case 'syzf':
                        $html.= "<a  href=\"/pay/index?id=".$orderid."&type=zfbqr&paycode=".$v['code']."\" class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">支付宝</a>";
                        $html.= "<a  href=\"/pay/index?id=".$orderid."&type=wxqr&paycode=".$v['code']."\" class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">微信</a>";
                        break;
                    case 'chenalipay':
                        $html .= "<a  href=\"javascript:pay(1,'{$orderid}','{$v['email']}');\" class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">支付宝</a>";
                        break;
                    case 'chenwxpay':
                        $html .= "<a  href=\"javascript:pay(2,'{$orderid}','{$v['email']}');\" style='margin-left: 5px' class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">微信</a>";
                        break;
                    case 'chenwxpay':
                        $html .= "<a  href=\"javascript:pay(2,'{$orderid}','{$v['email']}');\" style='margin-left: 5px' class=\"am-btn am-btn-warning am-round am-icon-credit-card-alt\">微信</a>";
                        break;
                }

            }
            $html .= "<a  href=\"javascript:delChenPay('{$orderid}');\" style='margin-left: 5px' class=\"am-btn am-btn-default am-round\">取消</a>";
        }
        $html.= "</div>         
            </div>";



        resMsg(1,$html,'下单成，请支付！');

    }
    public function sgOrder($data,$goods)
    {
        if($goods['checks'] == 0){
            $check =[$data['account'],$goods['id']];
            //检测重复下单
            $order = $this->model()->select()->from('orders')->where(array('fields' => 'account = ? AND gid = ? AND ( `status` > 0 AND `status` <> 4  )', 'values' => $check))->fetchRow();
            if($order)resMsg(0,null,'本商品限制重复下单，一号一次');
        }
        $info = $goods['onetle'].':'.$data['account'];
        $ripu = explode(',',$goods['gdipt']);
        $index = 1;
        foreach ($ripu as $value){
            if($value!=""){
                $info.="<br/> ".$value.':'.$data['ipu'.$index];
                $index = $index+1;
            }
        }

        $inadd = [
            'orderid' =>$this->res->getOrderID(),
            'oname' => $goods['gname'].'x'.$data['number'],
            'gid' => $goods['id'],
            'omoney' => $goods['gmoney'],
            'onum' => $data['number'],
            'cmoney' => $goods['gmoney'] * $data['number'],
            'chapwd' => $data['chapwd'],
            'account' => $data['account'],
            'otype' => 1,
            'ctime' => time(),
            'status' => 0,
            'info' => $info
        ];
        $addres = $this->model()->from('orders')->insertData($inadd)->insert();
        if($addres){
            if($goods['gmoney'] == 0){
                resMsg(2,null,'下单成功！');
            }
            return $inadd['orderid'];
        }
        resMsg(0,null,'下单失败！');

    }

    /**自动发卡
     * @param $data
     * @param $goods
     */
    private function zdOrder($data,$goods)
    {
        $inadd = [
            'orderid' =>$this->res->getOrderID(),
            'oname' => $goods['gname'].'x'.$data['number'],
            'gid' => $goods['id'],
            'omoney' => $goods['gmoney'],
            'onum' => $data['number'],
            'cmoney' => $goods['gmoney'] * $data['number'],
            'chapwd' => $data['chapwd'],
            'account' => $data['account'],
            'otype' => 0,
            'ctime' => time(),
            'status' => 0
        ];
        $addres = $this->model()->from('orders')->insertData($inadd)->insert();
        if($addres){
            if($goods['gmoney'] == 0){
                resMsg(2,null,'下单成功！');
            }
            return $inadd['orderid'];
        }
        resMsg(0,null,'下单失败！');

    }
    /**
     * 生产二维码
     */
    public function qrcode()
    {
        $url = $this->req->get('url') ? $this->req->get('url') : 'http://phpke.cn';
        $qrCode = new QrCode($url);
        header('Content-Type: '.$qrCode->getContentType());
        echo $qrCode->writeString();
    }

}