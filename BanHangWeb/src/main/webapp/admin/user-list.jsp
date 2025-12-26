<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${empty u ? 'Thêm' : 'Sửa'} Người dùng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');
        :root {
            --primary-color: #0077b6; --sidebar-bg: #1d3557; --admin-bg: #f1faee; --text-color: #1d3557;
            --card-bg-color: #ffffff; --danger-color: #e63946; --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.07);
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
        .content-card h2 { font-weight: 600; font-size: 1.8rem; margin-bottom: 25px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ccc; border-radius: var(--border-radius); font-size: 15px; transition: all 0.3s ease; }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.2); }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; border: none; border-radius: var(--border-radius); color: #fff; cursor: pointer; font-size: 15px; font-weight: 500; text-decoration: none; transition: all 0.3s ease; margin-right: 10px; }
        .btn-primary { background: var(--primary-color); box-shadow: 0 4px 15px rgba(0, 119, 182, 0.2); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0, 119, 182, 0.3); }
        .btn-danger { background: #6c757d; }
        @keyframes popIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <aside class="admin-sidebar">
             <h2><i class="fa-solid fa-shield-halved"></i> Admin Panel</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/user" class="active"><i class="fa-solid fa-users"></i> Quản lý Khách hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/sanpham"><i class="fa-solid fa-box-open"></i> Quản lý Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/hoadon"><i class="fa-solid fa-file-invoice-dollar"></i> Quản lý Hóa đơn</a></li>
                <li><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-store"></i> Về trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a></li>
            </ul>
        </aside>
        <main class="admin-content">
            <div class="content-card">
                 <h2>${empty u ? 'Thêm mới Người dùng' : 'Cập nhật Người dùng'}</h2>
                 <form method="post" action="${pageContext.request.contextPath}/admin/user">
                    <input type="hidden" name="Id" value="${u.id}"/>
                    <div class="form-group"><label>Tài khoản:</label><input class="form-control" name="TenDangNhap" value="${u.tenDangNhap}" required/></div>
                    <div class="form-group"><label>Mật khẩu:</label><input class="form-control" name="Password" value="${u.password}" required type="password"/></div>
                    <div class="form-group"><label>Họ tên:</label><input class="form-control" name="HoVaTen" value="${u.hoVaTen}"/></div>
                    <div class="form-group"><label>Email:</label><input class="form-control" name="Email" value="${u.email}" type="email"/></div>
                    <div class="form-group">
                        <label>Vai trò:</label>
                        <select name="VaiTro" class="form-control">
                            <option value="0" ${u.vaiTro==0?'selected':''}>User</option>
                            <option value="1" ${u.vaiTro==1?'selected':''}>Admin</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i> Lưu lại</button>
                    <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-danger"><i class="fa-solid fa-xmark"></i> Hủy</a>
                 </form>
            </div>
        </main>
    </div>
</body>
</html>