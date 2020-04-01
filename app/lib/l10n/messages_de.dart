// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static m0(name) => "${name} wurde erfolgreich gelöscht";

  static m1(name) => "${name} wird momentan verwendet und kann nicht gelöscht werden.";

  static m2(name) => "Bist du sicher, dass du die Datei ${name} löschen willst? Die Datei wird dadurch aus allen Galerien entfernt.";

  static m3(name) => "Datei ${name} wurde erfolgreich gelöscht";

  static m4(name) => "${name} konnte nicht gelöscht werden.";

  static m5(name) => "Wechseln zu ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "actionDontDelete" : MessageLookupByLibrary.simpleMessage("Nicht löschen"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "actionUndo" : MessageLookupByLibrary.simpleMessage("Rückgängig"),
    "appName" : MessageLookupByLibrary.simpleMessage("Jinya CMS"),
    "editFileActionPickFile" : MessageLookupByLibrary.simpleMessage("Neue Datei auswählen"),
    "editFileActionUpdate" : MessageLookupByLibrary.simpleMessage("Datei aktualisieren"),
    "editFileExistsError" : MessageLookupByLibrary.simpleMessage("Eine Datei mit diesem Namen existiert bereits"),
    "editFileName" : MessageLookupByLibrary.simpleMessage("Name"),
    "editFileNameEmpty" : MessageLookupByLibrary.simpleMessage("Bitte gib einen Namen ein"),
    "editFileNotEnoughPermissionsError" : MessageLookupByLibrary.simpleMessage("Du hast nicht genug Rechte"),
    "manageAccountsDeleteSuccess" : m0,
    "manageMediaFiles" : MessageLookupByLibrary.simpleMessage("Dateien"),
    "manageMediaFilesDeleteConflict" : m1,
    "manageMediaFilesDeleteContent" : m2,
    "manageMediaFilesDeleteSuccess" : m3,
    "manageMediaFilesDeleteTitle" : MessageLookupByLibrary.simpleMessage("Datei wirklich löschen?"),
    "manageMediaFilesDeleteUnknown" : m4,
    "manageMediaTitle" : MessageLookupByLibrary.simpleMessage("Medienverwaltung"),
    "menuAddAccount" : MessageLookupByLibrary.simpleMessage("Account hinzufügen"),
    "menuArtists" : MessageLookupByLibrary.simpleMessage("Künstler"),
    "menuForms" : MessageLookupByLibrary.simpleMessage("Formulare"),
    "menuManageAccounts" : MessageLookupByLibrary.simpleMessage("Accounts verwalten"),
    "menuMedia" : MessageLookupByLibrary.simpleMessage("Medien"),
    "menuMenus" : MessageLookupByLibrary.simpleMessage("Menüs"),
    "menuPages" : MessageLookupByLibrary.simpleMessage("Seiten"),
    "menuSwitchAccount" : m5,
    "menuThemes" : MessageLookupByLibrary.simpleMessage("Themes"),
    "newAccountActionTwoFactorCode" : MessageLookupByLibrary.simpleMessage("ZWEI FAKTOR CODE ANFORDERN"),
    "newAccountErrorExists" : MessageLookupByLibrary.simpleMessage("Ein Account mit dieser Emailadresse ist bereits für diesen Host eingerichtet eingerichtet"),
    "newAccountErrorInvalidCredentials" : MessageLookupByLibrary.simpleMessage("Die eingegebenen Zugangsdaten sind ungültig"),
    "newAccountErrorInvalidEmail" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie eine gültige Emailadresse ein"),
    "newAccountErrorInvalidPassword" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie ein Passwort ein"),
    "newAccountErrorInvalidUrl" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie eine gültige Adresse ein"),
    "newAccountInputEmail" : MessageLookupByLibrary.simpleMessage("Email"),
    "newAccountInputJinyaHost" : MessageLookupByLibrary.simpleMessage("Jinya Host"),
    "newAccountInputPassword" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "newAccountTitle" : MessageLookupByLibrary.simpleMessage("Neuer Jinya Account"),
    "newAccountTwoFactorActionLogin" : MessageLookupByLibrary.simpleMessage("ACCOUNT HINZUFÜGEN"),
    "newAccountTwoFactorErrorInvalidCode" : MessageLookupByLibrary.simpleMessage("Bitte geben Sie einen gültigen Code ein"),
    "newAccountTwoFactorInputCode" : MessageLookupByLibrary.simpleMessage("Zwei Faktor Code"),
    "newFileActionCreate" : MessageLookupByLibrary.simpleMessage("Datei erstellen"),
    "newFileActionPickFile" : MessageLookupByLibrary.simpleMessage("Datei auswählen"),
    "newFileExistsError" : MessageLookupByLibrary.simpleMessage("Eine Datei mit diesem Namen existiert bereits."),
    "newFileName" : MessageLookupByLibrary.simpleMessage("Name"),
    "newFileNameEmpty" : MessageLookupByLibrary.simpleMessage("Bitte gib einen Namen ein"),
    "newFileNotEnoughPermissionsError" : MessageLookupByLibrary.simpleMessage("Du hast nicht die nötigen Rechte."),
    "newFileTitle" : MessageLookupByLibrary.simpleMessage("Neue Datei")
  };
}
