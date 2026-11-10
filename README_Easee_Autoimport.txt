SOLARABRECHNUNG – EASEE-AUTOIMPORT

WAS SICH ÄNDERT
- Der Easee-Key-Summary-Bericht wird beim Erstellen einer Rechnung für das ausgewählte Quartal automatisch von Easee abgerufen.
- Die bisherige manuelle Easee-Excel-Auswahl und das separate Speichern sind dafür nicht mehr nötig.
- Bereits gespeicherte Easee-Key-Zuordnungen werden weiterverwendet.
- Neue, unbekannte Keys stoppen die Rechnungserstellung bewusst. Sie werden in der Key-Zuordnung angezeigt und müssen einmalig einem Bezüger zugeordnet werden.
- Der bestehende Smart-me-Import, SolarManager-Abruf und die Rechnungsberechnung bleiben erhalten.
- Der manuelle Easee-Excel-Import bleibt als Fallback verfügbar.

INSTALLATION
1. Vorhandene Cloudflare-Worker-Datei sichern.
2. In derselben Cloudflare-Worker-Umgebung den Inhalt von SolarAbrechnung_Worker_mit_Easee_Autoimport.js als Worker-Skript einsetzen.
   Die vorhandene D1-Bindung muss weiterhin DB heißen.
   Das vorhandene Worker-Secret ENCRYPTION_KEY muss weiterhin vorhanden sein (Base64-kodierte 32 Bytes).
3. Easee_D1_Migration.sql einmalig auf derselben D1-Datenbank ausführen, in der bereits solar_connections liegt.
4. SolarAbrechnung_Kundenportal_Easee_Direktimport.html auf GitHub Pages deployen und die bisherige Kundendatei damit ersetzen.
5. Im Portal anmelden, unter «Easee» das eigene Easee-Konto einmalig verbinden und «Verbindung prüfen» ausführen. Die Site-ID wird aus dem Easee-Konto geladen.
6. Unter «Easee-Keys den Bezügern zuordnen» jeden verwendeten Key einmalig dem richtigen Bezüger/Zähler zuordnen und speichern.
7. Danach wie gewohnt das Abrechnungsquartal auswählen und «Rechnungen erstellen» anklicken. Der Easee-Import läuft automatisch.

WICHTIGE HINWEISE
- Easee-Passwort wird nicht in der Datenbank gespeichert. Der Refresh-Token wird mit AES-GCM verschlüsselt in D1 gespeichert und bei Erneuerung rotiert.
- Das Worker-Skript enthält die SolarManager-Routen und die Easee-Routen gemeinsam. Nicht zusätzlich ein zweites export default in den Worker kopieren.
- Vor dem Live-Einsatz muss die Verbindung mit dem eigenen Easee-Konto einmal praktisch getestet werden. Diese Dateien konnten hier syntaktisch geprüft werden; eine Anmeldung bei deinem Easee-Konto oder ein Deployment in deinem Cloudflare-Konto wurde nicht ausgeführt.
- Easee-Key-Summary-Berichte enthalten Summen pro Key und zugehörigen Benutzer. Für einzelne Ladezeitpunkte wäre stattdessen der Easee-Key-Detailed-Report (Kategorie 17) erforderlich.
