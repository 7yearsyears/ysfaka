getGoodsList($("#sc-cid").val())

$("#sc-cid").change(function () {
    getGoodsList()
});

function getGoodsList() {
    if ($("#sc-cid").val() == 0) return;
    $.ajax({
        url: '/index/typegd',
        type: 'POST',
        dataType: 'json',
        data: {cid: $("#sc-cid").val()},
        beforeSend: function () {
            layer.load(1);
            $('#glist').html();
        },
        success: function (result) {
            if (result.status == '1') {
                $('#glist').html("<option value=\"0\">请选择商品</option>" + result.html);
                getGoodsInfo($("#glist").val())
                layer.closeAll();
            } else {
                $('#glist').html("<option value=\"0\">该分类下没有商品</option>");
                layer.closeAll();
            }
        }

    });
}

$("#glist").change(function () {
    getGoodsInfo($(this).val())
});


//查询商品详情
function getGoodsInfo(id) {
    if (id == 0) return;
    $(".ajaxdiv").remove();
    $('#gdinfo').html()
    $.ajax({
        url: '/index/getGoodsInfo',
        type: 'POST',
        dataType: 'json',
        data: {id: id},
        beforeSend: function () {
            layer.load(1);
        },
        success: function (result) {
            layer.closeAll();
            if (result.status == 0) {
                layer.alert('查询失败', {icon: 2})
            } else {
                $('#gdinfo').html(result.data.info.cont)
                $('#okshop').before(result.data.html)
                $('#money').val(result.data.info.gmoney)
                $('#kuc').val(result.data.info.kuc)
            }

        }
    });
}

/**
 * 提交订单
 */
function okOrder() {
    var gid = $("#glist").val();
    var number = $("#number").val();
    var account = $("#account").val();
    var chapwd = $("#chapwd").val();
    var ipu1 = $("#ipu1").val();
    var ipu2 = $("#ipu2").val();
    var ipu3 = $("#ipu3").val();
    var ipu4 = $("#ipu4").val();
    $.ajax({
        url: '/index/postOrder',
        type: 'POST',
        dataType: 'json',
        data: {
            gid: gid,
            number: number,
            account: account,
            chapwd: chapwd,
            ipu1: ipu1,
            ipu2: ipu2,
            ipu3: ipu3,
            ipu4: ipu4
        },
        beforeSend: function () {
            layer.load(1);
        },
        success: function (result) {
            layer.closeAll();
            if (result.status == 0) {
                layer.alert(result.msg, {icon: 2})
            } else if (result.status == 2) {
                layer.alert(result.msg, {icon: 6})
            } else {
                $('#okshop').before(result.data)
                $('#okshop').remove()
            }

        }
    });
}

/**
 * chenPay
 */
var countdownHtml,Countdown,CheckPay
function pay(type,id,url) {
    var m = 2, s = 59;
    var html = "<div class='tpl-portlet'><style>#qrcode img{display: inline!important;width: 300px}</style>" +
        "<div id='qrcode' style='margin-top:10px;text-align: center'></div>"
    html += "<p>倒计时：<span id='countTime'></span>，请务必在3分钟内扫码进行支付</p>"
    if(type == 1){
        html += "<p>支付宝扫码后请输入商品相应支付金额</p>"
    }else{
        html += "<p>微信扫码后请输入商品相应支付金额</p>"
    }
    html += "<p>支付完成后大概一分钟内完成</p>"
    html += "<div class=\"am-u-sm-push-5\"><a onclick=\"delChenPay('"+id+"')\" class=\"am-btn am-btn-default\">取消支付</a></div>"
    html += "</div>"
    $(".pay").show()
    $("#pay-con").html(html)

    SettingChenPay(id,type)
    countdownHtml = document.getElementById("countTime");
    getCountdown()
    Countdown = setInterval(function () {
        getCountdown()
    }, 1000);
    checkChenPay(id)
    CheckPay = setInterval(function () {
        checkChenPay(id)
    }, 3000);
    new QRCode(document.getElementById("qrcode"), url)

    function getCountdown() {
        countdownHtml.innerHTML = "<span>" + (m >= 10 ? m : '0' + m) + "</span>:<span>" + (s >= 10 ? s : '0' + s) + "</span>";
        if (m == 0 && s == 0) {
            clearInterval(Countdown)
            clearInterval(CheckPay)
            $(".pay").hide()
            layer.alert("已取消支付", {icon: 2})
        } else if (m >= 0) {
            if (s > 0) {
                s--;
            } else if (s == 0) {
                m--, s = 59;
            }
        }
    }

    function checkChenPay(id) {
        $.ajax({
            type: "GET",
            dataType: 'json',
            url: "/pay/chenpay/send.php?orderid=" + id + "&" + Math.random(),
            success: function (data) {
                if (data.status > 0) {
                    location.href = "/chaka?oid=" + id
                }
            }
        });
    }
    function SettingChenPay(id,type) {
        $.ajax({
            type: "GET",
            url: "/index/setOrder?id=" + id + "&type=" + (type==1?'chenalipay':'chenwxpay')
        });
    }
}

function delChenPay(id) {
    $.ajax({
        type: "GET",
        url: "/index/delOrder?id=" + id
    });
    location.reload()
}
// end

/**
 * 查询订单详情
 */

function getOrders() {
    var account = $('#account').val();
    var type = $('#otype').val();
    var chapwd = '';
    if (account == "") {
        layer.alert('请输入查询账号', {icon: 2});
        return;
    }
    if (type == 0) {
        layer.prompt({title: '自动发卡订单需要查询密码', formType: 1}, function (pass, index) {
            layer.close(index);
            if (pass == "") {
                layer.alert('请输入查询密码', {icon: 2});
                return;
            }
            chapwd = pass;
            sendOrder(account, type, chapwd);
        });
    } else {
        sendOrder(account, type, chapwd);
    }


}

function sendOrder(account, type, chapwd) {
    $.ajax({
        url: '/chaka/orderList',
        type: 'POST',
        dataType: 'json',
        data: {account: account, otype: type, chapwd: chapwd},
        beforeSend: function () {
            $('#ordcont').html('');
            layer.load(1);
        },
        success: function (result) {
            layer.closeAll();
            if (result.status == 0) {
                layer.alert(result.msg, {icon: 2})
            } else {
                $('#ordcont').html(result.data)
            }

        }
    });
}

function orderInfo(id) {
    $.ajax({
        url: '/chaka/orderInfo',
        type: 'POST',
        dataType: 'json',
        data: {id: id},
        beforeSend: function () {
            layer.load(1);
        },
        success: function (result) {
            layer.closeAll();
            if (result.status == 0) {
                layer.alert(result.msg, {icon: 2})
            } else {
                layer.open({
                    type: 1,
                    title: '订单详情',
                    skin: 'layui-layer-rim', //加上边框
                    area: ['420px', '240px'], //宽高
                    content: result.data.info
                });
            }

        }
    });
}

// ==========================
// 头部导航隐藏菜单
// ==========================

function navHover() {
    $('.tpl-left-nav').toggle();
    $('.tpl-content-wrapper').toggleClass('tpl-content-wrapper-hover');
}