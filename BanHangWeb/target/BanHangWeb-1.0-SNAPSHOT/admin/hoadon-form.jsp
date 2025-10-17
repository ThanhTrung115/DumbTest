<%-- 
    Document   : hoadon-form
    Created on : Oct 9, 2025, 10:05:32 PM
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${empty hd ? 'Thêm' : 'Sửa'} Hóa đơn</title>
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
            width: 400px;
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

        input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            margin-bottom: 18px;
            transition: border-color 0.3s;
        }

        input:focus {
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
    <h2>${empty hd ? 'Thêm' : 'Sửa'} Hóa đơn</h2>
    <form method="post" action="${pageContext.request.contextPath}/admin/hoadon">
        <input type="hidden" name="MaHD" value="${hd.maHD}"/>

        <label>Mã khách hàng:</label>
        <input name="MaKH" type="number" value="${hd.maKH}" required/>

        <label>Ngày đặt hàng:</label>
        <input name="NgayDatHang" type="date" value="${hd.ngayDatHang}" required/>

        <div class="btn-container">
            <button type="submit">💾 Lưu</button>
            <a href="${pageContext.request.contextPath}/admin/hoadon">← Quay lại</a>
        </div>
    </form>

    <div class="footer-note">Trang quản trị hóa đơn • 2025</div>
</div>

</body>
</html>
