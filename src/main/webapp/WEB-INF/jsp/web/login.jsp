<%@ page language="java" pageEncoding="UTF-8" %>
<style>
        .login-page {
            width: 360px;
            margin: auto;
            padding: 20px 0 0 0;
        }
        .form {
            position: relative;
            z-index: 1;
            /*background: #FFFFFF;*/
            max-width: 360px;
            padding: 20px;
            text-align: center;
            /*box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);*/
        }
        .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .form button {
            font-family: "Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background: #4CAF50;
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3 ease;
            transition: all 0.3 ease;
            cursor: pointer;
        }
        .form button:hover,.form button:active,.form button:focus {
            background: #43A047;
        }
        .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
        }
        .form .message a {
            color: #4CAF50;
            text-decoration: none;
        }
        #close_login {
            position: relative;
            top:-5px;
            left:20px;
        }
</style>
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"
             style="width: 435px; margin: 0 auto; margin-top: 120px;">
            <%--<div class="modal-header">--%>
               <%--<h3 style="font-weight: normal; font-size: 20px; color: #666666;">--%>
                    <%--登录--%>
                <%--</h3>--%>
            <%--</div>--%>
            <div class="login-page">
                <button type="button" class="close" data-dismiss="modal" id="close_login"
                        aria-hidden="true">
                    <i class="fa fa-times" aria-hidden="true"></i>
                </button>

                <div class="form">

                    <form class="form-signin login-form" id="submit_login">
                        <input type="text" id="visitorName" class="signin-form-control" name="visitorName"
                               placeholder="请输入用户名" required="" >
                        <div style="height:22px" id="uaccountLoginVali">

                        </div>
                        <input type="password" id="password" name="password"
                               class="signin-form-control" placeholder="请输入密码" required="" style="margin-bottom: 0px;">
                        <div style="height:22px" id="upassLoginVali">

                        </div>
                        <div id="loginFalse" style="height:22px;" ></div>
                        <button class="btn btn-lg btn-primary btn-block" type="submit">
                            登录
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>