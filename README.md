# JBoss EAP 7.4 Azure B2C Integration Example

This project demonstrates how to integrate Azure B2C authentication with a JBoss EAP 7.4 web application using OIDC (OpenID Connect).

## Prerequisites

Before you begin, ensure you have:

- Windows 10 or later
- PowerShell 5.1 or later
- Administrator access on your machine

## Quick Start

1. Clone the repository:

```powershell
git clone https://github.com/[your-username]/JBOSS-7.4-B2C.git
cd JBOSS-7.4-B2C
```

2. Install prerequisites (this will install Chocolatey, OpenJDK 11, and Maven):

```powershell
.\install-prerequisites-chocolatey.ps1
```

3. Download JBoss EAP 7.4:
   - Visit [Red Hat JBoss EAP Download Page](https://developers.redhat.com/products/eap/download)
   - Login or create a Red Hat account
   - Download "JBoss EAP 7.4.0" ZIP file
   - Extract to a location of your choice (e.g., `C:\jboss-eap-7.4`)

## Configuration

1. Configure Azure B2C:

   - Create an Azure B2C tenant if you haven't already
   - Register a new application
   - Create a sign-up/sign-in user flow
   - Note down:
     - Your tenant name
     - Client ID
     - Client secret
2. Update JBoss configuration:

   - Navigate to your JBoss installation's configuration directory
   - Open `standalone/configuration/standalone.xml`
   - Add the keycloak subsystem configuration from the provided `standalone.xml`
   - Replace placeholders:
     - `YOUR_AZURE_B2C_TENANT`
     - `YOUR_USER_FLOW`
     - `YOUR_CLIENT_ID`
     - `YOUR_CLIENT_SECRET`

## Build and Deploy

1. Build the application:

```powershell
mvn clean package
```

2. Deploy to JBoss:

```powershell
# Replace [jboss-path] with your JBoss installation path
Copy-Item "target\jboss-azure-b2c-app.war" "[jboss-path]\standalone\deployments\"
```

3. Start JBoss:

```powershell
cd "[jboss-path]\bin"
.\standalone.bat
```

4. Access the application:
   - Open a browser
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
│           │   └── web.xml
│           ├── protected/
│           │   └── hello.jsp
│           └── index.html
├── install-prerequisites-chocolatey.ps1
├── pom.xml
└── README.md
```

## Troubleshooting

1. Maven not found:

   - Close and reopen PowerShell after installation
   - Run `refreshenv` in PowerShell
2. JBoss deployment errors:

   - Check `[jboss-path]\standalone\log\server.log`
   - Verify Azure B2C configuration in `standalone.xml`
   - Ensure all placeholders are replaced with actual values
3. Authentication errors:

   - Verify Azure B2C application settings
   - Check user flow configuration
   - Ensure client ID and secret are correct

## Development

- The project uses Java 11
- Built with Maven
- Uses standard Java EE 8 web components
- Integrates with Azure B2C using OIDC protocol

## Configuration Setup

1. Copy the template files to create your configuration:
```bash
cp standalone.xml.template standalone.xml
cp src/main/webapp/WEB-INF/keycloak.json.template src/main/webapp/WEB-INF/keycloak.json
```

2. Update the configuration files with your values:
   - In `standalone.xml`:
     - Replace `${CLIENT_ID}` with your Azure B2C Client ID
     - Replace `${CLIENT_SECRET}` with your Azure B2C Client Secret
     - Replace `${TENANT_NAME}` with your Azure B2C Tenant name
   
   - In `keycloak.json`:
     - Replace placeholder values with your Azure B2C configuration

Note: The configuration files contain sensitive information and are excluded from version control.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- JBoss EAP team for the application server
- Microsoft Azure B2C team for the identity platform
- Contributors and maintainers
