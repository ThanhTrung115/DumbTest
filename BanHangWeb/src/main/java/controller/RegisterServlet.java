/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/controller/RegisterServlet.java
package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO dao=new UserDAO();
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req,resp);
    }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u=new User();
        u.setTenDangNhap(req.getParameter("username"));
        u.setPassword(req.getParameter("password"));
        u.setHoVaTen(req.getParameter("fullname"));
        u.setEmail(req.getParameter("email"));
        u.setDienThoai(req.getParameter("phone"));
        u.setDiaChi(req.getParameter("address"));
        u.setVaiTro(0);
        dao.insert(u);
        resp.sendRedirect(req.getContextPath()+"/login");
    }
}
