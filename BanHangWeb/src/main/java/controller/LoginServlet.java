/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = dao.login(username, password);

        if (user == null) {
            req.setAttribute("msg", "❌ Sai tài khoản hoặc mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // Lưu user vào session
        HttpSession session = req.getSession();
        session.setAttribute("currentUser", user);

        // Điều hướng theo vai trò
        if (user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/admin");
        } else {
            // khách hàng => xem sản phẩm ngay
            resp.sendRedirect(req.getContextPath() + "/sanpham");
        }
    }
}
