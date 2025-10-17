<%-- 
    Document   : user-list.jsp
    Created on : Oct 9, 2025
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người dùng</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f6fa;
            margin: 0;
            padding: 40px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 20px 30px;
        }
        a.add-btn {
            display: inline-block;
            background: #007bff;
            color: #fff;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 5px;
            margin-bottom: 15px;
            transition: background 0.2s;
        }
        a.add-btn:hover {
            background: #0056b3;
        }
        form.filter-form {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }
        form.filter-form input[type="text"],
        form.filter-form select {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        form.filter-form button {
            background: #28a745;
            border: none;
            color: white;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
        form.filter-form button:hover {
            background: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }
        th {
            background: #007bff;
            color: white;
            padding: 10px;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .action a {
            color: #007bff;
            text-decoration: none;
            margin: 0 4px;
        }
        .action a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Quản lý Người dùng</h2>

    <a href="${pageContext.request.contextPath}/admin/user?action=new" class="add-btn">➕ Thêm mới</a>

    <!-- Bộ lọc và tìm kiếm -->
    <form class="filter-form" method="get" action="${pageContext.request.contextPath}/admin/user">
        <input type="hidden" name="action" value="list">
        <input type="text" name="keyword" placeholder="🔍 Tìm theo tài khoản hoặc họ tên" value="${param.keyword}">
        <select name="role">
            <option value="">-- Tất cả vai trò --</option>
            <option value="1" ${param.role == '1' ? 'selected' : ''}>Admin</option>
            <option value="0" ${param.role == '0' ? 'selected' : ''}>User</option>
        </select>
        <button type="submit">Lọc</button>
    </form>

    <table>
        <tr>
            <th>ID</th>
            <th>Tài khoản</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Vai trò</th>
            <th>Hành động</th>
        </tr>

        <c:forEach var="u" items="${list}">
            <tr>
                <td>${u.id}</td>
                <td>${u.tenDangNhap}</td>
                <td>${u.hoVaTen}</td>
                <td>${u.email}</td>
                <td><c:out value="${u.vaiTro==1?'Admin':'User'}"/></td>
                <td class="action">
                    <a href="${pageContext.request.contextPath}/admin/user?action=edit&Id=${u.id}">Sửa</a> |
                    <a href="${pageContext.request.contextPath}/admin/user?action=delete&Id=${u.id}" 
                       onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty list}">
            <tr><td colspan="6">Không tìm thấy người dùng phù hợp.</td></tr>
        </c:if>
    </table>
</div>
</body>
</html>
