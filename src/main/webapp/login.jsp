<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="j_security_check" method="POST">
        <div>
            <label for="j_username">Username:</label>
            <input type="text" id="j_username" name="j_username" required>
        </div>
        <div>
            <label for="j_password">Password:</label>
            <input type="password" id="j_password" name="j_password" required>
        </div>
        <div>
            <input type="submit" value="Login">
        </div>
    </form>
    <p>
        <a href="YOUR_AZURE_B2C_LOGIN_URL">Login with Azure B2C</a>
    </p>
</body>
</html>