# BlogApp

## Zugriff auf die Web-App

Die BlogApp ist hier erreichbar: [https://blue-desert-0c8b6f803.4.azurestaticapps.net](https://blue-desert-0c8b6f803.4.azurestaticapps.net)

**Wichtiger Hinweis:** Aufgrund von CORS (Cross-Origin Resource Sharing)-Richtlinien ist die Web-App momentan leider nicht funktionsfähig, wenn sie auf Azure Static Web Apps gehostet wird. CORS-Einschränkungen verhindern, dass die App Ressourcen von einem anderen Ursprung (Origin) anfordern kann, was für die vollständige Funktionalität der App notwendig ist. Wir bitten um Ihr Verständnis und Ihre Geduld.

## Automatisches Update

Dank eines integrierten GitHub Actions Workflows wird die Webseite bei jedem Push auf den `main`-Branch automatisch aktualisiert. Dieser Prozess stellt sicher, dass stets die aktuellste Version der App online ist.

### GitHub Workflow-Übersicht

Der Azure Static Web Apps CI/CD Workflow umfasst:

1. Flutter-Environment Setup.
2. Installation der Pakete.
3. Web-Build der App.
4. Deployment auf Azure Static Web Apps.

Diese Schritte garantieren eine effiziente und zuverlässige Bereitstellung der neuesten App-Versionen.
