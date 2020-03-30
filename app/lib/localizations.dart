import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jinya_app/l10n/messages_all.dart';

class JinyaLocalizations {
  JinyaLocalizations(this.localeName);

  static Future<JinyaLocalizations> load(Locale locale) {
    final String name = locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return JinyaLocalizations(localeName);
    });
  }

  static JinyaLocalizations of(BuildContext context) {
    return Localizations.of<JinyaLocalizations>(context, JinyaLocalizations);
  }

  final String localeName;

  String get appName {
    return Intl.message(
      'Jinya CMS',
      name: 'appName',
      locale: localeName,
    );
  }

  String get actionUndo {
    return Intl.message(
      'UNDO',
      name: 'actionUndo',
      locale: localeName,
    );
  }

  String get menuMedia {
    return Intl.message(
      'Media',
      name: 'menuMedia',
      locale: localeName,
    );
  }

  String get menuPages {
    return Intl.message(
      'Pages',
      name: 'menuPages',
      locale: localeName,
    );
  }

  String get menuForms {
    return Intl.message(
      'Forms',
      name: 'menuForms',
      locale: localeName,
    );
  }

  String get menuArtists {
    return Intl.message(
      'Artists',
      name: 'menuArtists',
      locale: localeName,
    );
  }

  String get menuThemes {
    return Intl.message(
      'Themes',
      name: 'menuThemes',
      locale: localeName,
    );
  }

  String get menuMenus {
    return Intl.message(
      'Menus',
      name: 'menuMenus',
      locale: localeName,
    );
  }

  String get menuAddAccount {
    return Intl.message(
      'Add Account',
      name: 'menuAddAccount',
      locale: localeName,
    );
  }

  String get menuManageAccounts {
    return Intl.message(
      'Manage Accounts',
      name: 'menuManageAccounts',
      locale: localeName,
    );
  }

  String menuSwitchAccount(name) {
    return Intl.message(
      "Switch to $name",
      locale: localeName,
      name: 'menuSwitchAccount',
      args: [name],
    );
  }

  String get newAccountTitle {
    return Intl.message(
      'Add Jinya Account',
      name: 'newAccountTitle',
      locale: localeName,
    );
  }

  String get newAccountInputJinyaHost {
    return Intl.message(
      'Jinya Host',
      name: 'newAccountInputJinyaHost',
      locale: localeName,
    );
  }

  String get newAccountInputEmail {
    return Intl.message(
      'Email address',
      name: 'newAccountInputEmail',
      locale: localeName,
    );
  }

  String get newAccountInputPassword {
    return Intl.message(
      'Password',
      name: 'newAccountInputPassword',
      locale: localeName,
    );
  }

  String get newAccountActionTwoFactorCode {
    return Intl.message(
      'REQUEST TWO FACTOR CODE',
      name: 'newAccountActionTwoFactorCode',
      locale: localeName,
    );
  }

  String get newAccountErrorExists {
    return Intl.message(
      'An account with the email address already exists',
      name: 'newAccountErrorExists',
      locale: localeName,
    );
  }

  String get newAccountErrorInvalidCredentials {
    return Intl.message(
      'The credentials you provided are invalid',
      name: 'newAccountErrorInvalidCredentials',
      locale: localeName,
    );
  }

  String get newAccountErrorInvalidUrl {
    return Intl.message(
      'This is not a valid Jinya Host Url',
      name: 'newAccountErrorInvalidUrl',
      locale: localeName,
    );
  }

  String get newAccountErrorInvalidEmail {
    return Intl.message(
      'This is not a valid email address',
      name: 'newAccountErrorInvalidEmail',
      locale: localeName,
    );
  }

  String get newAccountErrorInvalidPassword {
    return Intl.message(
      'You need to input a password',
      name: 'newAccountErrorInvalidPassword',
      locale: localeName,
    );
  }

  String get newAccountTwoFactorErrorInvalidCode {
    return Intl.message(
      'This code is invalid',
      name: 'newAccountTwoFactorErrorInvalidCode',
      locale: localeName,
    );
  }

  String get newAccountTwoFactorActionLogin {
    return Intl.message(
      'ADD ACCOUNT',
      name: 'newAccountTwoFactorActionLogin',
      locale: localeName,
    );
  }

  String get newAccountTwoFactorInputCode {
    return Intl.message(
      'Two Factor Code',
      name: 'newAccountTwoFactorInputCode',
      locale: localeName,
    );
  }

  String get manageAccountsTitle {
    return Intl.message(
      'Manage Accounts',
      name: 'manageAccountsTitle',
      locale: localeName,
    );
  }

  String manageAccountsDeleteSuccess(name) {
    return Intl.message(
      'Successfully deleted $name',
      name: 'manageAccountsDeleteSuccess',
      locale: localeName,
      args: [name],
    );
  }

  String get manageMediaTitle {
    return Intl.message(
      'Media management',
      name: 'manageMediaTitle',
      locale: localeName,
    );
  }

  String get manageMediaFiles {
    return Intl.message(
      'Files',
      name: 'manageMediaFiles',
      locale: localeName,
    );
  }

  String get newFileTitle {
    return Intl.message(
      'New File',
      name: 'newFileTitle',
      locale: localeName,
    );
  }

  String get newFileNameEmpty {
    return Intl.message(
      'Please provide a name',
      name: 'newFileNameEmpty',
      locale: localeName,
    );
  }

  String get newFileName {
    return Intl.message(
      'Name',
      name: 'newFileName',
      locale: localeName,
    );
  }

  String get newFileActionCreate {
    return Intl.message(
      'Create file',
      name: 'newFileActionCreate',
      locale: localeName,
    );
  }

  String get newFileActionPickFile {
    return Intl.message(
      'Select file',
      name: 'newFileActionPickFile',
      locale: localeName,
    );
  }

  String get newFileNotEnoughPermissionsError {
    return Intl.message(
      'You don\'t have enough permissions',
      name: 'newFileNotEnoughPermissionsError',
      locale: localeName,
    );
  }

  String get newFileExistsError {
    return Intl.message(
      'A file with that name already exists',
      name: 'newFileExistsError',
      locale: localeName,
    );
  }

  String get loginInvalidCredentials {
    return Intl.message(
      'Invalid credentials',
      name: 'loginInvalidCredentials',
      locale: localeName,
    );
  }

  String get loginTitle {
    return Intl.message(
      'Login',
      name: 'loginTitle',
      locale: localeName,
    );
  }

  String get loginInstance {
    return Intl.message(
      'Jinya Server',
      name: 'loginInstance',
      locale: localeName,
    );
  }

  String get loginEmail {
    return Intl.message(
      'Email address',
      name: 'loginEmail',
      locale: localeName,
    );
  }

  String get loginPassword {
    return Intl.message(
      'Password',
      name: 'loginPassword',
      locale: localeName,
    );
  }

  String get loginActionLogin {
    return Intl.message(
      'Login',
      name: 'loginActionLogin',
      locale: localeName,
    );
  }
}

class JinyaLocalizationsDelegate
    extends LocalizationsDelegate<JinyaLocalizations> {
  const JinyaLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['de', 'en'].contains(locale.languageCode);

  @override
  Future<JinyaLocalizations> load(Locale locale) =>
      JinyaLocalizations.load(locale);

  @override
  bool shouldReload(JinyaLocalizationsDelegate old) => false;
}
