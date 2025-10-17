/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * SanPhamServlet - Hiển thị danh sách sản phẩm cho khách hàng
 */
package controller;

import dao.SanPhamDAO;
import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet(name = "Home", urlPatterns = {"/", "/home", "/sanpham"})
public class SanPhamServlet extends HttpServlet {
    private final SanPhamDAO dao = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Kiểm tra đăng nhập
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        // Nếu là admin thì không cho vào trang sản phẩm
        if (currentUser.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        // Lấy danh sách sản phẩm
        req.setAttribute("list", dao.getAll());

        // Chuyển đến trang home.jsp hiển thị danh sách
        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}

