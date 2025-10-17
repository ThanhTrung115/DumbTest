/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/util/DBConnect.java
package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    private static final String URL  = "jdbc:mysql://127.0.0.1:3306/db_banhang?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh";
    private static final String USER = "root";
    private static final String PASS = "Merinos104"; // 

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) { e.printStackTrace(); }
    }

    public static Connection getConnection() {
        try { return DriverManager.getConnection(URL, USER, PASS); }
        catch (Exception e) { throw new RuntimeException(e); }
    }
}
