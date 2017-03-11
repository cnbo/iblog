# 网络访客注册接口

地址

>/Visitor/Regist

方法

>POST

是否需要登录

>否

参数说明：

| 参数名称 | 是否必选 | 参数类型 | 参数描述 |
| :----- | :------- | :------ | :------|
| visitor_name | 是 | string | 用户名，最少6个字符，最多30个字符。必须由数字、字母和下划线组成 |
| password | 是 | string | 密码，最少6个字符，最多30个字符。必须由数字、字母和下划线组成 |

请求示例：

>   
    curl -d 'visitor_name=cnbo&password=123456' '/Visitor/Regist


返回值说明：

| 参数名称 | 是否必选 | 参数类型 | 参数描述 |
| :----- | :------- | :------ | :------|
| isRegist | 是 | boolean | 是否注册成功 |

返回示例：

>   
    {"code":200,"message":"请求成功","data":{“isRegist”:true}}
