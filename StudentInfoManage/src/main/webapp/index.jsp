<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>学生信息管理系统</title>

    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/icon.css"/>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript">
        function resetValue() {
            document.getElementById("userName").value="";
            document.getElementById("password").value="";
        }
    </script>
    <style type="text/css">
        .bl{
            width: 490px;
            height: 290px;
            padding-top: 15px;
            background:url(images/back1.jpg) no-repeat center center;
        }
    </style>
</head>

<body style="background-image: url(images/2.jpg)">
<div align="center" style="padding-top: 150px">
    <div><font style="font-size:70px;text-align: center;color: white">学生信息管理系统</font></div>
    <div style="background-color: snow;width:520px;height: 320px;padding-top: 15px">
        <div class="bl">
            <table style="padding-top: 20px">
                <tr>
                    <td style="width: 40%">
                        <div><font style="font-size: 35px;color: #0081c2" >用户登陆</font></div>
                        <img src="images/login1.png" style="">
                    </td>
                    <td>
                        <div align="center" style="padding-top: 50px" >
                            <form action="login" method="post">
                                <table style="font-size: 22px">
                                    <tr>
                                        <td >用户名：</td>
                                        <td colspan="2"><input type="text" style="height: 25px" id="userName" name="userName" value="${userName}"/></td>
                                    </tr>
                                    <tr>
                                        <td>密 码：</td>
                                        <td colspan="2"><input type="password" style="height: 25px" id="password" name="password" value="${password}"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="2" style="text-align:center;padding-top: 5px">
                                            <input type="submit" style="font-size: 21px" value="登陆" align="center"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input type="button" style="font-size: 22px" value="重置" onclick="resetValue()">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center"><font color="red" >${error}</font></td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div id="Copy" align="center" style="padding-top: 10px">
    <font color="red" style="font-size: 22px">信息管理系统&nbsp;&nbsp;&nbsp;</font>Version 1.0 由XX科技提供技术支持！
    <br />
</div>
</body>
</html>
