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

  static m5(name) => "Die Galerie ${name} kann nicht gelöscht werden, da sie verwendet wird.";

  static m6(name) => "Soll die Galerie ${name} wirklich gelöscht werden?";

  static m7(name) => "${name} erfolgreich gelöscht";

  static m8(name) => "Löschen von Galerie ${name} fehlgeschlagen";

  static m9(name) => "Wechseln zu ${name}";

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
    "editGalleryActionUpdate" : MessageLookupByLibrary.simpleMessage("Galerie speichern"),
    "editGalleryDescription" : MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "editGalleryExistsError" : MessageLookupByLibrary.simpleMessage("Eine Galerie mit dem Namen existiert bereits"),
    "editGalleryName" : MessageLookupByLibrary.simpleMessage("Name"),
    "editGalleryNameEmpty" : MessageLookupByLibrary.simpleMessage("Bitte gib einen Namen ein"),
    "editGalleryNotEnoughPermissionsError" : MessageLookupByLibrary.simpleMessage("Du hast nicht genug Rechte"),
    "editGalleryOrientation" : MessageLookupByLibrary.simpleMessage("Orientierung"),
    "editGalleryOrientationHorizontal" : MessageLookupByLibrary.simpleMessage("Horizontal"),
    "editGalleryOrientationVertical" : MessageLookupByLibrary.simpleMessage("Vertikal"),
    "editGalleryType" : MessageLookupByLibrary.simpleMessage("Typ"),
    "editGalleryTypeMasonry" : MessageLookupByLibrary.simpleMessage("Raster"),
    "editGalleryTypeSequence" : MessageLookupByLibrary.simpleMessage("Liste"),
    "manageAccountsDeleteSuccess" : m0,
    "manageGalleriesActionDesigner" : MessageLookupByLibrary.simpleMessage("Designer"),
    "manageGalleriesOrientation" : MessageLookupByLibrary.simpleMessage("Orientierung"),
    "manageGalleriesOrientationHorizontal" : MessageLookupByLibrary.simpleMessage("Horizontal"),
    "manageGalleriesOrientationVertical" : MessageLookupByLibrary.simpleMessage("Vertikal"),
    "manageGalleriesType" : MessageLookupByLibrary.simpleMessage("Typ"),
    "manageGalleriesTypeMasonry" : MessageLookupByLibrary.simpleMessage("Raster"),
    "manageGalleriesTypeSequence" : MessageLookupByLibrary.simpleMessage("Liste"),
    "manageMediaFiles" : MessageLookupByLibrary.simpleMessage("Dateien"),
    "manageMediaFilesDeleteConflict" : m1,
    "manageMediaFilesDeleteContent" : m2,
    "manageMediaFilesDeleteSuccess" : m3,
    "manageMediaFilesDeleteTitle" : MessageLookupByLibrary.simpleMessage("Datei wirklich löschen?"),
    "manageMediaFilesDeleteUnknown" : m4,
    "manageMediaGalleries" : MessageLookupByLibrary.simpleMessage("Galerien"),
    "manageMediaGalleriesDeleteConflict" : m5,
    "manageMediaGalleriesDeleteContent" : m6,
    "manageMediaGalleriesDeleteSuccess" : m7,
    "manageMediaGalleriesDeleteTitle" : MessageLookupByLibrary.simpleMessage("Galerie wirklich löschen?"),
    "manageMediaGalleriesDeleteUnknown" : m8,
    "manageMediaTitle" : MessageLookupByLibrary.simpleMessage("Medienverwaltung"),
    "menuAddAccount" : MessageLookupByLibrary.simpleMessage("Account hinzufügen"),
    "menuArtists" : MessageLookupByLibrary.simpleMessage("Künstler"),
    "menuForms" : MessageLookupByLibrary.simpleMessage("Formulare"),
    "menuManageAccounts" : MessageLookupByLibrary.simpleMessage("Accounts verwalten"),
    "menuMedia" : MessageLookupByLibrary.simpleMessage("Medien"),
    "menuMenus" : MessageLookupByLibrary.simpleMessage("Menüs"),
    "menuPages" : MessageLookupByLibrary.simpleMessage("Seiten"),
    "menuSwitchAccount" : m9,
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
    "newFileTitle" : MessageLookupByLibrary.simpleMessage("Neue Datei"),
    "newGalleryActionCreate" : MessageLookupByLibrary.simpleMessage("Galerie erstellen"),
    "newGalleryDescription" : MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "newGalleryExistsError" : MessageLookupByLibrary.simpleMessage("Eine Galerie mit dem Namen existiert bereits"),
    "newGalleryName" : MessageLookupByLibrary.simpleMessage("Name"),
    "newGalleryNameEmpty" : MessageLookupByLibrary.simpleMessage("Bitte gib einen Namen ein"),
    "newGalleryNotEnoughPermissionsError" : MessageLookupByLibrary.simpleMessage("Du hast nicht genug Rechte"),
    "newGalleryOrientation" : MessageLookupByLibrary.simpleMessage("Orientierung"),
    "newGalleryOrientationHorizontal" : MessageLookupByLibrary.simpleMessage("Horizontal"),
    "newGalleryOrientationVertical" : MessageLookupByLibrary.simpleMessage("Vertikal"),
    "newGalleryTitle" : MessageLookupByLibrary.simpleMessage("Neue Galerie"),
    "newGalleryType" : MessageLookupByLibrary.simpleMessage("Typ"),
    "newGalleryTypeMasonry" : MessageLookupByLibrary.simpleMessage("Raster"),
    "newGalleryTypeSequence" : MessageLookupByLibrary.simpleMessage("Liste")
  };
}
