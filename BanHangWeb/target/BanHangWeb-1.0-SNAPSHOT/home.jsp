<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(to bottom right, #f8f9fa, #e9ecef);
            margin: 0;
            padding: 0;
            color: #333;
        }

        h2 {
            text-align: center;
            margin-top: 40px;
            color: #2b2d42;
            font-size: 28px;
            letter-spacing: 0.5px;
        }

        /* Thanh điều hướng */
        .top-nav {
            background: #1d3557;
            color: #fff;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .top-nav strong {
            font-size: 20px;
            letter-spacing: 1px;
        }

        .top-nav a {
            color: #f1faee;
            text-decoration: none;
            margin: 0 10px;
            transition: 0.3s;
            font-weight: 500;
        }

        .top-nav a:hover {
            color: #a8dadc;
        }

        /* Lưới sản phẩm */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            padding: 30px 60px;
        }

        /* Thẻ sản phẩm */
        .product-item {
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .product-item:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transform: translateY(-5px);
        }

        .product-item img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .product-item h3 {
            margin: 10px 0 5px;
            color: #1d3557;
            font-size: 18px;
        }

        .product-item p {
            color: #555;
            font-size: 14px;
            padding: 0 10px;
            min-height: 40px;
        }

        .product-item b {
            display: block;
            color: #e63946;
            font-size: 17px;
            margin: 5px 0;
        }

        /* Nút mua hàng */
        .btn-buy {
            background: linear-gradient(135deg, #2a9d8f, #21867a);
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            color: #fff;
            cursor: pointer;
            margin: 10px 0 15px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-buy:hover {
            background: linear-gradient(135deg, #21867a, #1a5f55);
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<!-- Thanh điều hướng -->
<div class="top-nav">
    <div>
        <strong>🛒 NHT SHOP</strong>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </div>
</div>

<h2>Danh sách sản phẩm</h2>

<!-- Danh sách sản phẩm -->
<div class="product-grid">
    <c:forEach var="sp" items="${list}">
        <div class="product-item">
            <img src="${sp.hinhAnh}" alt="${sp.tenSP}">
            <h3>${sp.tenSP}</h3>
            <p>${sp.motaSP}</p>
            <p><b>${sp.gia}₫</b></p>

            <form method="get" action="${pageContext.request.contextPath}/cart">
                <input type="hidden" name="add" value="${sp.maSP}"/>
                <button type="submit" class="btn-buy">🛒 Mua hàng</button>
            </form>
        </div>
    </c:forEach>
</div>

</body>
</html>
