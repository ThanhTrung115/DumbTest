<%-- 
    Document   : login
    Created on : Oct 9, 2025, 11:31:17 PM
    Author     : Nguyễn Huy Thông
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng nhập - NHT Shop</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #007bff, #00b4d8);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            color: #333;
        }

        .container {
            width: 380px;
            background: #fff;
            padding: 35px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            animation: fadeIn 0.6s ease-in-out;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 25px;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }

        input[type=text],
        input[type=password] {
            width: 100%;
            padding: 11px 12px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: 0.3s;
            font-size: 15px;
        }

        input[type=text]:focus,
        input[type=password]:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
            outline: none;
        }

        input[type=submit] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        input[type=submit]:hover {
            background: linear-gradient(135deg, #0056b3, #004099);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .note {
            text-align: center;
            margin-top: 20px;
            color: #555;
            font-size: 14px;
        }

        .note a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .note a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .error {
            background: #ffe6e6;
            border: 1px solid #ffb3b3;
            color: #d90429;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 15px;
            font-weight: 500;
        }

        /* Hiệu ứng xuất hiện nhẹ */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng nhập</h2>
        <form action="login" method="post">
            <c:if test="${not empty msg}">
                <div class="error">${msg}</div>
            </c:if>

            <label>Tài khoản:</label>
            <input type="text" name="username" placeholder="Nhập tên đăng nhập" required />

            <label>Mật khẩu:</label>
            <input type="password" name="password" placeholder="Nhập mật khẩu" required />

            <input type="submit" value="Đăng nhập" />
        </form>

        <div class="note">
            <p>Chưa có tài khoản?
                <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
            </p>
        </div>
    </div>
</body>
</html>
