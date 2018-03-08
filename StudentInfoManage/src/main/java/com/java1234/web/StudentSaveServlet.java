package com.java1234.web;

import com.java1234.dao.StudentDao;
import com.java1234.model.Student;

import com.java1234.util.DateUtil;
import com.java1234.util.DbUtil;

import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.Date;

public class StudentSaveServlet extends HttpServlet {

    DbUtil dbUtil = new DbUtil();
    StudentDao studentDao = new StudentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String stuNo = req.getParameter("stuNo");
        String stuName = req.getParameter("stuName");
        String sex = req.getParameter("sex");
        String birthday = req.getParameter("birthday");
        String gradeId = req.getParameter("gradeId");
        String email = req.getParameter("email");
        String stuDisc = req.getParameter("stuDisc");
        String stuId = req.getParameter("stuId");

        Student student = null;
        try {
            student = new Student(stuNo,stuName,sex, DateUtil.formatString(birthday,"yyyy-MM-dd"),Integer.parseInt(gradeId),email,stuDisc);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (StringUtil.isNotEmpty(stuId)) {
            student.setStuId(Integer.parseInt(stuId));
        }

        Connection con = null;
        try {
            con = dbUtil.getCon();
            JSONObject result = new JSONObject();
            int saveNum = 0;
            if(StringUtil.isNotEmpty(stuId)){
                saveNum = studentDao.studentModify(con,student);
            }else{
                saveNum = studentDao.studentAdd(con,student);
            }
            if (saveNum > 0) {
                result.put("success", "true");
            }else{
                result.put("success", "true");
                result.put("errorMsg", "保存失败！");
            }
            ResponseUtil.write(resp,result);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                dbUtil.closeCon(con);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
}
