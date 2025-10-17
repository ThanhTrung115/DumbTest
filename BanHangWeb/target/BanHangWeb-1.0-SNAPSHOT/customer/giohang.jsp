<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.CartItem" %>
<html>
<head>
    <title>Giỏ hàng của bạn</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background-color: #f8f9fa; 
            margin: 0;
        }
        h2 { 
            text-align: center; 
            color: #333; 
            margin-top: 30px;
        }
        table { 
            width: 85%; 
            margin: 30px auto; 
            border-collapse: collapse; 
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td { 
            border: 1px solid #ddd; 
            padding: 10px; 
            text-align: center; 
        }
        th { 
            background-color: #007bff; 
            color: white; 
            text-transform: uppercase;
        }
        .btn {
            background: #28a745; 
            color: white; 
            border: none; 
            padding: 8px 15px; 
            border-radius: 5px; 
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover { background: #218838; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .total { 
            text-align: right; 
            margin-right: 10%; 
            font-size: 18px; 
            color: #333;
        }
        .nav-links {
            text-align: center;
            margin-bottom: 15px;
        }
        .nav-links a {
            color: #007bff;
            text-decoration: none;
            margin: 0 10px;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>🛍 Giỏ hàng của bạn</h2>

<div class="nav-links">
    <a href="<%= request.getContextPath() %>/home">← Tiếp tục mua hàng</a> |
    <a href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
</div>

<%
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("CART");
    double tong = 0;
%>

<table>
<tr>
    <th>Mã SP</th>
    <th>Tên sản phẩm</th>
    <th>Giá</th>
    <th>Số lượng</th>
    <th>Thành tiền</th>
    <th>Thao tác</th>
</tr>
<%
if (cart != null && !cart.isEmpty()) {
    for (CartItem item : cart.values()) {
        double tt = item.getThanhTien();
        tong += tt;
%>
<tr>
    <td><%= item.getSp().getMaSP() %></td>
    <td><%= item.getSp().getTenSP() %></td>
    <td><%= String.format("%,.0f", item.getSp().getGia()) %> ₫</td>
    <td><%= item.getSoLuong() %></td>
    <td><%= String.format("%,.0f", tt) %> ₫</td>
    <td>
        <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
            <input type="hidden" name="action" value="remove"/>
            <input type="hidden" name="MaSP" value="<%= item.getSp().getMaSP() %>"/>
            <button type="submit" class="btn btn-danger">Xóa</button>
        </form>
    </td>
</tr>
<%
    }
} else {
%>
<tr><td colspan="6">🛒 Giỏ hàng trống!</td></tr>
<%
}
%>
</table>

<p class="total"><b>Tổng cộng:</b> <%= String.format("%,.0f", tong) %> ₫</p>

<div style="text-align:center;">
    <form action="<%= request.getContextPath() %>/checkout" method="post">
        <button class="btn">Thanh toán</button>
    </form>
</div>


</body>
</html>
