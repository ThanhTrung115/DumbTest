<%-- 
    Document   : hoadon-list
    Created on : Oct 9, 2025, 10:05:21 PM
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Hóa đơn</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            margin: 0;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 20px;
            font-size: 26px;
        }

        .container {
            max-width: 900px;
            background: #fff;
            margin: 0 auto;
            padding: 25px 35px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .btn-add {
            display: inline-block;
            background-color: #2196f3;
            color: #fff;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn-add:hover {
            background-color: #1976d2;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background-color: #1976d2;
            color: white;
            padding: 12px 10px;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            color: #333;
        }

        tr:nth-child(even) { background-color: #f9f9f9; }
        tr:hover { background-color: #e3f2fd; transition: 0.3s; }

        a.action-link {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 6px;
            color: white;
            font-size: 13px;
            font-weight: 500;
            transition: 0.3s;
        }

        a.detail { background-color: #17a2b8; }
        a.detail:hover { background-color: #138496; }

        a.edit { background-color: #4caf50; }
        a.edit:hover { background-color: #43a047; }

        a.delete { background-color: #f44336; }
        a.delete:hover { background-color: #d32f2f; }

        .no-data {
            text-align: center;
            padding: 20px;
            color: #777;
            font-style: italic;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        input, button {
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-right: 5px;
        }

        button {
            background: #1976d2;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background: #0d47a1;
        }

        .clear-filter {
            background: #999;
            color: white;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 6px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📜 Quản lý Hóa đơn</h2>

    <p>
        <a href="${pageContext.request.contextPath}/admin/hoadon?action=new" class="btn-add">➕ Thêm mới</a>
    </p>

    <form method="get" action="${pageContext.request.contextPath}/admin/hoadon">
        <input type="text" name="keyword" placeholder="Tìm theo Mã HD hoặc Mã KH" value="${param.keyword}">
        <input type="date" name="ngay" value="${param.ngay}">
        <button type="submit">🔍 Tìm kiếm / Lọc</button>
        <a href="${pageContext.request.contextPath}/admin/hoadon" class="clear-filter">❌ Xóa lọc</a>
    </form>

    <table>
        <tr>
            <th>Mã HD</th>
            <th>Mã KH</th>
            <th>Ngày đặt</th>
            <th>Chi tiết</th>
            <th>Hành động</th>
        </tr>

        <c:choose>
            <c:when test="${empty list}">
                <tr>
                    <td colspan="5" class="no-data">Không có hóa đơn nào</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="h" items="${list}">
                    <tr>
                        <td>${h.maHD}</td>
                        <td>${h.maKH}</td>
                        <td>${h.ngayDatHang}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/hoadon?action=detail&MaHD=${h.maHD}" class="action-link detail">Xem</a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/hoadon?action=edit&MaHD=${h.maHD}" class="action-link edit">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/hoadon?action=delete&MaHD=${h.maHD}"
                               class="action-link delete"
                               onclick="return confirm('Bạn có chắc muốn xóa hóa đơn này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>
</div>
</body>
</html>
