package com.java1234.dao;

import com.java1234.model.PageBean;
import com.java1234.model.Student;
import com.java1234.util.DateUtil;
import com.java1234.util.StringUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StudentDao {

    public ResultSet studentList(Connection con, PageBean pageBean,Student student,String bbtd,String ebtd) throws Exception{
        StringBuffer sb = new StringBuffer("select * from t_student s,t_grade g where s.gradeId=g.id");//联表查询

        if (StringUtil.isNotEmpty(student.getStuNo())) {
            sb.append(" and s.stuNo like '%" + student.getStuNo() + "%'");
        }
        if (StringUtil.isNotEmpty(student.getStuName())) {
            sb.append(" and s.stuName like '%" + student.getStuName() + "%'");
        }
        if (StringUtil.isNotEmpty(student.getSex())) {
            sb.append(" and s.sex = '" + student.getSex() + "'");
        }
        if (student.getGradeId()!=-1) {
            sb.append(" and s.gradeId = " + student.getGradeId() + "");
        }
        if (StringUtil.isNotEmpty(bbtd)) {
            sb.append(" and to_days(s.birthday)>=to_days('"+bbtd+"')");
        }
        if (StringUtil.isNotEmpty(ebtd)) {
            sb.append(" and to_days(s.birthday)<=to_days('"+ebtd+"')");
        }

        sb.append(" order by stuId");

        if (pageBean != null) {
            sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
        }//判断分页用
        PreparedStatement pstmt = con.prepareStatement(sb.toString());
        return pstmt.executeQuery();
    }

    public int studentCount(Connection con,Student student,String bbtd,String ebtd) throws Exception{
        StringBuffer sb = new StringBuffer("select count(*) as total from t_student s,t_grade g where s.gradeId=g.id");

        if (StringUtil.isNotEmpty(student.getStuNo())) {
            sb.append(" and s.stuNo like '%" + student.getStuNo() + "%'");
        }
        if (StringUtil.isNotEmpty(student.getStuName())) {
            sb.append(" and s.stuName like '%" + student.getStuName() + "%'");
        }
        if (StringUtil.isNotEmpty(student.getSex())) {
            sb.append(" and s.sex = '" + student.getSex() + "'");
        }
        if (student.getGradeId()!=-1) {
            sb.append(" and s.gradeId = '" + student.getGradeId() + "'");
        }
        if (StringUtil.isNotEmpty(bbtd)) {
            sb.append(" and to_days(s.birthday)>=to_days('"+bbtd+"')");
        }
        if (StringUtil.isNotEmpty(ebtd)) {
            sb.append(" and to_days(s.birthday)<=to_days('"+ebtd+"')");
        }

        PreparedStatement pstmt = con.prepareStatement(sb.toString());
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("total");
        }else{
            return 0;
        }
    }

    public int studentDelete(Connection con,String delIds) throws Exception{
        String sql = "delete from t_student where stuId in ("+delIds+")";
        PreparedStatement pstmt = con.prepareStatement(sql);
        return pstmt.executeUpdate();
    }

    public int studentAdd(Connection con, Student student) throws Exception{
        String sql = "insert into t_student values(null,?,?,?,?,?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1,student.getStuNo());
        pstmt.setString(2,student.getStuName());
        pstmt.setString(3,student.getSex());
        pstmt.setString(4, DateUtil.formatDate(student.getBirthday(),"yyyy-MM-dd"));
        pstmt.setInt(5,student.getGradeId());
        pstmt.setString(6,student.getEmail());
        pstmt.setString(7,student.getStuDisc());
        return pstmt.executeUpdate();
    }

    public int studentModify(Connection con, Student student) throws Exception{
        String sql = "UPDATE t_student SET stuNo=?,stuName=?,sex=?,birthday=?,gradeId=?,email=?,stuDisc=? WHERE stuId=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1,student.getStuNo());
        pstmt.setString(2,student.getStuName());
        pstmt.setString(3,student.getSex());
        pstmt.setString(4, DateUtil.formatDate(student.getBirthday(),"yyyy-MM-dd"));
        pstmt.setInt(5,student.getGradeId());
        pstmt.setString(6,student.getEmail());
        pstmt.setString(7,student.getStuDisc());
        pstmt.setInt(8,student.getStuId());
        return pstmt.executeUpdate();
    }

    public boolean getStudentByGradeId(Connection con,String gradeId) throws Exception{
        String sql = "select * from t_student where gradeId=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1,gradeId);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return true;
        }else{
            return false;
        }
    }

}
