<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.keycloak.KeycloakSecurityContext" %>
<!DOCTYPE html>
<html>
<head>
    <title>Protected Page</title>
</head>
<body>
    <h1>Protected Page</h1>
    <%
        KeycloakSecurityContext ksc = (KeycloakSecurityContext) request.getAttribute(KeycloakSecurityContext.class.getName());
        if (ksc != null) {
    %>
        <p>Authenticated User: <%= ksc.getIdToken().getPreferredUsername() %></p>
        <p>Token: <%= ksc.getTokenString() %></p>
    <% } else { %>
        <p>Not authenticated</p>
    <% } %>
</body>
</html>