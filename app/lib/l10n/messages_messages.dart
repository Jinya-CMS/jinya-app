// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(name) => "Switch to ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Jinya CMS"),
        "menuAddAccount": MessageLookupByLibrary.simpleMessage("Add Account"),
        "menuArtists": MessageLookupByLibrary.simpleMessage("Artists"),
        "menuForms": MessageLookupByLibrary.simpleMessage("Forms"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Manage Accounts"),
        "menuMedia": MessageLookupByLibrary.simpleMessage("Media"),
        "menuMenus": MessageLookupByLibrary.simpleMessage("Menus"),
        "menuPages": MessageLookupByLibrary.simpleMessage("Pages"),
        "menuSwitchAccount": m0,
        "menuThemes": MessageLookupByLibrary.simpleMessage("Themes"),
        "newAccountActionTwoFactorCode":
            MessageLookupByLibrary.simpleMessage("REQUEST TWO FACTOR CODE"),
        "newAccountErrorExists": MessageLookupByLibrary.simpleMessage(
            "An account with the email address already exists"),
        "newAccountErrorInvalidCredentials":
            MessageLookupByLibrary.simpleMessage(
                "The credentials you provided are invalid"),
        "newAccountErrorInvalidEmail": MessageLookupByLibrary.simpleMessage(
            "This is not a valid email address"),
        "newAccountErrorInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "You need to input a password"),
        "newAccountErrorInvalidUrl": MessageLookupByLibrary.simpleMessage(
            "This is not a valid Jinya Host Url"),
        "newAccountInputEmail":
            MessageLookupByLibrary.simpleMessage("Email address"),
        "newAccountInputJinyaHost":
            MessageLookupByLibrary.simpleMessage("Jinya Host"),
        "newAccountInputPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "newAccountTitle":
            MessageLookupByLibrary.simpleMessage("Add Jinya Account"),
        "newAccountTwoFactorActionLogin":
            MessageLookupByLibrary.simpleMessage("ADD ACCOUNT"),
        "newAccountTwoFactorErrorInvalidCode":
            MessageLookupByLibrary.simpleMessage("This code is invalid"),
        "newAccountTwoFactorInputCode":
            MessageLookupByLibrary.simpleMessage("Two Factor Code")
      };
}
