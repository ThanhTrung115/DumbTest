<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.CartItem" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
        :root {
            --primary-color: #0077b6; --secondary-color: #00b4d8; --success-color: #2a9d8f;
            --danger-color: #e76f51; --text-color: #264653; --card-bg-color: #ffffff; --light-bg: #f8f9fa;
            --border-radius: 12px; --box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--light-bg); color: var(--text-color); line-height: 1.6; }
        .navbar { background-color: var(--card-bg-color); padding: 1rem 2.5rem; box-shadow: 0 4px 15px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 1000; }
        .navbar .logo { font-size: 1.8rem; font-weight: 700; color: var(--primary-color); text-decoration: none; }
        .navbar .nav-links a { color: var(--text-color); text-decoration: none; margin-left: 25px; font-weight: 500; transition: color 0.3s; }
        .navbar .nav-links a:hover { color: var(--primary-color); }
        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .page-header { margin-bottom: 30px; font-size: 2.5rem; font-weight: 700; color: var(--text-color); text-align: center; }
        .styled-table { width: 100%; border-collapse: collapse; background: var(--card-bg-color); border-radius: var(--border-radius); box-shadow: var(--box-shadow); overflow: hidden; }
        .styled-table th, .styled-table td { padding: 18px; text-align: left; border-bottom: 1px solid #dee2e6; }
        .styled-table thead { background: linear-gradient(45deg, var(--primary-color), var(--secondary-color)); color: #fff; }
        .styled-table tbody tr:hover { background-color: #f1f1f1; }
        .cart-total { text-align: right; margin-top: 25px; font-size: 1.8rem; font-weight: 700; }
        .cart-actions { margin-top: 25px; display: flex; justify-content: space-between; align-items: center; }
        .btn {
            display: inline-flex; align-items: center; gap: 8px; padding: 12px 25px; border: none; border-radius: var(--border-radius);
            color: #fff; cursor: pointer; font-size: 16px; font-weight: 600; text-decoration: none; transition: all 0.3s ease;
        }
        .btn-primary { background: linear-gradient(45deg, #6c757d, #343a40); box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3); }
        .btn-primary:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4); }
        .btn-success { background: linear-gradient(45deg, var(--success-color), #208b80); box-shadow: 0 4px 15px rgba(42, 157, 143, 0.3); }
        .btn-success:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(42, 157, 143, 0.4); }
        .btn-danger { background: linear-gradient(45deg, var(--danger-color), #d05a3b); box-shadow: 0 4px 15px rgba(231, 111, 81, 0.3); padding: 8px 15px; font-size: 14px; }
        .btn-danger:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(231, 111, 81, 0.4); }
        .empty-cart { text-align: center; padding: 50px; }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="logo">VibrantShop</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
            <c:if test="${not empty sessionScope.currentUser}"><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></c:if>
        </div>
    </nav>
    <div class="container">
        <h1 class="page-header">Giỏ Hàng Của Bạn</h1>
        <%
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("CART");
            double tong = 0;
        %>
        <c:choose>
            <c:when test="${empty cart || cart.isEmpty()}">
                <div class="empty-cart">
                    <h2>Giỏ hàng của bạn đang trống!</h2>
                    <p>Hãy khám phá các sản phẩm tuyệt vời của chúng tôi.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary"><i class="fa-solid fa-store"></i> Bắt đầu mua sắm</a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="styled-table">
                    <thead><tr><th>Sản phẩm</th><th>Giá</th><th>Số lượng</th><th>Thành tiền</th><th></th></tr></thead>
                    <tbody>
                        <% for (CartItem item : cart.values()) { 
                           double tt = item.getThanhTien();
                           tong += tt;
                        %>
                        <tr>
                            <td><%= item.getSp().getTenSP() %></td>
                            <td><%= String.format("%,.0f", item.getSp().getGia()) %> ₫</td>
                            <td><%= item.getSoLuong() %></td>
                            <td><%= String.format("%,.0f", tt) %> ₫</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="remove"/>
                                    <input type="hidden" name="MaSP" value="<%= item.getSp().getMaSP() %>"/>
                                    <button type="submit" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <p class="cart-total">Tổng cộng: <%= String.format("%,.0f", tong) %> ₫</p>
                <div class="cart-actions">
                     <a href="${pageContext.request.contextPath}/home" class="btn btn-primary"><i class="fa-solid fa-arrow-left"></i> Tiếp tục mua sắm</a>
                     <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <button type="submit" class="btn btn-success">Tiến hành thanh toán <i class="fa-solid fa-arrow-right"></i></button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>