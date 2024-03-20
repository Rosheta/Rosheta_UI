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
