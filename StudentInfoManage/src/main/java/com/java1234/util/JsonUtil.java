package com.java1234.util;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class JsonUtil {

    public static JSONArray formatRsToJsonArray(ResultSet rs) throws Exception {
        ResultSetMetaData md = rs.getMetaData();//获得结果集
        int num = md.getColumnCount();//获得列项目的个数
        JSONArray array = new JSONArray();
        while (rs.next()) {
            JSONObject mapOfColValues = new JSONObject();

            for (int i = 1; i <= num; i++) {
                Object o = rs.getObject(i);
                if (o instanceof Date) {
                    mapOfColValues.put(md.getColumnName(i), DateUtil.formatDate((Date)o,"yyyy-MM-dd"));

                }else{
                    mapOfColValues.put(md.getColumnName(i), o);//获得列项目的名称
                }
            }
            array.add(mapOfColValues);
        }
        return array;

    }
}
