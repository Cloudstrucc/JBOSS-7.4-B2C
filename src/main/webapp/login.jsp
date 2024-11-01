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
        <a href="https://cloudstruccb2c.b2clogin.com/cloudstruccb2c.onmicrosoft.com/oauth2/v2.0/authorize?p=b2c_1_test&client_id=66c7a104-680f-4b23-8f18-d6a3f1c01798&response_type=code&redirect_uri=http://localhost:8080/jboss-azure-b2c-app/protected/hello.jsp&scope=openid">Login with Azure B2C</a>
    </p>
</body>
</html>