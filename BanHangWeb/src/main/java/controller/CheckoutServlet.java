/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.HoaDonDAO;
import dao.ChiTietHoaDonDAO;
import model.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private final HoaDonDAO hoaDonDAO = new HoaDonDAO();
    private final ChiTietHoaDonDAO ctDAO = new ChiTietHoaDonDAO();

    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> getCart(HttpSession session) {
        Object o = session.getAttribute("CART");
        if (o == null) return new LinkedHashMap<>();
        return (Map<Integer, CartItem>) o;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User kh = (User) session.getAttribute("currentUser"); // lấy user hiện tại

        if (kh == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Map<Integer, CartItem> cart = getCart(session);
        if (cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // 1️⃣ Tạo hóa đơn
        String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        HoaDon hd = new HoaDon();
        hd.setMaKH(kh.getId());
        hd.setNgayDatHang(today);
        int maHD = hoaDonDAO.insert(hd);

        // 2️⃣ Lưu từng sản phẩm
        for (CartItem item : cart.values()) {
            ChiTietHoaDon ct = new ChiTietHoaDon();
            ct.setMaHD(maHD);
            ct.setMaSP(item.getSp().getMaSP());
            ct.setSoLuong(item.getSoLuong());
            ctDAO.insert(ct);
        }

        // 3️⃣ Xóa giỏ hàng
        session.removeAttribute("CART");

        // 4️⃣ Chuyển đến trang cảm ơn
        resp.sendRedirect(req.getContextPath() + "/customer/thanhtoan.jsp");
    }
}
