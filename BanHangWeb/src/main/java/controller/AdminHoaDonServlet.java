package controller;

import dao.HoaDonDAO;
import model.HoaDon;
import model.User;

import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet(urlPatterns="/admin/hoadon")
public class AdminHoaDonServlet extends HttpServlet {
    private final HoaDonDAO dao = new HoaDonDAO();

    private boolean isAdmin(HttpServletRequest req){
        Object u = req.getSession().getAttribute("currentUser");
        return (u instanceof User) && ((User)u).isAdmin();
    }

    @Override 
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(!isAdmin(req)){ resp.sendRedirect(req.getContextPath()+"/login"); return; }

        String action = req.getParameter("action"); 
        if(action == null) action = "list";

        switch (action){
            case "new":  
                req.getRequestDispatcher("/admin/hoadon-form.jsp").forward(req,resp); 
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("MaHD"));
                req.setAttribute("hd", dao.getById(id));
                req.getRequestDispatcher("/admin/hoadon-form.jsp").forward(req,resp); 
                break;
            case "delete":
                dao.delete(Integer.parseInt(req.getParameter("MaHD")));
                resp.sendRedirect(req.getContextPath()+"/admin/hoadon"); 
                break;
            default:
                String keyword = req.getParameter("keyword");
                String ngay = req.getParameter("ngay");

                if ((keyword != null && !keyword.trim().isEmpty()) || (ngay != null && !ngay.trim().isEmpty())) {
                    req.setAttribute("list", dao.searchAndFilter(keyword, ngay));
                } else {
                    req.setAttribute("list", dao.getAll());
                }

                req.getRequestDispatcher("/admin/hoadon-list.jsp").forward(req,resp);
        }
    }

    @Override 
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(!isAdmin(req)){ resp.sendRedirect(req.getContextPath()+"/login"); return; }

        String idStr = req.getParameter("MaHD");
        HoaDon hd = new HoaDon();
        if(idStr != null && !idStr.trim().isEmpty()) hd.setMaHD(Integer.parseInt(idStr));
        hd.setMaKH(Integer.parseInt(req.getParameter("MaKH")));
        hd.setNgayDatHang(req.getParameter("NgayDatHang"));

        if(hd.getMaHD() == 0) dao.insert(hd); 
        else dao.update(hd);

        resp.sendRedirect(req.getContextPath()+"/admin/hoadon");
    }
}
