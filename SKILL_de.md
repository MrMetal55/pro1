# SKILL: Erzeuge einen reproduzierbaren 'alles protokollieren' Workflow

Diese Skill-Datei beschreibt einen wiederholbaren Ablauf zum Erstellen einer `SKILL.md`, zum Anlegen eines Sitzungsprotokolls mit den durchgeführten Schritten und zum Persistieren einer Anweisungserinnerung, damit zukünftige Agenten ebenfalls protokollieren und Workspace-Regeln befolgen.

Geltungsbereich
- Workspace-weit: Gilt für das Projekt im Repository-Root.

Ergebnis
- Erzeugt eine `SKILL.md` mit dem Workflow.
- Erstellt ein Sitzungsprotokoll unter `/memories/session/skill_log.md`, das jeden Schritt aufzeichnet.
- Erstellt eine persistente Erinnerung `/memories/skill_instruction.md`, die zukünftige Agenten anweist, ebenso zu protokollieren.

Schritt-für-Schritt Prozess
1. Gesprächsverlauf und Workspace prüfen, um den Workflow und Entscheidungsstellen zu extrahieren.
2. `SKILL.md` mit Schritten, Verzweigungen und Qualitätsprüfungen entwerfen.
3. `SKILL.md` im Repository-Root speichern.
4. Ein Sitzungsprotokoll erstellen und jede durchgeführte Aktion (mit Zeitstempel und kurzer Beschreibung) in `/memories/session/skill_log.md` anhängen.
5. Eine persistente Erinnerung `/memories/skill_instruction.md` erstellen, die die "nächste KI" anweist, ebenfalls alles zu protokollieren und die Workspace-Dateien zu beachten.
6. Überprüfen, dass die Dateien erstellt wurden, und bei Bedarf relevante Prüfungen ausführen.

Entscheidungspunkte / Verzweigungen
- Bei Wunsch nach persönlicher Skill: Statt im Workspace-Root in den Benutzer-Prompts speichern.
- Änderungen an Code oder Operatorverhalten: Tests ausführen oder `flutter analyze` verwenden.

Qualitätsprüfungen
- `SKILL.md` ist im Repository-Root vorhanden und lesbar.
- `/memories/session/skill_log.md` existiert und enthält chronologische Einträge.
- `/memories/skill_instruction.md` existiert und weist zukünftige Agenten an.

Beispiel-Prompts
- "Erstelle eine SKILL.md aus dieser Debugging-Session und speichere sie im Repo-Root."
- "Protokolliere jeden meiner Schritte in einem Sitzungslog und erstelle eine persistente Erinnerung, die zukünftige Agenten anweist, dasselbe zu tun."
- "Füge hinzu: Ergebnis-Formatierung korrigiert und Button-Layout aktualisiert — Eintrag ins Sitzungslog."

Vorgeschlagene nächste Anpassungen
- Übersetze die `SKILL.md` vollständig ins Deutsche (diese Datei).
- Füge automatisierte Prüfungen hinzu, die `flutter analyze` oder `dart format` ausführen und die Ergebnisse dem Sitzungslog anhängen.

Ende der SKILL_de.md
