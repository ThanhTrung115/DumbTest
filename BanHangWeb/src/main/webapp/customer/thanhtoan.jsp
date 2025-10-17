<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán thành công</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
            padding-top: 100px;
        }
        .box {
            background: white;
            width: 400px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 { color: #28a745; }
        p { color: #555; }
        .btn {
            background: #007bff; color: white;
            padding: 10px 20px; border: none;
            border-radius: 5px; text-decoration: none;
        }
        .btn:hover { background: #0056b3; }
    </style>
</head>
<body>

<div class="box">
    <h2>🎉 Thanh toán thành công!</h2>
    <p>Cảm ơn bạn đã mua hàng tại cửa hàng của chúng tôi.</p>
    <p>Đơn hàng của bạn đang được xử lý và sẽ sớm được giao đến bạn.</p>
    <a href="${pageContext.request.contextPath}/" class="btn">Về trang chủ</a>
</div>

</body>
</html>
