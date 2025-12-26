<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${editMode ? 'Sửa' : 'Thêm'} Chi tiết Hóa đơn</title>
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
        .form-control[readonly] { background-color: #e9ecef; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; border: none; border-radius: var(--border-radius); color: #fff; cursor: pointer; font-size: 15px; font-weight: 500; text-decoration: none; transition: all 0.3s ease; margin-right: 10px; }
        .btn-primary { background: var(--primary-color); box-shadow: 0 4px 15px rgba(0, 119, 182, 0.2); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0, 119, 182, 0.3); }
        .btn-cancel { background: #6c757d; }
        .row { display: flex; gap: 20px; }
        .row > .form-group { flex: 1; }
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
                <c:set var="maHDView" value="${not empty MaHD ? MaHD : param.MaHD}" />
                <c:set var="soLuongView" value="${not empty SoLuong ? SoLuong : (not empty cthd ? cthd.soLuong : 1)}" />
                <c:set var="maSPView" value="${not empty MaSP ? MaSP : (not empty cthd ? cthd.maSP : null)}" />
                <c:set var="editMode" value="${not empty maSPView}" />
                <c:set var="dsSanPham" value="${not empty sanphams ? sanphams : dsSP}" />

                <h2>${editMode ? 'Sửa' : 'Thêm'} Sản phẩm vào Hóa đơn #${maHDView}</h2>

                <form method="post" action="${pageContext.request.contextPath}/admin/cthd">
                    <input type="hidden" name="MaHD" value="${maHDView}"/>
                    <input type="hidden" name="mode" value="${editMode ? 'update' : 'add'}"/>

                    <c:choose>
                        <c:when test="${!editMode}">
                            <div class="form-group">
                                <label>Sản phẩm <span style="color:var(--danger-color)">*</span></label>
                                <select name="MaSP" class="form-control" required>
                                    <option value="">-- Chọn sản phẩm --</option>
                                    <c:forEach var="sp" items="${dsSanPham}">
                                        <option value="${sp.maSP}">${sp.maSP} - ${sp.tenSP} (${String.format("%,.0f", sp.gia)} ₫)</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:when>
                        <c:otherwise>
                             <div class="row">
                                <div class="form-group">
                                    <label>Mã sản phẩm</label>
                                    <input type="text" name="MaSP" class="form-control" value="${maSPView}" readonly/>
                                </div>
                                <div class="form-group">
                                    <label>Tên sản phẩm</label>
                                    <input type="text" class="form-control" value="${not empty cthd ? cthd.tenSP : ''}" readonly/>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="form-group">
                        <label>Số lượng <span style="color:var(--danger-color)">*</span></label>
                        <input type="number" name="SoLuong" class="form-control" min="1" value="${soLuongView}" required/>
                    </div>

                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i> Lưu lại</button>
                    <a href="${pageContext.request.contextPath}/admin/cthd?MaHD=${maHDView}" class="btn btn-cancel"><i class="fa-solid fa-xmark"></i> Hủy</a>
                </form>
            </div>
        </main>
    </div>
</body>
</html>