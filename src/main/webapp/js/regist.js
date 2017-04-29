
$(function(){
    $("#_visitorName").blur(function(){
        registValidate();
    });
    $("#_password").blur(function(){
        pswValidate();
    });
    $("#_repass").blur(function(){
        repswValidate();
    });
    $("#user_regist").submit(function(){
        return registSubmit();
    });
    $("#close_regist").click(function(){
        registClose();
    });

});

function registSubmit(){
    if(!registValidate()){
        $("#_visitorName").focus();
        return false;
    }
    if(!pswValidate()){
        $("#_password").focus();
        return false;
    }
    if(!repswValidate()){
        $("#_repass").focus();
        return false;
    }

    var visitorName = $("#_visitorName").val();
    var password = $("#_password").val();
    var jsonData = JSON.stringify({"visitorName":visitorName, "password":password});
    $.ajax({
        type        : "POST",
        data        : jsonData,
        dataType    : "Json",
        contentType : "application/json; charset=utf-8",
        url         : "visitor/regist.do",
        success     : function(msg){
                        if (msg == true) {
                            alert("注册成功");
                        } else {
                            alert("注册失败");
                        }
                        window.location.reload();
                    },
        error       : function(msg){
                        alert("服务器请求失败");
                    }
    });
    return false;
}

function registValidate() {
    var passValidate = false;
    var visitorName = $("#_visitorName").val();

    if (visitorName.length == 0) {
        $("#_visitorNameValidate").html(
            "<div style='color:red;'>用户名不能为空</div>");
        return passValidate;
    } else {
        $("#_visitorNameValidate").html("");
    }

    $.ajax({
        type        : "POST",
        url         : "visitor/validate.do?visitorName=" + visitorName,
        async       : false,
        success     : function(msg) {

                        if (msg == true) {
                            $("#_visitorNameValidate").html(
                                "<div style='color:red;'>该用户名已经被注册</div>");
                            passValidate =  false;
                        } else {
                            $("#_visitorNameValidate").html(
                                "<div style='color:green;'>该用户名可用</div>");
                            passValidate =  true;
                        }
                    },
        error       : function(msg){
                        alert("服务器请求失败");
                    }
    });

    return passValidate;
}

function pswValidate(){
    var password = $("#_password").val();
    if(password.length < 6){
        $("#_pswValidate").html(
            "<div style='color:red;'>密码长度不能小于6位</div>");
        return false;
    }
    $("#_pswValidate").html(
        "<div style='color:green;'>该密码可用</div>");
    return true;
}
function repswValidate(){
    var repass = $("#_repass").val();
    var password = $("#_password").val();
    if(repass != password){
        $("#_repswValidate").html(
            "<div style='color:red;'>两次密码输入不一致</div>");
        return false;
    }
    $("#_repswValidate").html(
        "<div style='color:green;'>两次密码输入一致</div>");
    return true;
}

function registClose(){
    $("#_visitorName").val("");
    $("#_password").val("");
    $("#_repass").val("");

    $("#_registValidate").html("");
    $("#_pswValidate").html("");
    $("#_repswValidate").html("");

    // $("#_registValidate").val("");
    // $("#_pswValidate").val("");
    // $("#_repswValidate").val("");
}


