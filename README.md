## Setting up the JBOSS Project and Integration with B2C (using OIDC)

### Install prerequisites

* Install Java Development Kit (JDK) 8 or later
* Install Maven
* Install JBoss EAP 7.4 ([https://developers.redhat.com/products/eap/download](https://developers.redhat.com/products/eap/download))

### Install all pre-requiresites

```powershell
.\install-prerequisites-chocolatey.ps1
```

### Set up the project:

* Create a new directory for your project
* Open VS Code and navigate to the project directory
* Create the files and folders as shown in the artifact below

```xml
pom.xml:

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>jboss-azure-b2c-app</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>

    <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </properties>

    <dependencies>
        <dependency>
            <groupId>javax</groupId>
            <artifactId>javaee-api</artifactId>
            <version>8.0</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>${project.artifactId}</finalName>
    </build>
</project>

src/main/webapp/WEB-INF/web.xml:

<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <login-config>
        <auth-method>OIDC</auth-method>
    </login-config>

    <security-constraint>
        <web-resource-collection>
            <web-resource-name>Protected Area</web-resource-name>
            <url-pattern>/protected/*</url-pattern>
        </web-resource-collection>
        <auth-constraint>
            <role-name>*</role-name>
        </auth-constraint>
    </security-constraint>
</web-app>

src/main/webapp/index.html:

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JBoss Azure B2C OIDC App</title>
</head>
<body>
    <h1>Welcome to JBoss Azure B2C OIDC App</h1>
    <p>Click the button below to log in:</p>
    <a href="protected/hello.jsp">
        <button>Login</button>
    </a>
</body>
</html>

src/main/webapp/protected/hello.jsp:

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

standalone.xml (Add this to your JBoss EAP configuration):

<subsystem xmlns="urn:jboss:domain:keycloak:1.1">
    <secure-deployment name="jboss-azure-b2c-app.war">
        <realm>YOUR_AZURE_B2C_TENANT</realm>
        <auth-server-url>https://YOUR_AZURE_B2C_TENANT.b2clogin.com/YOUR_AZURE_B2C_TENANT.onmicrosoft.com/YOUR_USER_FLOW/v2.0/.well-known/openid-configuration</auth-server-url>
        <ssl-required>EXTERNAL</ssl-required>
        <resource>YOUR_CLIENT_ID</resource>
        <credential name="secret">YOUR_CLIENT_SECRET</credential>
    </secure-deployment>
</subsystem>
```

### Configure Azure B2C:

* Create an Azure B2C tenant if you haven't already
* Register a new application in your Azure B2C tenant
* Create a user flow for sign-up and sign-in
* Note down your tenant name, client ID, and client secret

### Update the `standalone.xml` configuration:

* Locate the `standalone.xml` file in your JBoss EAP installation (usually in the `standalone/configuration` folder)
* Add the `<subsystem>` configuration from the artifact, replacing the placeholders with your Azure B2C information

### Build the application:

* Open a PowerShell window in your project directory
* Run the following command to build the application:

```powershell
mvn clean package
```

### Deploy the application:

* Copy the generated WAR file from the `target` folder to the `standalone/deployments` folder in your JBoss EAP installation

### Start JBoss EAP:

* Open a PowerShell window and navigate to the `bin` folder of your JBoss EAP installation
* Run the following command to start JBoss EAP:
  ```powershell
  .\standalone.bat
  ```

### Access the application

* Open a web browser and go to `http://localhost:8080/jboss-azure-b2c-app`
* Click the "Login" button to initiate the Azure B2C OIDC authentication flow

### To stop JBoss EAP

* Press Ctrl+C in the PowerShell window where JBoss EAP is running
