<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/22 0022
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>班级信息管理</title>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/icon.css"/>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript">//不要忘记type
    var url;
        function searchGrade() {
            $("#dg").datagrid('load', {
                gradeName: $('#s_gradeName').val()
            });
        }//将gradeName 设为我们从文本框s_gradeName中输入的值
        function deleteGrade(){
            var selectedRows=$("#dg").datagrid('getSelections');
            if(selectedRows.length==0) {
                $.messager.alert("系统提示","请选择要删除的数据！");
                return;
            }

            var strIds = [];
            for(var i=0; i<selectedRows.length;i++) {
                strIds.push(selectedRows[i].id);
            }

            var ids = strIds.join(",");

            //confirm三个变量，第一个：提示框名称 第二个：提示框内容 第三个：一个方法，分确定和取消，确定的话post提交
            $.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function (r) {
                if(r){
                    /**
                     * post提交四个变量 1 url 2 删除行id号 3 返回的结果判断 4 格式
                     */
                    $.post("gradeDelete",{delIds:ids},function (result) {
                        if(result.success){
                            // alert("delete ok");
                            $.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNum+"</font>条数据！");
                            $("#dg").datagrid("reload");//界面刷新
                        }else{
                            $.messager.alert("系统提示","<font color='red'>"+selectedRows[result.errorIndex].gradeName+"</font>"+result.errorMsg);
                        }
                    },"json");
                }
            });

        }

        function openGradeAddDialog(){
            $("#dlg").dialog("open").dialog("setTitle","添加班级信息");
            url="gradeSave";
        }

        function openGradeModifyDialog(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1) {
                $.messager.alert("系统提示","请选择一条要修改的数据！");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle","修改班级信息");
            $("#fm").form("load",row);
            url="gradeSave?id="+row.id;

        }

        function closeGradeDialog(){
            $("#dlg").dialog("close");
            resetValue();
        }

        function resetValue(){
            $('#gradeName').val("");
            $("#gradeDesc").val("");
        }

        function saveGrade() {
            /**
             * form 提交两个 1 submit 2 包含三小个 url/onSubmit/success
             */
            $("#fm").form("submit",{
                url:url,
                onSubmit:function () {
                    return $(this).form("validate");
                },
                success:function (result) {
                    if(result.errorMsg) {
                        $.messager.alert("系统提示", result.errorMsg);
                        return;
                    }else{
                        $.messager.alert("系统提示", "保存成功");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");//界面刷新
                    }
                }
            });
        }
    </script>
</head>
<body>
<%--引用tb 所以包含那些按钮--%>
<table id="dg" title="班级信息" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true" url="gradeList" toolbar="#tb">
    <thead>
    <tr>
        <th field ="cb" checkbox="true"></th>
        <th field="id" width="50" align="center">编号</th>
        <th field="gradeName" width="100" align="center">班级名称</th>
        <th field="gradeDesc" width="250" align="center">班级描述</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openGradeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openGradeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteGrade()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
    </div>
    <div>&nbsp;班级名称：&nbsp;<input type="text" id="s_gradeName" name="s_gradeName" size="13">
        <a href="javascript:searchGrade()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
    </div>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding: 20px 20px" closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table>
            <tr>
                <td>班级名称：</td>
                <td><input type="text" name="gradeName" id="gradeName" class="easyui-validatebox" required="true"/></td>
            </tr>
            <tr>
                <td valign="top">班级描述：</td>
                <td><textarea rows="7" cols="30" id="gradeDesc" name="gradeDesc"></textarea></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveGrade()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeGradeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

</body>
</html>
