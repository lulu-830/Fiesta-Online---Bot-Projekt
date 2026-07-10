# GitHub Beschreibung

**Fiesta Bot (AutoIt)**

Dieses Projekt entstand ausschließlich zu Lern- und Weiterbildungszwecken. Ziel war es, verschiedene Techniken der Automatisierung, GUI-Entwicklung, Speicherzugriffe sowie die Entwicklung komplexer Zustandsautomaten mit AutoIt zu erlernen.

Der Bot wurde **nicht für den produktiven Einsatz oder den Einsatz auf offiziellen Spielservern entwickelt**. Er diente ausschließlich als privates Entwicklungs- und Forschungsprojekt, um den Umgang mit Prozessspeicher, Benutzeroberflächen und automatisierten Abläufen zu verstehen.

---

# README.md

# Fiesta Bot (AutoIt)

## Hinweis

> Dieses Projekt wurde ausschließlich zu Lern- und Weiterbildungszwecken entwickelt.
>
> Es diente dazu, Kenntnisse in den Bereichen:
>
> * AutoIt
> * Windows-API
> * GUI-Programmierung
> * Prozess- und Speicherzugriffe
> * Automatisierung
> * Zustandssteuerung
>
> zu erweitern.
>
> Das Projekt wurde **nicht für den Einsatz auf offiziellen Servern entwickelt** und sollte ausschließlich als technisches Demonstrationsprojekt betrachtet werden.

---

# Projektübersicht

Der Fiesta Bot ist ein experimentelles AutoIt-Projekt, das verschiedene Automatisierungsmechanismen miteinander kombiniert. Neben einer grafischen Oberfläche werden Spielinformationen aus dem Speicher gelesen und verschiedene Abläufe automatisch gesteuert.

Der Schwerpunkt lag dabei auf dem Erlernen verschiedener Programmiertechniken und nicht auf der Entwicklung eines fertigen Produkts.

---

# Funktionen

## GUI

Das Programm besitzt eine vollständig eigene Benutzeroberfläche.

Sie bietet unter anderem:

* Statusfenster
* Log-Ausgabe
* Checkboxen zum Aktivieren einzelner Module
* Buttons zum Konfigurieren der Funktionen
* Hotkey-Steuerung

---

## Hotkeys

| Taste | Funktion      |
| ----- | ------------- |
| F9    | Bot starten   |
| F10   | Bot pausieren |
| F11   | Bot beenden   |

---

## Speicherzugriffe

Zur Demonstration von Windows-Prozesszugriffen liest das Programm verschiedene Werte direkt aus dem Speicher des Spielprozesses.

Ausgelesen werden unter anderem:

* Aktuelle HP
* Maximale HP
* Aktuelle Mana
* Maximale Mana

Die Speicherzugriffe erfolgen über Pointer und Offsets.

---

## Auto Heal

Überwacht kontinuierlich den aktuellen Lebenswert.

Sinkt die HP unter einen konfigurierbaren Grenzwert, wird automatisch die entsprechende Heilfunktion ausgelöst.

Ziel:

* automatische Reaktion auf sinkende Lebenspunkte
* Demonstration ereignisbasierter Automatisierung

---

## Auto Mana

Funktioniert analog zum Auto-Heal.

Sobald die Mana unter einen definierten Wert fällt, wird automatisch die entsprechende Fähigkeit oder Aktion ausgelöst.

---

## Auto Pot

Automatische Verwendung von Heil- bzw. Mana-Tränken.

Die Funktion überprüft die aktuellen Werte und verwendet bei Bedarf die konfigurierte Schnellzugriffstaste.

---

## Auto Pickup

Automatisches Aufheben von Gegenständen.

Dabei werden entsprechende Eingaben simuliert, sobald ein passender Zustand erkannt wurde.

---

## Strich-Bot

Eine experimentelle Automatisierungsfunktion.

Sie demonstriert das automatisierte Wiederholen festgelegter Eingabesequenzen sowie die Steuerung wiederkehrender Bewegungsabläufe.

---

## Auto Miner

Demonstriert die Automatisierung wiederkehrender Arbeitsabläufe.

Die Funktion verarbeitet fortlaufende Zustände und wiederholt definierte Eingaben selbstständig.

---

## Zielsuche

Die Funktion `ZielSuchen()` dient der automatisierten Auswahl eines Ziels.

Dabei werden interne Zustände ausgewertet und passende Aktionen vorbereitet.

---

## Kamerasteuerung

Die Funktion `movcamera()` bewegt die Kamera automatisch.

Sie demonstriert die Steuerung virtueller Eingaben und wiederkehrender Bewegungsabläufe.

---

## Konfigurationssystem

Das Projekt verwendet eine INI-Datei.

Beim Start:

* Laden aller Einstellungen (`_Load()`)

Beim Beenden:

* Speichern aller Einstellungen (`_Save()`)

Dadurch bleiben sämtliche Konfigurationen zwischen Programmstarts erhalten.

---

## Logging

Alle wichtigen Ereignisse werden im integrierten Log-Fenster ausgegeben.

Beispielsweise:

* Start
* Pause
* Beenden
* Statusmeldungen
* aktuelle HP/Mana
* Fehler

Dadurch lassen sich Programmabläufe leicht nachvollziehen.

---

# Verwendete Techniken

Das Projekt kombiniert mehrere Programmierbereiche:

* AutoIt GUI
* Windows API
* Prozessverwaltung
* Speicherzugriffe
* Pointer & Offsets
* Konfigurationsverwaltung
* Hotkeys
* Eventsteuerung
* Schleifen und Zustandsautomaten
* Automatisierte Tastatureingaben

---

# Projektziel

Dieses Repository dient ausschließlich als Lernprojekt.

Während der Entwicklung wurden unter anderem folgende Themen vertieft:

* Aufbau größerer AutoIt-Projekte
* Modularisierung von Funktionen
* GUI-Entwicklung
* Arbeiten mit Speicheradressen
* Automatisierung wiederkehrender Abläufe
* Verwaltung von Konfigurationsdateien
* Fehlerbehandlung und Logging

---

# Haftungsausschluss

Dieses Projekt wurde ausschließlich zu Bildungs-, Forschungs- und Demonstrationszwecken erstellt.

Der Quellcode soll den Aufbau einer komplexeren AutoIt-Anwendung zeigen und dient als Referenz für Programmiertechniken wie GUI-Entwicklung, Prozesskommunikation und Automatisierung.

Eine Nutzung in Umgebungen, in denen solche Automatisierungen gegen geltende Regeln oder Nutzungsbedingungen verstoßen, ist nicht Ziel dieses Projekts.
