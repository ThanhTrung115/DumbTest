<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
        :root {
            --primary-color: #0077b6; --success-color: #2a9d8f; --text-color: #264653;
            --card-bg-color: #ffffff; --border-radius: 12px; --box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Poppins', sans-serif; color: var(--text-color); line-height: 1.6;
            background: linear-gradient(135deg, #e9f5db, #d4f1f4);
            display: flex; justify-content: center; align-items: center; min-height: 100vh;
        }
        .thank-you-box {
            background: var(--card-bg-color); padding: 50px; text-align: center;
            border-radius: var(--border-radius); box-shadow: var(--box-shadow);
            max-width: 600px; animation: popIn 0.6s ease-out;
        }
        .thank-you-box .icon {
            font-size: 5rem; color: var(--success-color);
            line-height: 1; margin-bottom: 20px;
        }
        .thank-you-box h2 { color: var(--success-color); font-size: 2.5rem; margin-bottom: 15px;}
        .btn {
            display: inline-flex; align-items: center; gap: 8px; padding: 12px 25px; border: none; border-radius: var(--border-radius);
            color: #fff; cursor: pointer; font-size: 16px; font-weight: 600; text-decoration: none;
            transition: all 0.3s ease; background: linear-gradient(45deg, var(--primary-color), #0096c7);
            box-shadow: 0 4px 15px rgba(0, 119, 182, 0.3);
        }
        .btn:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0, 119, 182, 0.4); }
        @keyframes popIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="thank-you-box">
        <div class="icon"><i class="fa-solid fa-circle-check"></i></div>
        <h2>Thanh toán thành công!</h2>
        <p>Cảm ơn bạn đã mua hàng tại VibrantShop. Đơn hàng của bạn đang được xử lý và sẽ sớm được giao đến bạn.</p>
        <br/>
        <a href="${pageContext.request.contextPath}/home" class="btn"><i class="fa-solid fa-house"></i> Về trang chủ</a>
    </div>
</body>
</html>