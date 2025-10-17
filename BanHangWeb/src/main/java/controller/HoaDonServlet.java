/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/controller/HoaDonServlet.java
package controller;

import dao.HoaDonDAO;
import dao.ChiTietHoaDonDAO;
import model.HoaDon;
import model.ChiTietHoaDon;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/detail")
public class HoaDonServlet extends HttpServlet {

    private final HoaDonDAO hdDAO = new HoaDonDAO();
    private final ChiTietHoaDonDAO cthdDAO = new ChiTietHoaDonDAO();

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
            case "detail": {
                // Xem chi tiết hóa đơn
                String maHDStr = req.getParameter("MaHD");
                if (maHDStr == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/hoadon");
                    return;
                }
                int maHD = Integer.parseInt(maHDStr);

                HoaDon hd = hdDAO.getById(maHD);
                List<ChiTietHoaDon> list = cthdDAO.getByHD(maHD);

                req.setAttribute("hd", hd);
                req.setAttribute("list", list);

                req.getRequestDispatcher("/admin/hoadon-detail.jsp").forward(req, resp);
                break;
            }
            default: {
                // Danh sách hóa đơn
                List<HoaDon> list = hdDAO.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/admin/hoadon-list.jsp").forward(req, resp);
                break;
            }
        }
    }
}
