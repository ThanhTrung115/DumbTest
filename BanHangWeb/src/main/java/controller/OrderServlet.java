/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/controller/OrderServlet.java
package controller;

import dao.*;
import model.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

@WebServlet(urlPatterns="/order")
public class OrderServlet extends HttpServlet {
    private final HoaDonDAO hdDAO=new HoaDonDAO();
    private final ChiTietHoaDonDAO ctDAO=new ChiTietHoaDonDAO();

    @SuppressWarnings("unchecked")
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("currentUser");
        if(u==null){ resp.sendRedirect(req.getContextPath()+"/login"); return; }

        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) req.getSession().getAttribute("CART");
        if(cart==null || cart.isEmpty()){ resp.sendRedirect(req.getContextPath()+"/customer/giohang.jsp"); return; }

        HoaDon hd=new HoaDon();
        hd.setMaKH(u.getId());
        hd.setNgayDatHang(LocalDate.now().toString());
        int newId = hdDAO.insert(hd);

        for(CartItem it: cart.values()){
            ChiTietHoaDon c=new ChiTietHoaDon();
            c.setMaHD(newId); c.setMaSP(it.getSp().getMaSP()); c.setSoLuong(it.getSoLuong());
            ctDAO.insert(c);
        }

        cart.clear();
        resp.sendRedirect(req.getContextPath()+"/customer/thankyou.jsp?maHD="+newId);
    }
}