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

  /// `Rota não encontrada`
  String get RouteNotFound {
    return Intl.message(
      'Rota não encontrada',
      name: 'RouteNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao carregar a previsão do tempo`
  String get ForecastCouldNotLoad {
    return Intl.message(
      'Erro ao carregar a previsão do tempo',
      name: 'ForecastCouldNotLoad',
      desc: '',
      args: [],
    );
  }

  /// `Proximos dias`
  String get ForecastTitle {
    return Intl.message(
      'Proximos dias',
      name: 'ForecastTitle',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao carregar a temperatura`
  String get CurrentWeatherCouldNotLoad {
    return Intl.message(
      'Erro ao carregar a temperatura',
      name: 'CurrentWeatherCouldNotLoad',
      desc: '',
      args: [],
    );
  }

  /// `Temperatura Hoje`
  String get CurrentWeatherTitle {
    return Intl.message(
      'Temperatura Hoje',
      name: 'CurrentWeatherTitle',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao carregar os concertos`
  String get ConcertsCouldNotLoad {
    return Intl.message(
      'Erro ao carregar os concertos',
      name: 'ConcertsCouldNotLoad',
      desc: '',
      args: [],
    );
  }

  /// `Não foi encontrado nenhuma cidade com esse nome`
  String get ConcertNotFound {
    return Intl.message(
      'Não foi encontrado nenhuma cidade com esse nome',
      name: 'ConcertNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Digite o nome da cidade`
  String get ConcertsSearchHint {
    return Intl.message(
      'Digite o nome da cidade',
      name: 'ConcertsSearchHint',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
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
