package com.java1234.dao;

import com.java1234.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 用户Dao类
 */

public class UserDao {

    /**
     * 登陆验证
     * @param con 数据库连接
     * @param user 界面传过来的用户信息
     * @return
     * @throws Exception
     */

    public User login(Connection con, User user) throws Exception{

        User resultUser = null;
        String sql = "select * from t_user where userName = ? and password = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1,user.getUserName());
        pstmt.setString(2,user.getPassword());
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            resultUser = new User();  //一般登陆结果集只有一个，如果有，就对结果用户实例化
            resultUser.setId(rs.getInt("id"));
            resultUser.setUserName(rs.getString("userName"));
            resultUser.setPassword(rs.getString("password"));
        }
        return resultUser;
    }
}
