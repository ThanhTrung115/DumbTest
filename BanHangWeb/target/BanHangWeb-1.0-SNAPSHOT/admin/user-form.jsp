<%-- 
    Document   : user-form
    Created on : Oct 10, 2025, 12:18:36 AM
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${empty u ? 'Thêm' : 'Sửa'} Người dùng</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #f8f9fa);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .form-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            width: 420px;
        }

        h2 {
            text-align: center;
            color: #1976d2;
            margin-bottom: 25px;
            font-size: 22px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            margin-bottom: 18px;
            transition: border-color 0.3s;
        }

        input:focus, select:focus {
            border-color: #1976d2;
            outline: none;
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        button {
            background: #1976d2;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background: #0d47a1;
        }

        a {
            text-decoration: none;
            color: #1976d2;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        .footer-note {
            text-align: center;
            font-size: 13px;
            color: #777;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>${empty u ? 'Thêm' : 'Sửa'} Người dùng</h2>
    <form method="post" action="${pageContext.request.contextPath}/admin/user">
        <input type="hidden" name="Id" value="${u.id}"/>

        <label>Tài khoản:</label>
        <input name="TenDangNhap" value="${u.tenDangNhap}" required/>

        <label>Mật khẩu:</label>
        <input name="Password" value="${u.password}" required type="password"/>

        <label>Họ tên:</label>
        <input name="HoVaTen" value="${u.hoVaTen}"/>

        <label>Email:</label>
        <input name="Email" value="${u.email}" type="email"/>

        <label>Điện thoại:</label>
        <input name="DienThoai" value="${u.dienThoai}" type="tel"/>

        <label>Địa chỉ:</label>
        <input name="DiaChi" value="${u.diaChi}"/>

        <label>Vai trò:</label>
        <select name="VaiTro">
            <option value="0" ${u.vaiTro==0?'selected':''}>User</option>
            <option value="1" ${u.vaiTro==1?'selected':''}>Admin</option>
        </select>

        <div class="btn-container">
            <button type="submit">💾 Lưu</button>
            <a href="${pageContext.request.contextPath}/admin/user">← Quay lại</a>
        </div>
    </form>
    <div class="footer-note">Trang quản trị người dùng • 2025</div>
</div>

</body>
</html>
