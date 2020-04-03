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
      'Undo',
      name: 'actionUndo',
      locale: localeName,
    );
  }

  String get actionEdit {
    return Intl.message(
      'Edit',
      name: 'actionEdit',
      locale: localeName,
    );
  }

  String get actionDelete {
    return Intl.message(
      'Delete',
      name: 'actionDelete',
      locale: localeName,
    );
  }

  String get actionDontDelete {
    return Intl.message(
      "Don't delete",
      name: 'actionDontDelete',
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

  String get manageMediaGalleries {
    return Intl.message(
      'Galleries',
      name: 'manageMediaGalleries',
      locale: localeName,
    );
  }

  String get manageMediaFilesDeleteTitle {
    return Intl.message(
      'Really delete file?',
      name: 'manageMediaFilesDeleteTitle',
      locale: localeName,
    );
  }

  String manageMediaFilesDeleteContent(name) {
    return Intl.message(
      'Do you want to delete the file $name? It will be removed from all galleries.',
      name: 'manageMediaFilesDeleteContent',
      locale: localeName,
      args: [name],
    );
  }

  String manageMediaFilesDeleteSuccess(name) {
    return Intl.message(
      'Successfully deleted $name',
      name: 'manageMediaFilesDeleteSuccess',
      locale: localeName,
      args: [name],
    );
  }

  String manageMediaFilesDeleteConflict(name) {
    return Intl.message(
      '$name cannot be deleted, cause it is in use.',
      name: 'manageMediaFilesDeleteConflict',
      locale: localeName,
      args: [name],
    );
  }

  String manageMediaFilesDeleteUnknown(name) {
    return Intl.message(
      'Failed to delete $name',
      name: 'manageMediaFilesDeleteUnknown',
      locale: localeName,
      args: [name],
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

  String get editFileNameEmpty {
    return Intl.message(
      'Please provide a name',
      name: 'editFileNameEmpty',
      locale: localeName,
    );
  }

  String get editFileName {
    return Intl.message(
      'Name',
      name: 'editFileName',
      locale: localeName,
    );
  }

  String get editFileActionUpdate {
    return Intl.message(
      'Update file',
      name: 'editFileActionUpdate',
      locale: localeName,
    );
  }

  String get editFileActionPickFile {
    return Intl.message(
      'Select new file',
      name: 'editFileActionPickFile',
      locale: localeName,
    );
  }

  String get editFileNotEnoughPermissionsError {
    return Intl.message(
      'You don\'t have enough permissions',
      name: 'editFileNotEnoughPermissionsError',
      locale: localeName,
    );
  }

  String get editFileExistsError {
    return Intl.message(
      'A file with that name already exists',
      name: 'editFileExistsError',
      locale: localeName,
    );
  }

  String get manageMediaGalleriesDeleteTitle {
    return Intl.message(
      'Really delete gallery?',
      name: 'manageMediaGalleriesDeleteTitle',
      locale: localeName,
    );
  }

  String manageMediaGalleriesDeleteContent(name) {
    return Intl.message(
      'Do you want to delete the gallery $name? It will be removed from all galleries.',
      name: 'manageMediaGalleriesDeleteContent',
      locale: localeName,
      args: [name],
    );
  }

  String manageMediaGalleriesDeleteSuccess(name) {
    return Intl.message(
      'Successfully deleted $name',
      name: 'manageMediaGalleriesDeleteSuccess',
      locale: localeName,
      args: [name],
    );
  }

  String manageMediaGalleriesDeleteConflict(name) {
    return Intl.message(
      '$name cannot be deleted, cause it is in use.',
      name: 'manageMediaGalleriesDeleteConflict',
      locale: localeName,
      args: [name],
    );
  }

  String manageMediaGalleriesDeleteUnknown(name) {
    return Intl.message(
      'Failed to delete $name',
      name: 'manageMediaGalleriesDeleteUnknown',
      locale: localeName,
      args: [name],
    );
  }

  String get newGalleryTitle {
    return Intl.message(
      'New Gallery',
      name: 'newGalleryTitle',
      locale: localeName,
    );
  }

  String get newGalleryNameEmpty {
    return Intl.message(
      'Please provide a name',
      name: 'newGalleryNameEmpty',
      locale: localeName,
    );
  }

  String get newGalleryName {
    return Intl.message(
      'Name',
      name: 'newGalleryName',
      locale: localeName,
    );
  }

  String get newGalleryDescription {
    return Intl.message(
      'Description',
      name: 'newGalleryDescription',
      locale: localeName,
    );
  }

  String get newGalleryOrientation {
    return Intl.message(
      'Orientation',
      name: 'newGalleryOrientation',
      locale: localeName,
    );
  }

  String get newGalleryType {
    return Intl.message(
      'Type',
      name: 'newGalleryType',
      locale: localeName,
    );
  }

  String get newGalleryActionCreate {
    return Intl.message(
      'Create gallery',
      name: 'newGalleryActionCreate',
      locale: localeName,
    );
  }

  String get newGalleryNotEnoughPermissionsError {
    return Intl.message(
      'You don\'t have enough permissions',
      name: 'newGalleryNotEnoughPermissionsError',
      locale: localeName,
    );
  }

  String get newGalleryExistsError {
    return Intl.message(
      'A gallery with that name already exists',
      name: 'newGalleryExistsError',
      locale: localeName,
    );
  }

  String get editGalleryNameEmpty {
    return Intl.message(
      'Please provide a name',
      name: 'editGalleryNameEmpty',
      locale: localeName,
    );
  }

  String get editGalleryName {
    return Intl.message(
      'Name',
      name: 'editGalleryName',
      locale: localeName,
    );
  }

  String get editGalleryDescription {
    return Intl.message(
      'Description',
      name: 'editGalleryDescription',
      locale: localeName,
    );
  }

  String get editGalleryOrientation {
    return Intl.message(
      'Orientation',
      name: 'editGalleryOrientation',
      locale: localeName,
    );
  }

  String get editGalleryType {
    return Intl.message(
      'Type',
      name: 'editGalleryType',
      locale: localeName,
    );
  }

  String get editGalleryActionUpdate {
    return Intl.message(
      'Update gallery',
      name: 'editGalleryActionUpdate',
      locale: localeName,
    );
  }

  String get editGalleryNotEnoughPermissionsError {
    return Intl.message(
      'You don\'t have enough permissions',
      name: 'editGalleryNotEnoughPermissionsError',
      locale: localeName,
    );
  }

  String get editGalleryExistsError {
    return Intl.message(
      'A gallery with that name already exists',
      name: 'editGalleryExistsError',
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

  String get newGalleryTypeMasonry {
    return Intl.message(
      'Masonry',
      name: 'newGalleryTypeMasonry',
      locale: localeName,
    );
  }

  String get newGalleryTypeSequence {
    return Intl.message(
      'Sequence',
      name: 'newGalleryTypeSequence',
      locale: localeName,
    );
  }

  String get newGalleryOrientationVertical {
    return Intl.message(
      'Vertical',
      name: 'newGalleryOrientationVertical',
      locale: localeName,
    );
  }

  String get newGalleryOrientationHorizontal {
    return Intl.message(
      'Horizontal',
      name: 'newGalleryOrientationHorizontal',
      locale: localeName,
    );
  }

  String get editGalleryTypeMasonry {
    return Intl.message(
      'Masonry',
      name: 'editGalleryTypeMasonry',
      locale: localeName,
    );
  }

  String get editGalleryTypeSequence {
    return Intl.message(
      'Sequence',
      name: 'editGalleryTypeSequence',
      locale: localeName,
    );
  }

  String get editGalleryOrientationVertical {
    return Intl.message(
      'Vertical',
      name: 'editGalleryOrientationVertical',
      locale: localeName,
    );
  }

  String get editGalleryOrientationHorizontal {
    return Intl.message(
      'Horizontal',
      name: 'editGalleryOrientationHorizontal',
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
