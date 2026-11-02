# Mobile Social Media Applikation mit Flutter und einem Firebase Backend

Projektarbeit im Studiengang Mobile Software Development (MSD24), FH JOANNEUM, WS 2026/27.

Autor: Casper Zielinski
Betreuer: Michael Ulm

## Projektziel

Eine mobile Social-Media-App mit Flutter im Frontend und Firebase im Backend. Posts, Kommentare und Antworten auf Kommentare werden über Firestore Snapshot Listeners in Echtzeit angezeigt.

Die App ist die Flutter-Referenzimplementierung für die anschließende Bachelorarbeit. Dort wird dieselbe App mit Flutter, Jetpack Compose (nativ) und Capacitor (Web-basiert) umgesetzt und verglichen. Alle Varianten nutzen dasselbe Firebase-Backend.

## Funktionsumfang

- Authentifizierung per E-Mail und Passwort (Registrierung, Login, Logout)
- Anonymer Gastzugang (Guest Login) mit Lesezugriff auf den Feed
- Posts erstellen und in Echtzeit anzeigen
- Kommentare zu Posts erstellen und in Echtzeit anzeigen
- Antworten auf Kommentare, begrenzt auf eine Ebene (keine Antworten auf Antworten)
- Hell-/Dunkelmodus (Systemeinstellung bzw. Nutzerpräferenz)
- Settings Screen zum Abmelden

## Nicht im Projektumfang

- Likes, Reposten, Folgen, Speichern (Lesezeichen), Teilen sowie Bild-, GIF- und Standort-Anhänge sind in der UI nur als Platzhalter vorhanden und lösen keine Backend-Logik aus
- Verschachtelte Kommentare über eine Ebene hinaus
- Moderation, Benachrichtigungen und Direktnachrichten

Eine funktionale Umsetzung einzelner dieser Funktionen (z. B. Folgen) ist Gegenstand der Bachelorarbeit.

## Technologie

| Bereich | Technologie |
|---|---|
| Frontend | Flutter (Dart) |
| Authentifizierung | Firebase Authentication |
| Datenbank und Echtzeit | Cloud Firestore mit Snapshot Listeners |
| Tests | Flutter `integration_test` |

## Voraussetzungen

- Flutter SDK
- Ein eigenes Firebase-Projekt mit aktivierter Authentication (E-Mail/Passwort und anonym) und Cloud Firestore
- Android-Gerät oder Emulator

## Setup

```bash
git clone https://gitlab.itplus.fh-joanneum.at/study/msd/msd24w/students/q73u44/projwork/mobile-social-media-applikation-mit-flutter-und-einem-firebase-backend.git
cd mobile-social-media-applikation-mit-flutter-und-einem-firebase-backend
flutter pub get
```

Die Firebase-Konfiguration ist nicht im Repository enthalten. Sie wird lokal mit der FlutterFire CLI für das eigene Firebase-Projekt erzeugt:

```bash
flutterfire configure
```

Es dürfen keine Zugangsdaten oder Schlüsseldateien committet werden.

## App starten

```bash
flutter run
```

## Tests

Jeder Flow wird testgetrieben entwickelt: Zuerst entsteht der Integrationstest, danach die Implementierung.

```bash
flutter test integration_test
```

Geplante Testabdeckung:

- Auth Flow: Sign Up, Log In, Log Out, Guest Login
- Post Flow: Post, Comment, Reply
- Echtzeit: Änderung auf Gerät A erscheint ohne Neuladen auf Gerät B
- Security Rules: Schreibzugriffe von Gästen werden abgelehnt

## Erfolgskriterien

1. Alle Integrationstests für Auth Flow und Post Flow bestehen.
2. Echtzeitsynchronisation zwischen zwei Geräten und das Blockieren von Gast-Schreibzugriffen sind getestet.

## Zeitplan

Der Gesamtaufwand beträgt 125 Stunden.

| Meilenstein | Inhalt | Std. |
|---|---|---|
| bis 09.11.2026 (Bericht 1) | Recherche, Projektsetup, Auth Flow mit Integrationstests, Settings Screen, Login- und Signup-Modals | 50 |
| bis 14.12.2026 (Bericht 2) | Post Flow mit Integrationstests, PostFeed Screen, Security Rules | 50 |
| bis 10.01.2027 (Bericht 3) | Fertigstellung Flow und UI, Hell-/Dunkelmodus, Echtzeittest, Reserve | 15 |
| bis 26.01.2027 (Präsentation) | UI-Feinschliff, Bugfixes, Dokumentation, Präsentation | 10 |

## Status

In Planung. Das Konzept liegt vor, die Umsetzung beginnt mit dem Auth Flow.