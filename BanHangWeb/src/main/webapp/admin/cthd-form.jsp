<%-- 
    Document   : cthd-form
    Updated    : Oct 10, 2025
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${editMode ? 'Sửa' : 'Thêm'} Chi tiết Hóa đơn</title>
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
            width: 480px;
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

        select, input[type=text], input[type=number], input[type=date] {
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

        .row {
            display: flex;
            gap: 12px;
        }

        .row > div {
            flex: 1;
        }

        .msg {
            color: #c00;
            background: #ffebee;
            padding: 8px 12px;
            border-radius: 6px;
            border-left: 4px solid #d32f2f;
            margin-bottom: 12px;
            font-size: 14px;
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
    <%-- Xử lý logic lấy dữ liệu JSP giữ nguyên --%>
    <input type="hidden" name="MaHD" value="${MaHD}"/>

    <c:set var="maHDView" value="${not empty MaHD ? MaHD : param.MaHD}" />
    <c:set var="soLuongView" value="${not empty SoLuong ? SoLuong : (not empty cthd ? cthd.soLuong : 1)}" />
    <c:set var="maSPView" value="${not empty MaSP ? MaSP : (not empty cthd ? cthd.maSP : null)}" />
    <c:set var="editMode" value="${not empty maSPView}" />
    <c:set var="dsSanPham" value="${not empty sanphams ? sanphams : dsSP}" />

    <c:if test="${empty maHDView}">
        <div class="msg">⚠ Thiếu mã hóa đơn! Vui lòng quay lại trang hóa đơn.</div>
        <p><a href="${pageContext.request.contextPath}/admin/hoadon">⬅ Quay lại Hóa đơn</a></p>
    </c:if>

    <c:if test="${not empty maHDView}">
        <h2>
            <c:choose>
                <c:when test="${editMode}">Sửa</c:when>
                <c:otherwise>Thêm</c:otherwise>
            </c:choose>
            Chi tiết Hóa đơn #${maHDView}
        </h2>

        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/admin/cthd">
            <input type="hidden" name="MaHD" value="${maHDView}"/>
            <input type="hidden" name="mode" value="${editMode ? 'update' : 'add'}"/>

            <c:choose>
                <c:when test="${!editMode}">
                    <label>Sản phẩm <span style="color:#c00">*</span></label>
                    <c:choose>
                        <c:when test="${not empty dsSanPham}">
                            <select name="MaSP" required>
                                <option value="">-- Chọn sản phẩm --</option>
                                <c:forEach var="sp" items="${dsSanPham}">
                                    <option value="${sp.maSP}">
                                        ${sp.maSP} - ${sp.tenSP}
                                        <c:if test="${not empty sp.donGia}"> (Giá: ${sp.donGia})</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="number" name="MaSP" placeholder="Nhập mã sản phẩm" required/>
                        </c:otherwise>
                    </c:choose>
                </c:when>

                <c:otherwise>
                    <div class="row">
                        <div>
                            <label>Mã sản phẩm</label>
                            <input type="text" name="MaSP" value="${maSPView}" readonly/>
                        </div>
                        <div>
                            <label>Tên sản phẩm</label>
                            <input type="text" value="${not empty cthd ? cthd.tenSP : ''}" readonly/>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <label>Số lượng <span style="color:#c00">*</span></label>
            <input type="number" name="SoLuong" min="1" value="${soLuongView}" required/>

            <div class="btn-container">
                <button type="submit">💾 Lưu</button>
                <a href="${pageContext.request.contextPath}/admin/cthd?MaHD=${maHDView}">← Hủy</a>
            </div>
        </form>

        <div class="footer-note">Trang chi tiết hóa đơn • 2025</div>
    </c:if>
</div>

</body>
</html>
