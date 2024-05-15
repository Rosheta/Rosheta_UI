// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `ROSHETA`
  String get title {
    return Intl.message(
      'ROSHETA',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get LOGIN {
    return Intl.message(
      'LOGIN',
      name: 'LOGIN',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Don''t have account? `
  String get nothavingaccount {
    return Intl.message(
      'Don\'\'t have account? ',
      name: 'nothavingaccount',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup {
    return Intl.message(
      'Signup',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `SIGNUP`
  String get SIGNUP {
    return Intl.message(
      'SIGNUP',
      name: 'SIGNUP',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get name {
    return Intl.message(
      'Full Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get NationalId {
    return Intl.message(
      'National ID',
      name: 'NationalId',
      desc: '',
      args: [],
    );
  }

  /// `Phonenumber`
  String get Phone {
    return Intl.message(
      'Phonenumber',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `Select Birth Date`
  String get birthDate {
    return Intl.message(
      'Select Birth Date',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Have an accout?`
  String get havingaccount {
    return Intl.message(
      'Have an accout?',
      name: 'havingaccount',
      desc: '',
      args: [],
    );
  }

  /// `Login Now`
  String get LoginNow {
    return Intl.message(
      'Login Now',
      name: 'LoginNow',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get UserbirthDate {
    return Intl.message(
      'Birth Date',
      name: 'UserbirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get Doctor {
    return Intl.message(
      'Doctor',
      name: 'Doctor',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get Patient {
    return Intl.message(
      'Patient',
      name: 'Patient',
      desc: '',
      args: [],
    );
  }

  /// `Lab`
  String get Lab {
    return Intl.message(
      'Lab',
      name: 'Lab',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Edit basic information`
  String get editInfor {
    return Intl.message(
      'Edit basic information',
      name: 'editInfor',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get hintTextname {
    return Intl.message(
      'Enter your name',
      name: 'hintTextname',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get hintTextemail {
    return Intl.message(
      'Enter your email',
      name: 'hintTextemail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get hintTextphonenumber {
    return Intl.message(
      'Enter your phone number',
      name: 'hintTextphonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your National ID`
  String get hintTextID {
    return Intl.message(
      'Enter your National ID',
      name: 'hintTextID',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Date of Birth`
  String get hintTextdate {
    return Intl.message(
      'Enter your Date of Birth',
      name: 'hintTextdate',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get savechanges {
    return Intl.message(
      'Save changes',
      name: 'savechanges',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chat {
    return Intl.message(
      'Chats',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `type your message here ...`
  String get hinttextmsg {
    return Intl.message(
      'type your message here ...',
      name: 'hinttextmsg',
      desc: '',
      args: [],
    );
  }

  /// `gender`
  String get gender {
    return Intl.message(
      'gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `government`
  String get government {
    return Intl.message(
      'government',
      name: 'government',
      desc: '',
      args: [],
    );
  }

  /// `department`
  String get department {
    return Intl.message(
      'department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get location {
    return Intl.message(
      'location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `clinicLocation`
  String get clinicLocation {
    return Intl.message(
      'clinicLocation',
      name: 'clinicLocation',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Response code`
  String get QrCode {
    return Intl.message(
      'Response code',
      name: 'QrCode',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get Appointment {
    return Intl.message(
      'Appointment',
      name: 'Appointment',
      desc: '',
      args: [],
    );
  }

  /// `Chronic Diseases`
  String get Chronic {
    return Intl.message(
      'Chronic Diseases',
      name: 'Chronic',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get Attachments {
    return Intl.message(
      'Attachments',
      name: 'Attachments',
      desc: '',
      args: [],
    );
  }

  /// `Langauege`
  String get langauege {
    return Intl.message(
      'Langauege',
      name: 'langauege',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get Logout {
    return Intl.message(
      'Log out',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Emergency`
  String get Emergency {
    return Intl.message(
      'Emergency',
      name: 'Emergency',
      desc: '',
      args: [],
    );
  }

  /// `New Examination`
  String get examination {
    return Intl.message(
      'New Examination',
      name: 'examination',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get uploadAttachment {
    return Intl.message(
      'Upload File',
      name: 'uploadAttachment',
      desc: '',
      args: [],
    );
  }

  /// `male`
  String get male {
    return Intl.message(
      'male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `female`
  String get female {
    return Intl.message(
      'female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `National ID must conatain 14 numbers`
  String get enterYourNationalId {
    return Intl.message(
      'National ID must conatain 14 numbers',
      name: 'enterYourNationalId',
      desc: '',
      args: [],
    );
  }

  /// `Email must contain @`
  String get enterValidEmail {
    return Intl.message(
      'Email must contain @',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must contain 11 numbers`
  String get enterValidPhone {
    return Intl.message(
      'Phone number must contain 11 numbers',
      name: 'enterValidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get uploadFile {
    return Intl.message(
      'Upload File',
      name: 'uploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Clinic Position`
  String get clinicPosition {
    return Intl.message(
      'Clinic Position',
      name: 'clinicPosition',
      desc: '',
      args: [],
    );
  }

  /// `Enter your clinic address`
  String get enterclinicPosition {
    return Intl.message(
      'Enter your clinic address',
      name: 'enterclinicPosition',
      desc: '',
      args: [],
    );
  }

  /// `Enter your address`
  String get positionController {
    return Intl.message(
      'Enter your address',
      name: 'positionController',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get assignDate {
    return Intl.message(
      'Date',
      name: 'assignDate',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get Notes {
    return Intl.message(
      'Notes',
      name: 'Notes',
      desc: '',
      args: [],
    );
  }

  /// `Please enter username for patient`
  String get username {
    return Intl.message(
      'Please enter username for patient',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get SUBMIT {
    return Intl.message(
      'Submit',
      name: 'SUBMIT',
      desc: '',
      args: [],
    );
  }

  /// `Doctor name`
  String get doctorName {
    return Intl.message(
      'Doctor name',
      name: 'doctorName',
      desc: '',
      args: [],
    );
  }

  /// `prescription`
  String get prescription {
    return Intl.message(
      'prescription',
      name: 'prescription',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save and leave?`
  String get saveAndLeaveQ {
    return Intl.message(
      'Do you want to save and leave?',
      name: 'saveAndLeaveQ',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Prescription`
  String get Prescription {
    return Intl.message(
      'Prescription',
      name: 'Prescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Chronic Disease`
  String get AddChronicDisease {
    return Intl.message(
      'Add Chronic Disease',
      name: 'AddChronicDisease',
      desc: '',
      args: [],
    );
  }

  /// `Chronic Disease`
  String get ChronicDis {
    return Intl.message(
      'Chronic Disease',
      name: 'ChronicDis',
      desc: '',
      args: [],
    );
  }

  /// `Please enter patient national ID `
  String get userID {
    return Intl.message(
      'Please enter patient national ID ',
      name: 'userID',
      desc: '',
      args: [],
    );
  }

  /// `Enter patient national ID`
  String get enterPatientID {
    return Intl.message(
      'Enter patient national ID',
      name: 'enterPatientID',
      desc: '',
      args: [],
    );
  }

  /// `examination`
  String get examination2 {
    return Intl.message(
      'examination',
      name: 'examination2',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis`
  String get Diagnosis {
    return Intl.message(
      'Diagnosis',
      name: 'Diagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Current Appointment`
  String get CurrentAppointment {
    return Intl.message(
      'Current Appointment',
      name: 'CurrentAppointment',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
