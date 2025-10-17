<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Chi tiết hóa đơn</title>
    <style>
        body { font-family: "Segoe UI", Arial, sans-serif; background: #f8fafc; color: #333; margin: 0; padding: 40px; }
        h2 { text-align: center; color: #222; margin-bottom: 25px; font-size: 26px; }
        .container { max-width: 960px; margin: 0 auto; background: #fff; border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); padding: 30px 40px; }
        form.inline { display: flex; flex-wrap: wrap; gap: 10px; align-items: center; margin-bottom: 20px; }
        input[type=text], input[type=number], select { padding: 8px 10px; border: 1px solid #ccc;
            border-radius: 6px; font-size: 15px; }
        button { background: #007bff; border: none; color: #fff; padding: 10px 18px;
            border-radius: 6px; cursor: pointer; transition: background 0.25s; }
        button:hover { background: #0056b3; }
        a { text-decoration: none; color: #007bff; } a:hover { text-decoration: underline; }
        table { width: 100%; border-collapse: collapse; overflow: hidden; border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        th { background: #007bff; color: white; padding: 12px; text-align: left; font-weight: 600; }
        td { padding: 10px 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f1f6ff; transition: 0.3s; }
        .actions a { color: #dc3545; font-weight: 600; }
        .actions a:hover { text-decoration: underline; }
        .back { display: inline-block; margin-top: 20px; padding: 10px 16px;
            background: #6c757d; color: white; border-radius: 6px; text-decoration: none; }
        .back:hover { background: #5a6268; }
        .empty { text-align: center; color: #777; font-style: italic; }
    </style>
</head>
<body>
<div class="container">

    <c:set var="maHDView" value="${not empty maHD ? maHD : param.MaHD}" />
    <h2>Chi tiết hóa đơn #${maHDView}</h2>

    <!-- 🔍 Form lọc / tìm kiếm -->
    <form class="inline" method="get" action="${pageContext.request.contextPath}/admin/cthd">
        <input type="hidden" name="MaHD" value="${maHDView}">
        <input type="text" name="keyword" placeholder="Tìm theo tên hoặc mã SP" value="${param.keyword}">
        <button type="submit">🔎 Tìm kiếm</button>
        <a href="${pageContext.request.contextPath}/admin/cthd?MaHD=${maHDView}" 
           style="margin-left:10px;color:#555;">↺ Làm mới</a>
    </form>

    <!-- 🧾 Form thêm sản phẩm -->
    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/cthd">
        <input type="hidden" name="MaHD" value="${maHDView}"/>
        <label>Mã SP:</label>
        <input name="MaSP" type="number" required/>
        <label>SL:</label>
        <input name="SoLuong" type="number" min="1" value="1" required/>
        <button type="submit">➕ Thêm</button>
    </form>

    <table>
        <tr>
            <th>Mã SP</th>
            <th>Tên SP</th>
            <th>Đơn giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Hành động</th>
        </tr>
        <c:forEach var="c" items="${list}">
            <tr>
                <td>${c.maSP}</td>
                <td>${c.tenSP}</td>
                <td>${c.donGia}</td>
                <td>${c.soLuong}</td>
                <td>${c.donGia * c.soLuong}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/cthd?action=delete&MaHD=${maHDView}&MaSP=${c.maSP}"
                       onclick="return confirm('Xóa sản phẩm ${c.maSP}?');">🗑 Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty list}">
            <tr><td colspan="6" class="empty">Chưa có chi tiết nào.</td></tr>
        </c:if>
    </table>

    <a class="back" href="${pageContext.request.contextPath}/admin/hoadon">⬅ Quay lại Hóa đơn</a>
</div>
</body>
</html>
