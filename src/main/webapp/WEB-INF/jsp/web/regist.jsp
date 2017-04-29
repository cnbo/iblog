<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<div class="modal fade" id="registModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"
             style="margin: 0 auto; margin-top: 90px;">
            <div class="modal-header"
                 style="padding-top: 15px; padding-bottom: 15px">
                <button type="button" class="close" data-dismiss="modal" id="close_regist"
                        aria-hidden="true">
                    ×
                </button>
                <h3 style="font-weight: normal; font-size: 20px; color: #666666;">
                    注册
                </h3>
            </div>
            <form class="form-horizontal" id="user_regist"
                  action="" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-xs-2 control-label">
                            用户名
                        </label>
                        <div class="col-xs-10">
                            <input class="form-control" type="text" name="visitorName" id="_visitorName"
                                   placeholder="请输入用户名" value="">
                        </div>
                        <div style="height:43px;margin: 0px 0px 0px 21.5%;" id="_visitorNameValidate">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">
                            密码
                        </label>
                        <div class="col-xs-10">
                            <input class="form-control" type="password" name="password" id="_password"
                                   placeholder="请输入密码" value="">
                        </div>
                        <div style="height:43px;margin: 0px 0px 0px 21.5%;" id="_pswValidate">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label">
                            确认密码
                        </label>
                        <div class="col-xs-10">
                            <input class="form-control" type="password" id="_repass"
                                   placeholder="请再次输入密码" value="">
                        </div>
                        <div style="height:43px;margin: 0px 0px 0px 21.5%;" id="_repswValidate">
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal" aria-hidden="true" onclick="registClose()">
                        取消
                    </button>
                    <button type="submit" class="btn btn-primary" id="_submit">
                        注册
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>