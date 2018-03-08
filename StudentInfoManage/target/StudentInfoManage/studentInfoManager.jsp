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
    <title>学生信息管理</title>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/icon.css"/>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript"> //不要忘记type 再次强调！！！！
        var url;
        function searchStudent() {
            $("#dg").datagrid('load',{
                stuNo:$('#s_stuNo').val(),
                stuName:$('#s_stuName').val(),
                sex:$('#s_sex').combobox("getValue"),
                bbtd:$('#s_bbtd').datebox("getValue"),
                ebtd:$('#s_ebtd').datebox('getValue'),
                gradeId:$('#s_gradeId').combobox('getValue')
            });
        }

        function deleteStudent(){
            var selectedRows = $("#dg").datagrid("getSelections");
            if(selectedRows.length==0) {
                $.messager.alert("系统提示","请选择要删除的数据!");
                return;
            }

            var strIds=[];
            for(var i=0;i<selectedRows.length;i++) {
                strIds.push(selectedRows[i].stuId);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确定要删除这" + selectedRows.length + "条数据吗？",function(r){
                if(r){
                    $.post("studentDelete",{delIds:ids},function(result){
                        if(result.success) {
                            $.messager.alert("系统提示","您已成功删除这"+result.delNums+"条数据！");
                            $("#dg").datagrid("reload");
                        }else{
                            $.messager.alert("系统提示", result.errorMsg);
                        }
                    },"json")
                }

            })
        }

        function openStudentAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle","添加学生信息");
            url="studentSave";
        }

        function openStudentModifyDialog() {
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1) {
                $.messager.alert("系统提示","请选择一条要修改的数据！");
                return;
            }
            var row = selectedRows[0];
            alert(row.stuId);
            alert(row.stuNo);
            alert(row.stuName);
            alert(row.sex);
            alert(row.birthday);
            alert(row.gradeName);
            alert(row.email);
            alert(row.stuDisc);
            $("#dlg").dialog("open").dialog("setTitle","修改学生信息");
            $("#fm").form("load",row);
            url="studentSave?stuId="+row.stuId;
        }

        function closeStudentDialog(){
            $("#dlg").dialog("close");
            resetValue();
        }

        function resetValue() {
            $('#stuNo').val("");
            $("#stuName").val("");
            $("#sex").combobox("setValue","");
            $("#birthday").datebox("setValue","");
            $("#gradeId").combobox("setValue","");
            $("#email").val("");
            $("#stuDisc").val("");
        }

        function saveStudent() {
            $("#fm").form("submit",{
                url:url,
                onSubmit:function () {
                    if(($('#sex').combobox("getValue"))==""){
                        $.messager.alert("系统提示","请选择学生性别！");
                        return false;
                    }
                    if(($('#gradeId').combobox("getValue"))==""){
                        $.messager.alert("系统提示","请选择学生班级！");
                        return false;
                    }
                    return $(this).form("validate");
                },
                success:function (result) {
                    if(result.errorMsg) {
                        $.messager.alert("系统提示",result.errorMsg);
                    }else{
                        $.messager.alert("系统提示","保存成功！");
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
<table id="dg" title="学生信息" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true" url="studentList" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true"></th>
        <th field="stuId" width="50px" align="center">编号</th>
        <th field="stuNo" width="50px" align="center">学号</th>
        <th field="stuName" width="50px" align="center">姓名</th>
        <th field="sex" width="50px" align="center">性别</th>
        <th field="birthday" width="50px" align="center">出生年月</th>
        <th field="gradeId" width="50px" align="center" hidden="true">班级ID</th>
        <th field="gradeName" width="50px" align="center">班级</th>
        <th field="email" width="50px" align="center">邮箱</th>
        <th field="stuDisc" width="50px" align="center">学生介绍</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openStudentModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteStudent()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
    </div>

    <div>&nbsp;学号：&nbsp;<input type="text" id="s_stuNo" name="s_stuNo" size="10">
        &nbsp;姓名：&nbsp;<input type="text" id="s_stuName" name="s_stuName" size="10"/>
        &nbsp;性别：&nbsp;<select class="easyui-combobox" id="s_sex" name="s_sex" editable="false" panelHeight="auto">
            <option value=" ">请选择...  </option>
            <option value="男">男</option>
            <option value="女">女</option>
        </select>
        &nbsp;出生日期：&nbsp;<input type="text" class="easyui-datebox" id="s_bbtd" name="s_bbtd" size="10" />-><input type=" " class="easyui-datebox" id="s_ebtd" name="s_ebtd" size="10" />
        &nbsp;班级：&nbsp; <input class="easyui-combobox" id="s_gradeId" name="s_gradeId" panelHeight="auto" data-options="editable:false,valueField:'id',textField:'gradeName',url:'gradeComboList'"/>

        <a href="javascript:searchStudent()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
    </div>
</div>

<div id="dlg" class="easyui-dialog" style="width:650px;height:300px;padding:20px 20px" closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table style="font-size:10px">
            <tr>
                <td >学生学号：</td>
                <td><input type="text" id="stuNo" name="stuNo" class="easyui-validatebox" required="true"/></td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td>学生姓名：</td>
                <td><input type="text" id="stuName" name="stuName" class="easyui-validatebox" required="true"/></td>
            </tr>
            <tr>
                <td>学生性别：</td>
                <td>
                    <select class="easyui-combobox" id="sex" name="sex" editable="false" panelHeight="auto" style="width: 170px">
                        <option value=" ">请选择...  </option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
                <td></td>
                <td>出生日期：</td>
                <td>
                    <input type="text" class="easyui-datebox" id="birthday" name="birthday" class="easyui-validatebox" required="true"/>
                </td>
            </tr>
            <tr>
                <td>学生班级：</td>
                <td><input class="easyui-combobox" id="gradeId" name="gradeId" panelHeight="auto"
                           data-options="editable:false,valueField:'id',textField:'gradeName',url:'gradeComboList'"/>
                </td>
                <td></td>
                <td>Email：</td>
                <td><input type="text" id="email" name="email" class="easyui-validatebox" required="true"/></td>
            </tr>
            <tr>
                <td valign="top">学生介绍</td>
                <td colspan="4"><textarea rows="7" cols="62" id="stuDisc" name="stuDisc" ></textarea></td>
            </tr>

        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveStudent()" class="easyui-linkbutton" iconCls="icon-ok" plain="true">保存</a>
    <a href="javascript:closeStudentDialog()" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">取消</a>
</div>
</body>
</html>
