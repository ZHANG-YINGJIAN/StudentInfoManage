package com.java1234.web;

import com.java1234.dao.GradeDao;
import com.java1234.dao.StudentDao;
import com.java1234.util.DbUtil;
import com.java1234.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class GradeDeleteServlet extends HttpServlet {

    DbUtil dbUtil = new DbUtil();
    GradeDao gradeDao = new GradeDao();
    StudentDao studentDao = new StudentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String delIds = req.getParameter("delIds");
        Connection con = null;
        try {
            con = dbUtil.getCon();
            JSONObject result = new JSONObject();

            /**
             * 判断班级下面是否有学生，如果有则不能删除。
             */
            String str[] = delIds.split(",");
            for (int i = 0; i <str.length ; i++) {
                boolean f = studentDao.getStudentByGradeId(con, str[i]);
                if (f) {
                    result.put("errorIndex",i);
                    result.put("errorMsg", "班级下面有学生，不能删除！");
                    ResponseUtil.write(resp, result);
                    return;
                }
            }

            int delNum = gradeDao.gradeDelete(con, delIds);
            if (delNum > 0) {
                result.put("success", "true");
                result.put("delNum", delNum);
            }else{
                result.put("errorMsg", "删除失败！");
            }

            ResponseUtil.write(resp, result);
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                dbUtil.closeCon(con);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
