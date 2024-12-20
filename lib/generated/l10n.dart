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

  /// `Home page`
  String get title {
    return Intl.message(
      'Home page',
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

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Error message`
  String get error_message {
    return Intl.message(
      'Error message',
      name: 'error_message',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `about`
  String get about {
    return Intl.message(
      'about',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Ayah`
  String get ayah {
    return Intl.message(
      'Ayah',
      name: 'ayah',
      desc: '',
      args: [],
    );
  }

  /// `Surah`
  String get surah {
    return Intl.message(
      'Surah',
      name: 'surah',
      desc: '',
      args: [],
    );
  }

  /// `Surah List`
  String get Fuhras {
    return Intl.message(
      'Surah List',
      name: 'Fuhras',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get Number {
    return Intl.message(
      'Number',
      name: 'Number',
      desc: '',
      args: [],
    );
  }

  /// `Medinan`
  String get Medinan {
    return Intl.message(
      'Medinan',
      name: 'Medinan',
      desc: '',
      args: [],
    );
  }

  /// `Meccan`
  String get Meccan {
    return Intl.message(
      'Meccan',
      name: 'Meccan',
      desc: '',
      args: [],
    );
  }

  /// `Parts`
  String get parts {
    return Intl.message(
      'Parts',
      name: 'parts',
      desc: '',
      args: [],
    );
  }

  /// `Page`
  String get page {
    return Intl.message(
      'Page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'The view of the Quran' key

  // skipped getter for the 'Horizontal Qur\'an\'' key

  // skipped getter for the 'Vertical Qur\'an\'' key

  /// `Quran`
  String get Quran {
    return Intl.message(
      'Quran',
      name: 'Quran',
      desc: '',
      args: [],
    );
  }

  /// `Index`
  String get Index {
    return Intl.message(
      'Index',
      name: 'Index',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark removed!`
  String get Bookmark_removed {
    return Intl.message(
      'Bookmark removed!',
      name: 'Bookmark_removed',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark added!`
  String get Bookmark_added {
    return Intl.message(
      'Bookmark added!',
      name: 'Bookmark_added',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark`
  String get Bookmark {
    return Intl.message(
      'Bookmark',
      name: 'Bookmark',
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
