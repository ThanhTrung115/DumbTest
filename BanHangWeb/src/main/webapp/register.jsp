<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Vibrant Shop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
        :root {
            --primary-color: #0077b6; --secondary-color: #00b4d8; --success-color: #2a9d8f;
            --danger-color: #e76f51; --text-color: #264653; --card-bg-color: rgba(255, 255, 255, 0.9);
            --border-radius: 12px; --box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Poppins', sans-serif; color: var(--text-color); line-height: 1.6;
            background: linear-gradient(135deg, #caf0f8, #ade8f4);
            display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px 0;
        }
        .auth-container { animation: fadeIn 0.7s ease-in-out; }
        .auth-card {
            background: var(--card-bg-color); backdrop-filter: blur(10px);
            padding: 40px; border-radius: var(--border-radius); box-shadow: var(--box-shadow);
            width: 100%; max-width: 420px; text-align: center; border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .auth-card h2 { color: var(--primary-color); margin-bottom: 25px; font-weight: 700; }
        .form-group { margin-bottom: 20px; text-align: left; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; }
        .form-control {
            width: 100%; padding: 12px 15px; border: 1px solid #ccc;
            border-radius: var(--border-radius); font-size: 16px; transition: all 0.3s ease;
        }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.2); }
        .btn {
            display: inline-block; padding: 12px 25px; border: none; border-radius: var(--border-radius);
            color: #fff; cursor: pointer; font-size: 16px; font-weight: 600; text-decoration: none;
            transition: all 0.3s ease; background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            width: 100%; box-shadow: 0 4px 15px rgba(0, 119, 182, 0.3);
        }
        .btn:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0, 119, 182, 0.4); }
        .auth-card .note { margin-top: 20px; }
        .auth-card .note a { color: var(--primary-color); font-weight: 600; text-decoration: none; }
        @keyframes fadeIn { from { opacity: 0; transform: scale(0.95); } to { opacity: 1; transform: scale(1); } }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h2>Tạo tài khoản mới</h2>
            <form action="register" method="post">
                <div class="form-group"><label for="username">Tài khoản</label><input type="text" id="username" name="username" class="form-control" required /></div>
                <div class="form-group"><label for="password">Mật khẩu</label><input type="password" id="password" name="password" class="form-control" required /></div>
                <div class="form-group"><label for="fullname">Họ và Tên</label><input type="text" id="fullname" name="fullname" class="form-control" required /></div>
                <div class="form-group"><label for="email">Email</label><input type="email" id="email" name="email" class="form-control" required /></div>
                <div class="form-group"><label for="phone">Số điện thoại</label><input type="tel" id="phone" name="phone" class="form-control" /></div>
                <div class="form-group"><label for="address">Địa chỉ</label><input type="text" id="address" name="address" class="form-control" /></div>
                <button type="submit" class="btn">Đăng ký</button>
            </form>
             <div class="note">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
            </div>
        </div>
    </div>
</body>
</html>