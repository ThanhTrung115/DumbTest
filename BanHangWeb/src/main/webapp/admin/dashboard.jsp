<%-- 
    Document   : dashboard
    Created on : Oct 10, 2025
    Author     : Nguyễn Gia Duy
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng điều khiển Admin</title>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', 'Roboto', sans-serif;
            background: linear-gradient(135deg, #dfe9f3, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .dashboard-container {
            background-color: #fff;
            width: 420px;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: #222;
            margin-bottom: 15px;
            font-size: 26px;
            font-weight: 600;
        }

        p {
            font-size: 15px;
            color: #555;
            margin-bottom: 25px;
        }

        .username {
            font-weight: bold;
            color: #007bff;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0 0 30px 0;
        }

        ul li {
            margin: 12px 0;
        }

        ul li a {
            display: block;
            text-decoration: none;
            background-color: #007bff;
            color: #fff;
            padding: 12px 20px;
            border-radius: 10px;
            transition: 0.3s;
            font-size: 16px;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(0,123,255,0.2);
        }

        ul li a:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,123,255,0.25);
        }

        ul li a::before {
            content: "📁 ";
        }

        ul li:nth-child(1) a::before { content: "👥 "; }
        ul li:nth-child(2) a::before { content: "🛍️ "; }
        ul li:nth-child(3) a::before { content: "🧾 "; }
        ul li:nth-child(4) a::before { content: "📦 "; }

        .footer-links {
            margin-top: 10px;
        }

        .footer-links a {
            text-decoration: none;
            color: #dc3545;
            font-weight: 600;
            transition: 0.3s;
        }

        .footer-links a:hover {
            color: #b52b38;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h2>🎛️ Bảng điều khiển quản trị</h2>
    <p>Xin chào, <span class="username">${sessionScope.currentUser.hoVaTen}</span></p>

    <ul>
        <li><a href="${pageContext.request.contextPath}/admin/user">Quản lý khách hàng</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/sanpham">Quản lý sản phẩm</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/hoadon">Quản lý hóa đơn</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/cthd">Quản lý chi tiết hóa đơn</a></li>
    </ul>

    <div class="footer-links">
        <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
    </div>
</div>
</body>
</html>
