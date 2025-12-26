<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');
        :root {
            --primary-color: #0077b6; --sidebar-bg: #1d3557; --admin-bg: #f1faee;
            --text-color: #1d3557; --card-bg-color: #ffffff; --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.07);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--admin-bg); color: var(--text-color); }
        .admin-wrapper { display: flex; }
        .admin-sidebar {
            width: 260px; background: var(--sidebar-bg); color: #fff; min-height: 100vh;
            padding: 20px; position: fixed; transition: width 0.3s ease;
        }
        .admin-sidebar h2 { text-align: center; margin-bottom: 40px; color: #fff; font-weight: 600; }
        .admin-sidebar ul { list-style: none; }
        .admin-sidebar ul li a {
            display: flex; align-items: center; gap: 15px; color: #f1faee; padding: 15px;
            border-radius: var(--border-radius); margin-bottom: 10px; transition: all 0.3s; text-decoration: none;
        }
        .admin-sidebar ul li a:hover, .admin-sidebar ul li a.active { background-color: #457b9d; transform: translateX(5px); }
        .admin-sidebar ul li a i { font-size: 1.2rem; width: 20px; text-align: center; }
        .admin-content { flex-grow: 1; padding: 40px; margin-left: 260px; transition: margin-left 0.3s ease; }
        .content-card {
            background: var(--card-bg-color); padding: 30px; border-radius: var(--border-radius);
            box-shadow: var(--box-shadow); animation: popIn 0.5s ease-out;
        }
        .page-header { margin-bottom: 30px; font-size: 2rem; font-weight: 600; color: var(--text-color); }
        @keyframes popIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <aside class="admin-sidebar">
            <h2><i class="fa-solid fa-shield-halved"></i> Admin Panel</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/user"><i class="fa-solid fa-users"></i> Quản lý Khách hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/sanpham"><i class="fa-solid fa-box-open"></i> Quản lý Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/hoadon"><i class="fa-solid fa-file-invoice-dollar"></i> Quản lý Hóa đơn</a></li>
                <li><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-store"></i> Về trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a></li>
            </ul>
        </aside>
        <main class="admin-content">
            <h1 class="page-header">Bảng điều khiển</h1>
            <div class="content-card">
                <h3>Xin chào, <span style="color: var(--primary-color);">${sessionScope.currentUser.hoVaTen}</span>!</h3>
                <p>Chào mừng bạn đến với trang quản trị. Vui lòng chọn một mục từ thanh bên để bắt đầu.</p>
            </div>
        </main>
    </div>
</body>
</html>