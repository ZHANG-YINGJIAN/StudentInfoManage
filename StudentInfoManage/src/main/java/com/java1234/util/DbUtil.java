package com.java1234.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbUtil {

    private String dbUrl = "jdbc:mysql://localhost:3306/db_studentInfo";
    private String dbUserName = "root";
    private String dbPassWord = "root";
    private String jdbcName = "com.mysql.jdbc.Driver";

    /**
     * 获取数据库连接
     * @return
     * @throws Exception
     */

    public Connection getCon() throws Exception{
        Class.forName(jdbcName);//加载驱动
        Connection con = DriverManager.getConnection(dbUrl, dbUserName, dbPassWord);//连接数据库
        return con;
    }

    /**
     * 关闭数据库连接
     * @param con
     */

    public void closeCon(Connection con) throws Exception{
        if (con != null) {
            con.close();
        }
    }

    public static void main(String[] args) {
        DbUtil dbUtil = new DbUtil();
        try {
            dbUtil.getCon();
            System.out.println("连接成功");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("连接失败");
        }
    }
}
