<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="zh_CN">

  <head>
    <meta charset="utf-8" />
    <title>博客后台 - Iblog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="shortcut icon" href="/static/admin/images/favicon.png" />
    <link href="//cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="//cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <%--<link href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">--%>
    <%--<link href="${pageContext.request.contextPath}/css/font-awesome.css" rel="stylesheet" type="text/css">--%>
    <link href="${pageContext.request.contextPath}/css/style.min.css" rel="stylesheet" type="text/css">
    <link href="//cdn.bootcss.com/limonte-sweetalert2/6.4.1/sweetalert2.min.css" rel="stylesheet">


    <%--<link href="${pageContext.request.contextPath}/css/limonte-sweetalert2.css" rel="stylesheet" type="text/css">--%>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="httpss://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>

  <body class="fixed-left">
    <div id="wrapper">
      <div class="topbar">
        <div class="topbar-left">
          <div class="text-center p-t-10" style="margin: 0 auto;">
            <div class="pull-left" style="padding-left: 10px;">
              <a href="${pageContext.request.contextPath}/admin/index.do">
                <img src="${pageContext.request.contextPath}/uploads/monkey_logo.jpg" width="50" height="50" />
              </a>
            </div>
            <div class="pull-left" style="padding-left: 10px;">
              <span style="font-size: 28px; color: #2f353f; line-height: 50px;">Iblog</span>
            </div>
          </div>
        </div>
        <div class="navbar navbar-default" role="navigation" style="margin-bottom: 0px">
          <div class="container">
            <div class="">
              <div class="pull-left">
                <button type="button" class="button-menu-mobile open-left">
                            <i class="fa fa-bars"></i>
                        </button>
                <span class="clearfix"></span>
              </div>

              <ul class="nav navbar-nav navbar-right pull-right">
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle profile" data-toggle="dropdown" aria-expanded="true"><img src="${pageContext.request.contextPath}/uploads/avatar.jpg" alt="user-img" class="img-circle"> </a>
                  <ul class="dropdown-menu">
                    <%--<li><a href="${site_url()}" target="_blank"><i class="fa fa-eye" aria-hidden="true"></i> 查看网站</a></li>--%>
                      <%--<li><a href="/admin/profile"><i class="fa fa-sun-o"></i> 个人设置</a></li>--%>
                        <%--<li><a href="/admin/reload"><i class="fa fa-sun"></i> 重启系统</a></li>--%>
                          <li><a href="/iblog/admin/logout.do"><i class="fa fa-sign-out"></i> 注销</a></li>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="left side-menu">
        <div class="sidebar-inner slimscrollleft">
          <div id="sidebar-menu">
            <ul>
              <%--<li #if(active=='home') class="active" #end>--%>
                <%--<a href="/admin/index" class="waves-effect #if(active=='home') active #end"><i class="fa fa-dashboard" aria-hidden="true"></i><span> 仪表盘 </span></a>--%>
                  <%--</li>--%>
                    <li #if(active=='publish' ) class="user" #end>
                      <a href="/iblog/admin/profile.do" class="waves-effect #if(active=='user') active #end"><i class="fa fa-user" aria-hidden="true"></i><span> 个人信息</span></a>
                    </li>

                    <li #if(active=='publish' ) class="active" #end>
                      <a href="/iblog/admin/blog/write.do" class="waves-effect #if(active=='publish') active #end"><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span> 写博客 </span></a>
                    </li>
                    <li #if(active=='article' ) class="active" #end>
                      <a href="/iblog/admin/blog/manage.do" class="waves-effect #if(active=='article') active #end"><i class="fa fa-list" aria-hidden="true"></i><span> 博客管理 </span></a>
                    </li>

                    <%--<li #if(active=='attach') class="active" #end>--%>
                      <%--<a href="/iblog/admin/attach" class="waves-effect #if(active=='attach') active #end"><i class="fa fa-cloud-upload" aria-hidden="true"></i><span> 文件管理 </span></a>--%>
                        <%--</li>--%>
                          <li #if(active=='links' ) class="active" #end>
                            <a href="/iblog/admin/friendly-link/manage.do" class="waves-effect #if(active=='links') active #end"><i class="fa fa-link" aria-hidden="true"></i><span> 友链管理 </span></a>
                          </li>

                          <li class="has_sub">
                            <a href="javascript:void(0)" class="waves-effect #if(has_sub=='other') active subdrop #end"><i class="fa fa-cubes"></i><span> 其他管理 </span><span class="pull-right"><i class="fa fa-plus"></i></span></a>
                            <ul class="list-unstyled">
                              <li #if(active=="visitor" ) class="active" #end>
                                <a href="/iblog/admin/visitor/manage.do" class="waves-effect #if(active=='visitor') active #end"><i class="fa fa-user" aria-hidden="true"></i><span> 访客管理 </span></a>
                              </li>
                              <li #if(active=='comments' ) class="active" #end>
                                <a href="/iblog/admin/comment/manage.do" class="waves-effect #if(active=='comments') active #end"><i class="fa fa-comments" aria-hidden="true"></i><span> 评论管理 </span></a>
                              </li>
                              <li #if(active=='category' ) class="active" #end>
                                <a href="/iblog/admin/category/manage.do" class="waves-effect #if(active=='category') active #end"><i class="fa fa-tags" aria-hidden="true"></i><span> 分类/标签 </span></a>
                              </li>
                            </ul>
                          </li>

                          <%--<li #if(active=='themes') class="active" #end>--%>
                            <%--<a href="/admin/themes" class="waves-effect #if(active=='themes') active #end"><i class="fa fa-diamond" aria-hidden="true"></i><span> 主题 </span></a>--%>
                              <%--</li>--%>

                                <%--<li #if(active=='setting') class="active" #end>--%>
                                  <%--<a href="/admin/setting" class="waves-effect #if(active=='setting') active #end"><i class="fa fa-gear" aria-hidden="true"></i><span> 系统设置 </span></a>--%>
                                    <%--</li>--%>

                                      <%--#for(item : plugin_menus)--%>
                                        <%--<li #if(active==item.slug) class="active" #end>--%>
                                          <%--<a href="/admin/plugins/${item.slug}" class="waves-effect #if(active==item.slug) active #end"><i class="${item.icon ?! 'fa fa-gear'}" aria-hidden="true"></i><span> ${item.name} </span></a>--%>
                                            <%--</li>--%>
                                              <%--#end--%>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
      <div class="content-page">
        <div class="content">
          <div class="container">