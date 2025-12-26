<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Hóa đơn</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');
        :root {
            --primary-color: #0077b6; --sidebar-bg: #1d3557; --admin-bg: #f1faee; --text-color: #1d3557;
            --card-bg-color: #ffffff; --danger-color: #e63946; --warning-color: #fca311; --info-color: #1a759f;
            --light-gray: #e9ecef; --border-radius: 12px; --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.07);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--admin-bg); color: var(--text-color); }
        .admin-wrapper { display: flex; }
        .admin-sidebar { width: 260px; background: var(--sidebar-bg); color: #fff; min-height: 100vh; padding: 20px; position: fixed; }
        .admin-sidebar h2 { text-align: center; margin-bottom: 40px; color: #fff; font-weight: 600; }
        .admin-sidebar ul { list-style: none; }
        .admin-sidebar ul li a { display: flex; align-items: center; gap: 15px; color: #f1faee; padding: 15px; border-radius: var(--border-radius); margin-bottom: 10px; transition: all 0.3s; text-decoration: none;}
        .admin-sidebar ul li a:hover, .admin-sidebar ul li a.active { background-color: #457b9d; transform: translateX(5px); }
        .admin-sidebar ul li a i { font-size: 1.2rem; width: 20px; text-align: center; }
        .admin-content { flex-grow: 1; padding: 40px; margin-left: 260px; }
        .content-card { background: var(--card-bg-color); padding: 30px; border-radius: var(--border-radius); box-shadow: var(--box-shadow); animation: popIn 0.5s ease-out;}
        .content-card .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .content-card .header h2 { font-weight: 600; font-size: 1.8rem; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; border: none; border-radius: var(--border-radius); color: #fff; cursor: pointer; font-size: 15px; font-weight: 500; text-decoration: none; transition: all 0.3s ease; }
        .btn-primary { background: var(--primary-color); box-shadow: 0 4px 15px rgba(0, 119, 182, 0.2); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0, 119, 182, 0.3); }
        .styled-table { width: 100%; border-collapse: collapse; }
        .styled-table th, .styled-table td { padding: 15px; text-align: left; border-bottom: 1px solid var(--light-gray); }
        .styled-table thead { background-color: #f8f9fa; color: var(--text-color); }
        .styled-table tbody tr { transition: background-color 0.3s; }
        .styled-table tbody tr:hover { background-color: #f1f7fe; }
        .action-links a { margin-right: 15px; font-weight: 500; text-decoration: none; font-size: 1.1rem; transition: transform 0.2s; display: inline-block; }
        .action-links a:hover { transform: scale(1.2); }
        a.edit { color: var(--warning-color); }
        a.delete { color: var(--danger-color); }
        a.detail { color: var(--info-color); }
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
                <li><a href="${pageContext.request.contextPath}/admin/hoadon" class="active"><i class="fa-solid fa-file-invoice-dollar"></i> Quản lý Hóa đơn</a></li>
                <li><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-store"></i> Về trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a></li>
            </ul>
        </aside>
        <main class="admin-content">
            <div class="content-card">
                <div class="header">
                    <h2>Danh sách Hóa đơn</h2>
                    <a href="${pageContext.request.contextPath}/admin/hoadon?action=new" class="btn btn-primary"><i class="fa-solid fa-plus"></i> Thêm mới</a>
                </div>
                <table class="styled-table">
                    <thead><tr><th>Mã HD</th><th>Mã KH</th><th>Ngày đặt</th><th>Hành động</th></tr></thead>
                    <tbody>
                        <c:forEach var="h" items="${list}">
                            <tr>
                                <td>#${h.maHD}</td><td>${h.maKH}</td><td>${h.ngayDatHang}</td>
                                <td class="action-links">
                                    <a href="${pageContext.request.contextPath}/admin/cthd?MaHD=${h.maHD}" class="detail" title="Xem chi tiết"><i class="fa-solid fa-eye"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/hoadon?action=edit&MaHD=${h.maHD}" class="edit" title="Sửa"><i class="fa-solid fa-pen-to-square"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/hoadon?action=delete&MaHD=${h.maHD}" class="delete" title="Xóa" onclick="return confirm('Bạn chắc chắn muốn xóa?')"><i class="fa-solid fa-trash-can"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>