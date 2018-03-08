package com.java1234.web;

import com.java1234.dao.UserDao;
import com.java1234.model.User;
import com.java1234.util.DbUtil;
import com.java1234.util.StringUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

public class LoginServlet extends HttpServlet {

    DbUtil dbUtil = new DbUtil();
    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("userName");
        String password = req.getParameter("password");
        if (StringUtil.isEmpty(userName) || StringUtil.isEmpty(password)) {
            req.setAttribute("error","用户名或密码不能为空！");
            req.getRequestDispatcher("index.jsp").forward(req,resp);
            return;
        }

        User user = new User(userName,password);
        Connection con = null;

        try {
            con = dbUtil.getCon();
            User currentUser = userDao.login(con, user);
            if (currentUser == null) {
                req.setAttribute("error","用户名或密码错误");
                req.setAttribute("userName",userName);
                req.setAttribute("password",password);
                req.getRequestDispatcher("index.jsp").forward(req,resp);
            }else{
                //获取Session
                HttpSession session = req.getSession();
                session.setAttribute("currentUser",currentUser);

                //客户端跳转
                resp.sendRedirect("main.jsp");
            }
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
