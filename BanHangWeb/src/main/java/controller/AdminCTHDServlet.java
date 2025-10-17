/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/controller/AdminCTHDServlet.java
// src/main/java/controller/AdminCTHDServlet.java
package controller;

import dao.*;
import model.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns="/admin/cthd")
public class AdminCTHDServlet extends HttpServlet {

    private final ChiTietHoaDonDAO cthdDAO = new ChiTietHoaDonDAO();
    private final HoaDonDAO hdDAO = new HoaDonDAO();
    private final SanPhamDAO spDAO = new SanPhamDAO();

    private boolean isAdmin(HttpServletRequest req){
        Object u=req.getSession().getAttribute("currentUser");
        return (u instanceof User) && ((User)u).isAdmin();
    }

    /** parse int an toàn, nếu null/không phải số thì redirect về list */
    private Integer parseIntOrRedirect(String raw, HttpServletResponse resp, HttpServletRequest req, String url) throws IOException{
        if(raw == null) { resp.sendRedirect(req.getContextPath()+url); return null; }
        try { return Integer.parseInt(raw); }
        catch (NumberFormatException ex){ resp.sendRedirect(req.getContextPath()+url); return null; }
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(!isAdmin(req)){ resp.sendRedirect(req.getContextPath()+"/login"); return; }

        String action = req.getParameter("action");
        if(action == null) action = "list";

        // luôn cần MaHD cho mọi action
        Integer maHD = parseIntOrRedirect(req.getParameter("MaHD"), resp, req, "/admin/hoadon");
        if (maHD == null) return;

        switch (action){
            case "new":
                // mở form thêm mới
                req.setAttribute("MaHD", maHD);
                req.setAttribute("sanphams", spDAO.getAll()); // để chọn MaSP
                req.getRequestDispatcher("/admin/cthd-form.jsp").forward(req, resp);
                break;

            case "edit":
                // Mở form sửa chi tiết
                Integer maSP = parseIntOrRedirect(req.getParameter("MaSP"), resp, req, "/admin/cthd?MaHD="+maHD);
                if (maSP == null) return;

                ChiTietHoaDon c = cthdDAO.get(maHD, maSP);
                if (c == null) {
                    // không tồn tại, quay lại danh sách
                    resp.sendRedirect(req.getContextPath()+"/admin/cthd?MaHD="+maHD);
                    return;
                }

                req.setAttribute("MaHD", maHD);
                req.setAttribute("MaSP", c.getMaSP());
                req.setAttribute("SoLuong", c.getSoLuong());
                // edit không cần danh sách sản phẩm (để tránh đổi MaSP), nếu muốn đổi thì có thể load spDAO.getAll()
                req.getRequestDispatcher("/admin/cthd-form.jsp").forward(req, resp);
                break;

            case "delete":
                Integer maSPDel = parseIntOrRedirect(req.getParameter("MaSP"), resp, req, "/admin/cthd?MaHD="+maHD);
                if (maSPDel == null) return;
                cthdDAO.delete(maHD, maSPDel);
                resp.sendRedirect(req.getContextPath()+"/admin/cthd?MaHD="+maHD);
                break;

            default:
                // list
                req.setAttribute("hd", hdDAO.getById(maHD));
                req.setAttribute("list", cthdDAO.getByHD(maHD));
                req.getRequestDispatcher("/admin/cthd-list.jsp").forward(req,resp);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(!isAdmin(req)){ resp.sendRedirect(req.getContextPath()+"/login"); return; }

        Integer maHD = parseIntOrRedirect(req.getParameter("MaHD"), resp, req, "/admin/hoadon");
        if (maHD == null) return;

        String mode = req.getParameter("mode"); // "add" hoặc "update"
        Integer maSP = parseIntOrRedirect(req.getParameter("MaSP"), resp, req, "/admin/cthd?MaHD="+maHD);
        if (maSP == null) return;

        int soLuong = 1;
        try { soLuong = Integer.parseInt(req.getParameter("SoLuong")); } catch (Exception ignore){}

        ChiTietHoaDon c = new ChiTietHoaDon();
        c.setMaHD(maHD);
        c.setMaSP(maSP);
        c.setSoLuong(soLuong);

        if ("update".equalsIgnoreCase(mode)){
            cthdDAO.update(c);
        }else{
            cthdDAO.insert(c);
        }
        resp.sendRedirect(req.getContextPath()+"/admin/cthd?MaHD="+maHD);
    }
}
