<%-- 
    Document   : hoadon-detail
    Created on : Oct 16, 2025
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Hóa đơn</title>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f0f4ff, #ffffff);
            margin: 0;
            padding: 0;
        }

        .container {
            width: 85%;
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            padding: 35px 40px;
            border-radius: 16px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: #007bff;
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .info {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }

        .info p {
            margin: 6px 0;
            color: #333;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #e0e0e0;
            padding: 12px;
            text-align: center;
        }

        th {
            background: #007bff;
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background-color: #f9fbff;
        }

        tr:hover {
            background-color: #eef6ff;
            transition: 0.3s;
        }

        .total {
            text-align: right;
            font-weight: bold;
            color: #d63384;
            font-size: 18px;
            margin-top: 15px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #1e7e34, #138f6c);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .total-row td {
            background: #fff5f8;
            font-weight: 600;
            color: #c2185b;
        }

        .header-icon {
            font-size: 30px;
            vertical-align: middle;
        }
    </style>
</head>
<body>

<div class="container">
    <h2><span class="header-icon">🧾</span> Chi tiết Hóa đơn #${hd.maHD}</h2>

    <div class="info">
        <p><b>👤 Khách hàng:</b> ${hd.maKH}</p>
        <p><b>📅 Ngày đặt hàng:</b> ${hd.ngayDatHang}</p>
    </div>

    <table>
        <tr>
            <th>Mã SP</th>
            <th>Tên sản phẩm</th>
            <th>Đơn giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>

        <c:set var="tong" value="0" />
        <c:forEach var="c" items="${list}">
            <tr>
                <td>${c.maSP}</td>
                <td>${c.tenSP}</td>
                <td>${c.donGia}</td>
                <td>${c.soLuong}</td>
                <td>${c.thanhTien}</td>
            </tr>
            <c:set var="tong" value="${tong + c.thanhTien}" />
        </c:forEach>

        <tr class="total-row">
            <td colspan="4" style="text-align:right;">Tổng cộng:</td>
            <td>${tong} VNĐ</td>
        </tr>
    </table>

    <a href="${pageContext.request.contextPath}/admin/hoadon" class="back-btn">← Quay lại danh sách</a>
</div>

</body>
</html>
