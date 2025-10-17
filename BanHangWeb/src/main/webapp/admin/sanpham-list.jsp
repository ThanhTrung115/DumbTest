<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            background: #fff;
            margin: 0 auto;
            padding: 25px 35px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 20px;
            font-size: 26px;
        }

        form.filter-form {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 15px;
        }

        input[type="text"], select {
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button {
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            background-color: #1976d2;
            color: white;
            cursor: pointer;
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

        .btn-add:hover { background-color: #1976d2; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; border-radius: 10px; overflow: hidden; }
        th { background-color: #1976d2; color: white; padding: 12px 10px; text-transform: uppercase; font-size: 14px; }
        td { border-bottom: 1px solid #ddd; padding: 10px; text-align: center; color: #333; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        tr:hover { background-color: #e3f2fd; transition: 0.3s; }

        a.action-link { text-decoration: none; padding: 6px 12px; border-radius: 6px; color: white; font-size: 13px; font-weight: 500; transition: 0.3s; }
        a.edit { background-color: #4caf50; }
        a.edit:hover { background-color: #43a047; }
        a.delete { background-color: #f44336; }
        a.delete:hover { background-color: #d32f2f; }

        .no-data { text-align: center; padding: 20px; color: #777; font-style: italic; }
    </style>
</head>
<body>
<div class="container">
    <h2>📦 Quản lý Sản phẩm</h2>

    <form class="filter-form" method="get" action="${pageContext.request.contextPath}/admin/sanpham">
        <input type="text" name="keyword" value="${param.keyword}" placeholder="🔍 Tìm theo tên sản phẩm...">
        <select name="madm">
            <option value="">-- Tất cả danh mục --</option>
            <option value="1" ${param.madm == '1' ? 'selected' : ''}>Danh mục 1</option>
            <option value="2" ${param.madm == '2' ? 'selected' : ''}>Danh mục 2</option>
            <option value="3" ${param.madm == '3' ? 'selected' : ''}>Danh mục 3</option>
        </select>
        <button type="submit">Lọc </button>
    </form>

    <p>
        <a href="${pageContext.request.contextPath}/admin/sanpham?action=new" class="btn-add">➕ Thêm mới</a>
    </p>

    <table>
        <tr>
            <th>Mã SP</th>
            <th>Tên sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Mã danh mục</th>
            <th>Hành động</th>
        </tr>

        <c:choose>
            <c:when test="${empty list}">
                <tr><td colspan="6" class="no-data">Không có sản phẩm nào</td></tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="sp" items="${list}">
                    <tr>
                        <td>${sp.maSP}</td>
                        <td>${sp.tenSP}</td>
                        <td>${sp.gia}</td>
                        <td>${sp.soLuong}</td>
                        <td>${sp.maDMSP}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/sanpham?action=edit&MaSP=${sp.maSP}" class="action-link edit">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/sanpham?action=delete&MaSP=${sp.maSP}"
                               class="action-link delete"
                               onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>
</div>
</body>
</html>
