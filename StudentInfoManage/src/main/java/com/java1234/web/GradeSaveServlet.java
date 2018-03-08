package com.java1234.web;

import com.java1234.dao.GradeDao;
import com.java1234.model.Grade;
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

public class GradeSaveServlet extends HttpServlet {

    DbUtil dbUtil = new DbUtil();
    GradeDao gradeDao = new GradeDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String gradeName = req.getParameter("gradeName");
        String gradeDesc = req.getParameter("gradeDesc");
        String id = req.getParameter("id");
        Grade grade = new Grade(gradeName, gradeDesc);
        if (StringUtil.isNotEmpty(id)) {
            grade.setId(Integer.parseInt(id));
        }
        Connection con = null;
        try {
            con = dbUtil.getCon();
            int saveNum = 0;
            JSONObject result = new JSONObject();
            if (StringUtil.isNotEmpty(id)) {
                saveNum = gradeDao.gradeModify(con, grade);
            }else{
                saveNum = gradeDao.gradeAdd(con, grade);
            }
            if (saveNum>0) {
                result.put("success", "true");
            }else{
                result.put("success", "true");
                result.put("errorMsg", "保存失败");
            }
            ResponseUtil.write(resp,result);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                dbUtil.closeCon(con);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
}
