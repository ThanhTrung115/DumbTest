package controller;

import dao.SanPhamDAO;
import model.SanPham;
import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/admin/sanpham")
public class AdminSanPhamServlet extends HttpServlet {
    private final SanPhamDAO dao = new SanPhamDAO();

    private boolean isAdmin(HttpServletRequest req) {
        Object u = req.getSession().getAttribute("currentUser");
        return (u instanceof User) && ((User) u).isAdmin();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.getRequestDispatcher("/admin/sanpham-form.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("MaSP"));
                req.setAttribute("sp", dao.getById(id));
                req.getRequestDispatcher("/admin/sanpham-form.jsp").forward(req, resp);
                break;
            case "delete":
                dao.delete(Integer.parseInt(req.getParameter("MaSP")));
                resp.sendRedirect(req.getContextPath() + "/admin/sanpham");
                break;
            default:
                String keyword = req.getParameter("keyword");
                String madmStr = req.getParameter("madm");
                List<SanPham> list;

                if (keyword != null && !keyword.trim().isEmpty()) {
                    list = dao.search(keyword);
                } else if (madmStr != null && !madmStr.trim().isEmpty()) {
                    try {
                        int madm = Integer.parseInt(madmStr);
                        list = dao.filterByDanhMuc(madm);
                    } catch (NumberFormatException e) {
                        list = dao.getAll();
                    }
                } else {
                    list = dao.getAll();
                }

                req.setAttribute("list", list);
                req.getRequestDispatcher("/admin/sanpham-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idStr = req.getParameter("MaSP");
        SanPham s = new SanPham();
        if (idStr != null && !idStr.trim().isEmpty()) s.setMaSP(Integer.parseInt(idStr));
        s.setTenSP(req.getParameter("TenSP"));
        s.setGia(Double.parseDouble(req.getParameter("Gia")));
        s.setSoLuong(Integer.parseInt(req.getParameter("SoLuong")));
        s.setHinhAnh(req.getParameter("HinhAnh"));
        s.setMotaSP(req.getParameter("MotaSP"));
        s.setMaDMSP(Integer.parseInt(req.getParameter("MaDMSP")));
        if (s.getMaSP() == 0) dao.insert(s); else dao.update(s);
        resp.sendRedirect(req.getContextPath() + "/admin/sanpham");
    }
}
