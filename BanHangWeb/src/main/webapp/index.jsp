<%-- 
    Document   : index
    Created on : Oct 9, 2025, 11:30:59 PM
    Author     : Bùi Thành Trung
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.sendRedirect(request.getContextPath() + "/home");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ bán hàng</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        body {
            background: linear-gradient(to bottom right, #f8f9fa, #e9ecef);
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* Thanh topbar */
        .topbar {
            background: linear-gradient(90deg, #007bff, #0056b3);
            color: white;
            padding: 14px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .topbar a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            margin-left: 12px;
            transition: 0.3s;
        }

        .topbar a:hover {
            color: #ffd166;
            text-decoration: underline;
        }

        .welcome {
            font-size: 16px;
            font-weight: 500;
        }

        /* Container chính */
        .container {
            width: 90%;
            max-width: 1100px;
            margin: 50px auto;
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
            animation: fadeIn 0.6s ease-in-out;
        }

        h2 {
            color: #007bff;
            margin-bottom: 15px;
            border-bottom: 3px solid #007bff;
            display: inline-block;
            padding-bottom: 6px;
            font-size: 26px;
        }

        /* Box quản trị */
        .admin-box {
            border: 1px solid #dee2e6;
            border-radius: 12px;
            padding: 25px 20px;
            background-color: #f8f9fa;
            margin-top: 30px;
        }

        .admin-box h3 {
            color: #0056b3;
            margin-bottom: 20px;
            font-size: 20px;
            text-transform: uppercase;
        }

        .admin-box a {
            display: inline-block;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            margin: 5px 10px 10px 0;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .admin-box a:hover {
            background: linear-gradient(135deg, #0056b3, #004494);
            transform: translateY(-2px);
        }

        /* Footer */
        .footer {
            text-align: center;
            color: #666;
            margin: 50px 0 25px;
            font-size: 14px;
            letter-spacing: 0.3px;
        }

        .footer span {
            color: #007bff;
            font-weight: 600;
        }

        /* Hiệu ứng */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<!-- Thanh topbar -->
<div class="topbar">
    <div class="welcome">
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                Xin chào, <b>${sessionScope.currentUser.hoVaTen}</b> 👋
            </c:when>
            <c:otherwise>
                Chào mừng đến với <b>Thành Trung </b> 🛍️
            </c:otherwise>
        </c:choose>
    </div>
    <div>
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                <c:if test="${sessionScope.currentUser.vaiTro == 1}">
                    | <a href="${pageContext.request.contextPath}/admin">Quản trị</a>
                </c:if>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> |
                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Nội dung -->
<div class="container">
    <h2>Trang chủ bán hàng</h2>

    <c:if test="${not empty sessionScope.currentUser && sessionScope.currentUser.vaiTro == 1}">
        <div class="admin-box">
            <h3>Khu vực quản trị</h3>
            <a href="${pageContext.request.contextPath}/admin/user">👥 Quản lý khách hàng</a>
            <a href="${pageContext.request.contextPath}/admin/sanpham">📦 Quản lý sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/hoadon">🧾 Quản lý hóa đơn</a>
            <a href="${pageContext.request.contextPath}/admin/cthd">📋 Chi tiết hóa đơn</a>
        </div>
    </c:if>
</div>

<!-- Footer -->
<div class="footer">
    © 2025 - <span>Hệ thống bán hàng </span> | Thiết kế bởi Bùi Thành Trung 💙
</div>

</body>
</html>
