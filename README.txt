# SolarAbrechnung.ch – Firebase-Grundversion

## Enthalten
- Firebase Authentication (E-Mail/Passwort: Registrierung, Anmeldung, Passwort-Reset)
- Firestore mit Eigentümer-Trennung über `ownerUid`
- Verwaltung von Liegenschaften
- Verwaltung von Bezügern und Smart-me-Zählernummern
- Tarifverwaltung pro Liegenschaft
- Smart-me-Excel-Prüfung (B2 = Zähler, B3 = Zeitraum, Spalte E bei Import Total/Bezug Total)
- geprüfte Messwerte werden pro Liegenschaft und Quartal in Firestore gespeichert

## Firebase einrichten
1. In Firebase Console > Authentication > Anmeldemethode: E-Mail/Passwort aktivieren.
2. Firestore Database muss erstellt sein.
3. Firestore > Regeln: Inhalt aus `firestore.rules` publizieren.
4. Lokal Firebase CLI installieren und anmelden:
   `npm install -g firebase-tools`
   `firebase login`
5. Im Ordner dieser Anwendung:
   `firebase use --add` und Projekt `solarabrechnung` wählen.
6. `firebase deploy --only firestore:rules,hosting`

## Wichtig zum Solar Manager und Rechnungen
Diese erste Firebase-Grundversion ruft den Solar Manager absichtlich noch nicht direkt aus dem Browser auf. Ein Cloud-API-Schlüssel darf nicht in öffentliches JavaScript oder Firestore geschrieben werden. Die produktive Solar-Manager-Anbindung benötigt einen serverseitigen Proxy (z. B. Cloudflare Worker mit Secret-Variablen). Danach werden die echten Anlagenkennzahlen, die Solar-Zuteilung, QR-Rechnungen und der E-Mail-Versand integriert. Bis dahin werden keine Solarwerte erfunden und es wird keine definitive Rechnung ausgestellt.

## Kosten / Tarife
Firebase Hosting, Authentication und Firestore können im Spark-Tarif innerhalb der jeweiligen Gratis-Limiten verwendet werden. Prüfe die aktuellen Kontingente in der Firebase Console. Für zusätzliche Serverfunktionen kann ein kostenpflichtiger Tarif erforderlich werden. Der vorgesehene API-Proxy wird deshalb getrennt geplant.

## Sicherheit
Die Web-Konfiguration enthält nur öffentliche Client-Werte. Niemals Service-Account-JSON, private Schlüssel oder Solar-Manager-API-Schlüssel committen. Die Firestore-Regeln müssen vor dem produktiven Einsatz veröffentlicht werden. Für echtes Abo-/Zahlungsmanagement sind zusätzliche serverseitige Prüfungen nötig.
