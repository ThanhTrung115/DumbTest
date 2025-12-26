<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Vibrant Shop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
        :root {
            --primary-color: #0077b6; --secondary-color: #00b4d8; --success-color: #2a9d8f;
            --text-color: #264653; --card-bg-color: #ffffff; --light-bg: #f8f9fa;
            --border-radius: 12px; --box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Poppins', sans-serif; background-color: var(--light-bg);
            color: var(--text-color); line-height: 1.6;
        }
        .navbar {
            background-color: var(--card-bg-color); padding: 1rem 2.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); display: flex; justify-content: space-between;
            align-items: center; position: sticky; top: 0; z-index: 1000;
        }
        .navbar .logo { font-size: 1.8rem; font-weight: 700; color: var(--primary-color); text-decoration: none; }
        .navbar .nav-links a { color: var(--text-color); text-decoration: none; margin-left: 25px; font-weight: 500; transition: color 0.3s; }
        .navbar .nav-links a:hover { color: var(--primary-color); }
        .navbar .nav-links a i { margin-right: 5px; }
        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .page-header { margin-bottom: 30px; font-size: 2.5rem; font-weight: 700; color: var(--text-color); text-align: center; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; }
        .product-card {
            background: var(--card-bg-color); border-radius: var(--border-radius); box-shadow: var(--box-shadow);
            overflow: hidden; display: flex; flex-direction: column; transition: transform 0.3s, box-shadow 0.3s;
            animation: popIn 0.5s ease-out forwards; opacity: 0;
        }
        .product-card:hover { transform: translateY(-8px); box-shadow: 0 15px 30px rgba(0,0,0,0.15); }
        .product-card img { width: 100%; height: 250px; object-fit: cover; }
        .product-content { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; text-align: center; }
        .product-content h3 { font-size: 1.25rem; margin-bottom: 10px; font-weight: 600; }
        .product-content p { flex-grow: 1; margin-bottom: 10px; font-size: 0.95rem; }
        .product-price { font-size: 1.4rem; font-weight: 700; color: var(--primary-color); margin-bottom: 15px; }
        .btn {
            display: inline-block; padding: 12px 25px; border: none; border-radius: var(--border-radius);
            color: #fff; cursor: pointer; font-size: 16px; font-weight: 600; text-decoration: none;
            transition: all 0.3s ease; background: linear-gradient(45deg, var(--success-color), #208b80);
            width: 100%; box-shadow: 0 4px 15px rgba(42, 157, 143, 0.3);
        }
        .btn:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(42, 157, 143, 0.4); }
        @keyframes popIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
        .product-card:nth-child(2) { animation-delay: 0.1s; }
        .product-card:nth-child(3) { animation-delay: 0.2s; }
        .product-card:nth-child(4) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="logo">VibrantShop</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house"></i>Trang chủ</a>
            <a href="${pageContext.request.contextPath}/cart"><i class="fa-solid fa-cart-shopping"></i>Giỏ hàng</a>
             <c:if test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i>Đăng xuất (${sessionScope.currentUser.hoVaTen})</a>
             </c:if>
        </div>
    </nav>
    <div class="container">
        <h1 class="page-header">Sản Phẩm Của Chúng Tôi</h1>
        <div class="product-grid">
            <c:forEach var="sp" items="${list}">
                <div class="product-card">
                    <img src="${not empty sp.hinhAnh ? sp.hinhAnh : 'https://via.placeholder.com/300'}" alt="${sp.tenSP}">
                    <div class="product-content">
                        <h3>${sp.tenSP}</h3>
                        <p>${sp.motaSP}</p>
                        <p class="product-price">${String.format("%,.0f", sp.gia)} ₫</p>
                        <form method="get" action="${pageContext.request.contextPath}/cart" style="margin-top: auto;">
                            <input type="hidden" name="add" value="${sp.maSP}"/>
                            <button type="submit" class="btn"><i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>