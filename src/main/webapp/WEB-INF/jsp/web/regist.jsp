<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<style>
    .validateMsg{
        font-size: 12px;
    }
    .register-page {
        /*width: 360px;*/
        margin: auto;
        padding: 20px 0 0 0;
    }
    .register-form{
        position: relative;
        z-index: 1;
        /*background: #FFFFFF;*/
        /*max-width: 360px;*/
        padding: 30px;
        text-align: center;
        /*box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);*/
    }
    .register-form input {
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
    .register-form button {
        font-family: "Roboto", sans-serif;
        text-transregister-form: uppercase;
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
    .register-form button:hover,.register-form button:active,.register-form button:focus {
        background: #43A047;
    }
    .register-form .message {
        margin: 15px 0 0;
        color: #b3b3b3;
        font-size: 12px;
    }
    .register-form .message a {
        color: #4CAF50;
        text-decoration: none;
    }
    #close_regist{
        position: relative;
        top:-5px;
        left: -22px;
        z-index:100;
    }
    .register-form .modal-footer{
        text-align: center;
    }
    .register-form .modal-footer .btn {
        margin: 5px 20px;
        display: inline-block;
        width:40%;

    }
</style>
<div class="modal fade" id="registModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content "
             style="width: 570px; margin: 0 auto; margin-top: 90px;">
            <%--<div class="modal-header"--%>
                 <%--style="padding-top: 15px; padding-bottom: 15px">--%>
                <%--<button type="button" class="close" data-dismiss="modal" id="close_regist"--%>
                        <%--aria-hidden="true">--%>
                    <%--<i class="fa fa-times" aria-hidden="true"></i>--%>
                <%--</button>--%>
           <%--</div>--%>
            <div class="register-page">
                <button type="button" class="close" data-dismiss="modal" id="close_regist"
                        aria-hidden="true">
                    <i class="fa fa-times" aria-hidden="true"></i>
                </button>
                <div class="register-form">

                    <form class="form-horizontal" id="user_regist"
                      action="" method="post">
                        <div class="form-group">
                            <label class="col-xs-3 control-label">
                                用户名
                            </label>
                            <div class="col-xs-7">
                                <input  type="text" name="visitorName" id="_visitorName"
                                       placeholder="请输入用户名" value="">
                            </div>
                            <div style="height:43px;margin: 0px 0px 0px 21.5%;" class="validateMsg" id="_visitorNameValidate">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">
                                密码
                            </label>
                            <div class="col-xs-7">
                                <input type="password" name="password" id="_password"
                                       placeholder="请输入密码" value="">
                            </div>
                            <div style="height:43px;margin: 0px 0px 0px 21.5%;" class="validateMsg" id="_pswValidate">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">
                                确认密码
                            </label>
                            <div class="col-xs-7">
                                <input  type="password" id="_repass"
                                       placeholder="请再次输入密码" value="">
                            </div>
                            <div style="height:43px;margin: 0px 0px 0px 21.5%;" class="validateMsg" id="_repswValidate">
                            </div>
                        </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary"
                                data-dismiss="modal" aria-hidden="true" onclick="registClose()">
                            取消
                        </button>
                        <button type="submit" class="btn btn-primary" id="_submit" style="margin: 0px">
                            注册
                        </button>
                    </div>
                </form>

                </div>
            </div>
        </div>
    </div>
</div>