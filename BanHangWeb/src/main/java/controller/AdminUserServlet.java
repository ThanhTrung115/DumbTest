/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/controller/AdminUserServlet.java
package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/admin/user")
public class AdminUserServlet extends HttpServlet {
    private final UserDAO dao = new UserDAO();

    private boolean isAdmin(HttpServletRequest req) {
        Object u = req.getSession().getAttribute("currentUser");
        return (u instanceof User) && ((User) u).isAdmin();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.getRequestDispatcher("/admin/user-form.jsp").forward(req, resp);
                break;

            case "edit":
                int id = Integer.parseInt(req.getParameter("Id"));
                req.setAttribute("u", dao.getById(id));
                req.getRequestDispatcher("/admin/user-form.jsp").forward(req, resp);
                break;

            case "delete":
                dao.delete(Integer.parseInt(req.getParameter("Id")));
                resp.sendRedirect(req.getContextPath() + "/admin/user");
                break;

            default:
                String keyword = req.getParameter("keyword");
                String roleStr = req.getParameter("role");
                List<User> list;

                if (keyword != null && !keyword.trim().isEmpty()) {
                    // Có từ khóa tìm kiếm
                    list = dao.search(keyword);
                } else if (roleStr != null && !roleStr.trim().isEmpty()) {
                    // Có chọn vai trò để lọc
                    try {
                        int vaitro = Integer.parseInt(roleStr);
                        list = dao.filterByRole(vaitro);
                    } catch (NumberFormatException e) {
                        list = dao.getAll();
                    }
                } else {
                    // Không lọc, không tìm
                    list = dao.getAll();
                }

                req.setAttribute("list", list);
                req.getRequestDispatcher("/admin/user-list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idStr = req.getParameter("Id");
        User u = new User();

        if (idStr != null && !idStr.trim().isEmpty()) {
            u.setId(Integer.parseInt(idStr));
        }

        u.setTenDangNhap(req.getParameter("TenDangNhap"));
        u.setPassword(req.getParameter("Password"));
        u.setHoVaTen(req.getParameter("HoVaTen"));
        u.setDiaChi(req.getParameter("DiaChi"));
        u.setDienThoai(req.getParameter("DienThoai"));
        u.setEmail(req.getParameter("Email"));
        u.setVaiTro(Integer.parseInt(req.getParameter("VaiTro")));

        if (u.getId() == 0) {
            dao.insert(u);
        } else {
            dao.update(u);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/user");
    }
}
