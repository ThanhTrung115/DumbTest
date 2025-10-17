package controller;

import dao.*;
import model.*;
import util.DBConnect;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    private final SanPhamDAO spDAO = new SanPhamDAO();

    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> getCart(HttpSession session) {
        Object o = session.getAttribute("CART");
        if (o == null) {
            Map<Integer, CartItem> m = new LinkedHashMap<>();
            session.setAttribute("CART", m);
            return m;
        }
        return (Map<Integer, CartItem>) o;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Khi nhấn "Mua hàng"
        String addParam = req.getParameter("add");
        if (addParam != null) {
            try {
                int id = Integer.parseInt(addParam);
                SanPham sp = spDAO.getById(id);
                if (sp != null) {
                    Map<Integer, CartItem> cart = getCart(req.getSession());
                    CartItem item = cart.getOrDefault(id, new CartItem(sp, 0));
                    item.setSoLuong(item.getSoLuong() + 1);
                    cart.put(id, item);
                }
            } catch (NumberFormatException ignored) {}
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // Nếu không có param "add" thì hiển thị giỏ hàng
        req.getRequestDispatcher("/customer/giohang.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = getCart(session);

        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        switch (action) {
            case "remove": {
                int id = Integer.parseInt(req.getParameter("MaSP"));
                cart.remove(id);
                break;
            }
            case "clear": {
                cart.clear();
                break;
            }
            case "checkout": {
                // ✅ Lưu hóa đơn + chi tiết hóa đơn
                User kh = (User) session.getAttribute("user");
                if (kh == null) {
                    resp.sendRedirect(req.getContextPath() + "/login.jsp");
                    return;
                }

                if (cart == null || cart.isEmpty()) {
                    req.setAttribute("message", "Giỏ hàng trống, không thể thanh toán!");
                    req.getRequestDispatcher("/customer/giohang.jsp").forward(req, resp);
                    return;
                }

                HoaDonDAO hdDAO = new HoaDonDAO();
                ChiTietHoaDonDAO ctDAO = new ChiTietHoaDonDAO();

                HoaDon hd = new HoaDon();
                hd.setMaKH(kh.getId());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                hd.setNgayDatHang(sdf.format(new Date()));

                int maHD = hdDAO.insert(hd); // Lấy mã hóa đơn vừa tạo

                for (CartItem item : cart.values()) {
                    ChiTietHoaDon ct = new ChiTietHoaDon();
                    ct.setMaHD(maHD);
                    ct.setMaSP(item.getSp().getMaSP());
                    ct.setSoLuong(item.getSoLuong());
                    ctDAO.insert(ct);
                }

                // Xóa giỏ hàng sau khi thanh toán
                session.removeAttribute("CART");

                // Thông báo kết quả
                req.setAttribute("message", "Thanh toán thành công! Mã đơn hàng của bạn là #" + maHD);
                req.getRequestDispatcher("/customer/thanhtoan.jsp").forward(req, resp);
                return;
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
