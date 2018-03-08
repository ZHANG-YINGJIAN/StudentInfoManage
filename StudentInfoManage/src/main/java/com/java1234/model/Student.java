package com.java1234.model;


import java.util.Date;

public class Student {
    private int stuId;
    private String stuNo;
    private String stuName;
    private String sex;
    private Date birthday;
    private int gradeId=-1;
    private String email;
    private String stuDisc;

    private String gradeName;//辅助

    public Student() {
    }

    public Student(String stuNo, String stuName, String sex, Date birthday, int gradeId, String email, String stuDisc) {
        this.stuNo = stuNo;
        this.stuName = stuName;
        this.sex = sex;
        this.birthday = birthday;
        this.gradeId = gradeId;
        this.email = email;
        this.stuDisc = stuDisc;
    }

    public String getGradeName() {
        return gradeName;
    }

    public void setGradeName(String gradeName) {
        this.gradeName = gradeName;
    }

    public int getStuId() {
        return stuId;
    }

    public void setStuId(int stuId) {
        this.stuId = stuId;
    }

    public String getStuNo() {
        return stuNo;
    }

    public void setStuNo(String stuNo) {
        this.stuNo = stuNo;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public int getGradeId() {
        return gradeId;
    }

    public void setGradeId(int gradeId) {
        this.gradeId = gradeId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStuDisc() {
        return stuDisc;
    }

    public void setStuDisc(String stuDisc) {
        this.stuDisc = stuDisc;
    }
}
