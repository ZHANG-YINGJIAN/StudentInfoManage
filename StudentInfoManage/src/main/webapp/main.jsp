<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

    <title>学生信息管理系统主界面</title>

    <%
        //权限验证
        if(session.getAttribute("currentUser")==null){
            response.sendRedirect("index.jsp");
            return;
        }
    %>

    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/icon.css"/>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript">

        $(function () {
            //数据
            var treeData=[{
                text:"信息管理",
                children:[{
                    text:"班级信息管理",
                    // children:[{
                    //     text:"班级",
                    //     attributes:{
                    //         url:""
                    //     }
                    // }]
                    attributes:{
                        url:"gradeInfoManager.jsp"
                    }
                },{
                    text:"学生信息管理",
                    attributes:{
                        url:"studentInfoManager.jsp"
                    }
                }]
            }];

            // //实例化树菜单
            $("#tree").tree({

                data:treeData,
                lines:true,
                onClick:function (node) {
                    if(node.attributes){
                        openTab(node.text,node.attributes.url);
                    }
                }
            });
            //在右边center区域打开菜单，新增tab
            function openTab(text, url) {
                if ($("#tabs").tabs('exists', text)) {
                    $('#tabs').tabs('select', text);
                } else {
                    var content="<iframe frameborder='0' style='width: 100%;height: 100%;' scrolling='auto' src="+url+"></iframe>";
                    $("#tabs").tabs('add', {
                        title : text,
                        closable : true,
                        content : content
                    });
                }
            }
        });
    </script>
</head>

<body class="easyui-layout">
<div region="north" style="height: 130px;background-color: white" align="center">
    <img src="images/logo.jpg" />
    <div>当前用户：&nbsp;<font color="red">${currentUser.userName}</font></div>
</div>
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页">
            <div align="center" style="padding-top: 100px"><font color="red" size="20px">欢迎使用</font></div>
        </div>
    </div>
</div>
<div region="west" style="width: 150px" title="导航菜单" split="true">
    <ul class="easyui-tree" id="tree"></ul>
</div>
<div region="south" style="height: 25px;" align="center">版权所有<a href="http://www.java1234.com">www.java.1234.com</a></div>
</body>
</html>
