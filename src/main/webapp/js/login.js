$(function(){
    $("#submit_login").submit(function(){
        loginSubmit();
        return false;
    });
    $("#close_login").click(function(){
        $("#upassLoginVali").html("");
        $("#loginFalse").html("");
    });
});

function upassLoginVali(){
    var upass = $("#password").val();
    if(upass.length < 6){
        $("#upassLoginVali").html("<div style='color:red'>密码长度必须大于等于6位数</div>");
        return false;
    }else if(upass.length > 15){
        $("#upassLoginVali").html("<div style='color:red'>密码长度必须小于等于15位数</div>");
        return false;
    }else{
        $("#upassLoginVali").html("");
        return true;
    }
}

function loginSubmit(){
    if(!upassLoginVali()){
        $("#password").focus();
        return;
    }

    var visitotName = $("#visitorName").val();
    var password = $("#password").val();
    var jsonData = JSON.stringify({"visitorName":visitotName, "password":password});
    $.ajax({
        type        : "POST",
        url         : "/iblog/visitor/login.do",
        data        : jsonData,
        dataType    : "json",
        contentType : "application/json; charset=utf-8",
        success     : function(msg){
                        if (msg == true) {
                            window.location.reload();
                        } else {
                            $("#loginFalse").html("<div style='color: red;font-size:15px'>账号或密码错误</div>");
                        }
                    },
        error       : function(msg) {
                        alert("服务器请求失败");
                    }
    });
}