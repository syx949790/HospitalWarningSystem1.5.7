<%--suppress ALL --%>
<%@ page import="java.util.Date" pageEncoding="utf-8" %>
<html>
<head>
    <title>天津医科大学总医院医疗设备检修预警系统</title>

    <link rel="stylesheet" href="layui/css/layui.css"/>
    <script type="text/javascript" src="jquery/jquery3.4.1.js"></script>
    <script type="text/javascript" src="layui/layui.all.js"></script>
    <script type="text/javascript" src="js/vcode.js"></script>
    <link rel="stylesheet" href="css/vcode.css">
    <script type="text/javascript">
        $(function () {
            createCode(4);
            // alert("test");
        });

        function refreshVcode() {
            createCode(4);
        }

        function register() {
            var uname = $("#uname2").val();
            if (uname.length == 0) {
                layer.tips("用户名不能为空!", "#uname2", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            var upwd2 = $("#upwd2").val();
            if (upwd2.length == 0) {
                layer.tips("密码不能为空!", "#upwd2", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            if (upwd2.length < 6) {
                layer.tips("密码长度应大于6位!", "#upwd2", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            var upwd3 = $("#upwd3").val();
            if (upwd3.length == 0) {
                layer.tips("密码不能为空!", "#upwd3", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            if (upwd3.length < 6) {
                layer.tips("密码长度应大于6位!", "#upwd3", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            if (upwd2 != upwd3) {
                layer.tips("前后密码不一致!", "#upwd3", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            var email = $("#email").val();
            var re = /^[0-9A-Za-z][\.-_0-9A-Za-z]*@[0-9A-Za-z]+(\.[0-9A-Za-z]+)+$/;
            if (email.length == 0) {
                layer.tips("邮箱不能为空!", "#email", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            if (!re.test(email)) {
                layer.tips("邮箱格式不正确!", "#email", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            $.ajax({
                url: "user/register.do",
                method: "post",
                cache: false,
                data: $("#insertForm").serialize(),//表单序列化
                success: function (result) {
                    if (JSON.parse(result) == "success")

                        window.location.href = "admin2.html";
                    else {
                        layer.msg("注册失败！", {icon: 2});
                    }
                },
                error: function (e) {
                    layer.msg("请求服务器失败！", {icon: 2});
                }
            });
        }

        function login() {
            var uname = $("#uname").val();
            if (uname.length == 0) {
                layer.tips("用户名不能为空!", "#uname", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            var upwd = $("#upwd").val();
            if (upwd.length == 0) {
                layer.tips("密码不能为空!", "#upwd", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            if (upwd.length < 6) {
                layer.tips("密码长度应大于6位!", "#upwd", {tips: [2, '#FF0000'], time: 3000});
                return;
            }
            var vcode = $("#vcode").val();
            //  var vcodeimg=$("#checkCode").innerHTML;
            if (vcode.length == 0) {
                layer.tips("验证码不能为空!", "#vcode", {tips: [1, '#FF0000'], time: 3000});
                return;
            }
            if (vcode.toUpperCase() == code.toUpperCase()) {
                $.ajax({
                    url: "user/login.do",
                    method: "post",
                    cache: false,
                    data: $("#loginForm").serialize(),//表单序列化
                    success: function (result) {
                        if (JSON.parse(result) == "success"){


                            window.location.href = "admin2.html";

                        } else {
                            layer.msg("登录失败！", {icon: 2});
                        }
                    },
                    error: function (e) {
                        layer.msg("请求服务器失败！", {icon: 2});
                    }
                });
            } else {
                layer.tips("验证码输入有误!", "#vcode", {tips: [1, '#FF0000'], time: 3000});
                return;
            }

        }
    </script>
</head>
<body>

<center style="margin-top: 100px;">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
        <legend><label><h2>天津医科大学总医院医疗设备检修预警系统</h2></label></legend>
    </fieldset>

    <div align="center" style="width: 50%">
        <div class="layui-tab">
            <ul class="layui-tab-title">
                <li class="layui-this">用户登录</li>
                <li>用户注册</li>
            </ul>
            <div class="layui-tab-content">

                <div class="layui-tab-item layui-show">
                    <div class="layui-card">
                        <div class="layui-card-body">
                            <form id="loginForm">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户名</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="uname" name="uname" lay-verify="title" autocomplete="off"
                                               placeholder="请输入用户名" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">密码</label>
                                    <div class="layui-input-block">
                                        <input type="password" id="upwd" name="upwd" lay-verify="required"
                                               placeholder="请输入密码" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">验证码</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="vcode" name="vcode" lay-verify="required"
                                               placeholder="请输入验证码" autocomplete="off" class="layui-input">
                                    </div>
                                    <div id="checkCode" onclick="refreshVcode()"></div>
                                </div>

                                <div class="layui-form-item" align="center">
                                    <a class="layui-btn" href="javascript:login()">登录</a>
                                    <a class="layui-btn layui-btn-normal" href="javascript:reset()">重置</a>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>

                <div class="layui-tab-item">
                    <form id="insertForm">
                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-block">
                                <input type="text" id="uname2" name="uname2" lay-verify="title" autocomplete="off"
                                       placeholder="请输入用户名" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-block">
                                <input type="password" id="upwd2" name="upwd2" lay-verify="required" placeholder="请输入密码"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">再输入密码</label>
                            <div class="layui-input-block">
                                <input type="password" id="upwd3" name="upwd3" lay-verify="required"
                                       placeholder="请再输入密码" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-block">
                                <input type="text" id="email" name="email" lay-verify="required" placeholder="请输入邮箱"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>


                        <div class="layui-form-item" align="center">
                            <a class="layui-btn" href="javascript:register()">注册</a>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</center>
<center>
    <div align="center" class="layui-footer" style=" position: fixed;bottom:0;width: 100%">
        <span>&copy;2019-2020 天津融创软通 Copy Right</span>
    </div>
</center>
</body>
<script type="text/javascript">

</script>
</html>