package com.swime.util;

import lombok.Data;
import lombok.extern.log4j.Log4j;

import java.sql.*;

import static java.lang.Integer.parseInt;

//Not used
@Log4j
public class VisitCountDao {
    private static VisitCountDao instance;

    final private static String DB_URL = "jdbc:log4jdbc:oracle:thin:@swime_tp";
    final private static String DB_USER = "ADMIN";
    final private static String DB_PASSWORD = "1q2w3e4r5t6Y";
    private static Connection conn;
    private static Statement stmt;
    private static ResultSet rs;

    public static VisitCountDao getInstance() {
        if(instance == null) instance = new VisitCountDao();
        return instance;
    }

    public void openConn_stmt() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        System.setProperty("oracle.jdbc.fanEnabled","false");
        System.setProperty("java.security.egd", "file:///dev/urandom");

        if(true){
            System.setProperty("oracle.net.tns_admin","C:/Wallet_swime");
        }else{
            System.setProperty("oracle.net.tns_admin","/Users/sinseonggwon/Wallet_swime");
        }

        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); // 데이터베이스의 연결을 설정한다.
        stmt = conn.createStatement();
    }

    public void rollback() {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void close() {
        AutoCloseable[] acs = {stmt, rs, conn};
        for(int i = 0; i < acs.length; i++) {
            if(acs[i] != null) {
                try {
                    acs[i].close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void countUp(){
        int result = 0;
        int count = 0;

        try {

            openConn_stmt();

            rs = stmt.executeQuery("select visit_date from tvisit_count where visit_date = trunc(current_date, 'hh24')");
            if(!rs.next()){
                result = stmt.executeUpdate("insert into tvisit_count(visit_date, count) values(trunc(current_date, 'hh24'), 1) ");
                if(result != 1) throw new Exception("에러 발생");
            }else{
                rs = stmt.executeQuery("select count from tvisit_count where visit_date = trunc(current_date, 'hh24')");
                while (rs.next()) count = parseInt(rs.getString(1));
                result = stmt.executeUpdate("update tvisit_count set count =" + (count + 1) + " where visit_date = trunc(current_date, 'hh24')");
                if(result != 1) throw new Exception("에러 발생");
            }

        } catch (Exception e) {
            rollback();
            e.printStackTrace();
        } finally {
            close();
        }
    }


}
