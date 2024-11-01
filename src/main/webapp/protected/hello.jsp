<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Protected Page</title>
</head>
<body>
    <h1>Hello, ${pageContext.request.userPrincipal.name}!</h1>
    <p>This is a protected page.</p>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <input type="submit" value="Logout">
    </form>
</body>
</html>