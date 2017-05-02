function logout() {
    $.ajax({
        type     : "GET",
        url      : "/iblog/visitor/logout.do",
        success  : function (msg) {
                        window.location.reload();
                   },
        error    : function () {
                        alert("服务器请求失败");
                   }
    });
}