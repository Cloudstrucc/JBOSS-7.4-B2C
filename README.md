# JBoss EAP 7.4 Azure B2C Integration Example

This project demonstrates how to integrate Azure B2C authentication with a JBoss EAP 7.4 web application using OIDC (OpenID Connect).

## Prerequisites

Before you begin, ensure you have:

- Windows 10 or later
- PowerShell 5.1 or later
- Administrator access on your machine
- Git installed
- Web browser (Chrome, Firefox, or Edge)

## Quick Start

1. Clone the repository:

```powershell
git clone https://github.com/Cloudstrucc/JBOSS-7.4-B2C.git
cd JBOSS-7.4-B2C
```

2. Install prerequisites (this will install Chocolatey, OpenJDK 11, and Maven):

```powershell
# Run PowerShell as Administrator
Set-ExecutionPolicy Bypass -Scope Process
.\install-prerequisites-chocolatey.ps1

# After installation, close and reopen PowerShell
refreshenv
```

3. Download JBoss EAP 7.4:
   - Visit [Red Hat JBoss EAP Download Page](https://developers.redhat.com/products/eap/download)
   - Login or create a Red Hat account
   - Download "JBoss EAP 7.4.0" ZIP file
   - Extract to a location of your choice (e.g., `C:\jboss-eap-7.4`)
   - Note: Avoid paths with spaces or special characters

## Initial Configuration

1. Set up configuration files:

```powershell
# Create configuration files from templates
Copy-Item standalone.xml.template standalone.xml
Copy-Item src/main/webapp/WEB-INF/keycloak.json.template src/main/webapp/WEB-INF/keycloak.json
```

2. Configure Azure B2C **(these instructions are for the PACE team - so you must send the redirect URIs to the PACE team to register your registration to the B2C OIDC service)**:

   - Create an Azure B2C tenant if you haven't already
   - Register a new application
   - Set up redirect URIs:
     - Add `http://localhost:8080/jboss-azure-b2c-app/protected/hello.jsp`
     - Add `http://localhost:8080/jboss-azure-b2c-app/`
   - Create a sign-up/sign-in user flow
   - Note down:
     - Your tenant name (e.g., `yourtenant.onmicrosoft.com`)
     - Client ID
     - Client secret
     - User flow name (e.g., `B2C_1_signupsignin`)
3. Update configuration files:

   - In `standalone.xml`:
     ```xml
     <secure-deployment name="jboss-azure-b2c-app.war">
         <realm>{TENANT_NAME}</realm>
         <auth-server-url>https://{TENANT_NAME}.b2clogin.com/{TENANT_NAME}.onmicrosoft.com/{USER_FLOW}/v2.0/.well-known/openid-configuration</auth-server-url>
         <ssl-required>EXTERNAL</ssl-required>
         <resource>{CLIENT_ID}</resource>
         <credential name="secret">{CLIENT_SECRET}</credential>
     </secure-deployment>
     ```
   - In `keycloak.json`:
     ```json
     {
         "realm": "{TENANT_NAME}",
         "auth-server-url": "https://{TENANT_NAME}.b2clogin.com",
         "ssl-required": "external",
         "resource": "{CLIENT_ID}",
         "credentials": {
             "secret": "{CLIENT_SECRET}"
         }
     }
     ```

## Build and Deploy

###    1. Build the application:

```powershell
# Ensure no processes are locking the target directory
tasklist | findstr "java"
taskkill /F /IM java.exe (if needed)

mvn clean package
```

###    2. Deploy to JBoss:

```powershell
# Remove any existing deployments
Remove-Item "[jboss-path]\standalone\deployments\jboss-azure-b2c-app.war*" -Force

# Copy new deployment
Copy-Item "target\jboss-azure-b2c-app.war" "[jboss-path]\standalone\deployments\"
```

###    3: Start JBoss:

```powershell
cd "[jboss-path]\bin"
.\standalone.bat
```

###    4. Access the application:

- Open browser
- Navigate to: `http://localhost:8080/jboss-azure-b2c-app`
- Click "Login" to test the Azure B2C integration

## Project Structure

```
JBOSS-7.4-B2C/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           └── auth/
│       │               └── LogoutServlet.java
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml
│           │   ├── jboss-web.xml
│           │   └── keycloak.json
│           ├── protected/
│           │   └── hello.jsp
│           └── index.html
├── install-prerequisites-chocolatey.ps1
├── pom.xml
├── standalone.xml.template
└── README.md
```

## Extended Troubleshooting

1. ### Maven Build Issues:

   - If target directory is locked:
     ```powershell
     taskkill /F /IM java.exe
     Remove-Item "target" -Recurse -Force
     ```
   - If still locked, restart your computer
   - Run Maven with debug output:
     ```powershell
     mvn clean package -X
     ```
2. ### JBoss Deployment Issues:

   - Check deployment status:
     ```powershell
     Get-Content "[jboss-path]\standalone\deployments\jboss-azure-b2c-app.war.deployed"
     # or check for .failed file
     ```
   - View logs:
     ```powershell
     Get-Content "[jboss-path]\standalone\log\server.log" -Tail 100
     ```
   - Verify JBoss service ports:
     ```powershell
     netstat -ano | findstr "8080"
     netstat -ano | findstr "9990"
     ```
3. ### Authentication Errors:

   - Verify OIDC metadata endpoint:
     ```
     https://{TENANT_NAME}.b2clogin.com/{TENANT_NAME}.onmicrosoft.com/{USER_FLOW}/v2.0/.well-known/openid-configuration
     ```
   - Check redirect URI registration in Azure B2C
   - Ensure all placeholder values are replaced in configuration files
   - Verify user flow name matches exactly
   - Test connectivity to Azure B2C endpoints
   - Check browser console for CORS issues
4. ### Common Issues and Solutions:

   - "Unknown authentication mechanism":
     - Verify keycloak adapter installation
     - Check security domain configuration
   - "Failed to delete target directory":
     - Close all IDEs and terminals
     - Kill Java processes
     - Restart system if needed
   - "Deployment failed":
     - Check server.log for detailed error messages
     - Verify XML syntax in configuration files
     - Ensure all dependencies are resolved

## Development

- Java 11 required (OpenJDK recommended)
- Maven 3.6+ required
- JBoss EAP 7.4.0.GA
- Java EE 8 web components
- Azure B2C OIDC integration

## Security Notes

1. ### Configuration Security:

   - Keep sensitive configuration files out of version control
   - Use template files with placeholders
   - Regularly rotate client secrets
   - Use environment-specific configurations
2. ### Deployment Security:

   - Use HTTPS in production
   - Configure secure headers
   - Follow JBoss security best practices
   - Regular security updates

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines

- Follow existing code style
- Add unit tests for new features
- Update documentation
- Test thoroughly before submitting

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- JBoss EAP team for the application server
- Microsoft Azure B2C team for the identity platform
- Contributors and maintainers
- Red Hat for JBoss EAP documentation

## Contact

For questions, issues, or suggestions:

1. Open an issue in the repository
2. Submit a pull request
3. Contact the maintainers

## Version History

- 1.0.0
  - Initial release
  - Basic Azure B2C integration
  - Form-based authentication support

For the latest updates and changes, check the [releases page](https://github.com/Cloudstrucc/JBOSS-7.4-B2C/releases).
