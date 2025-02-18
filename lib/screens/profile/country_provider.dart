import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/services/currency_service.dart';

class CountryProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  String? _countryCode;
  String? _countryName;
  String? _currencyCode;
  double? _exchangeRate;

  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get currencyCode => _currencyCode;
  double? get exchangeRate => _exchangeRate;

  // Future<void> initialize() async {
  //   _countryCode = await _storage.read(key: 'country_code');
  //   _countryName = await _storage.read(key: 'country_name');
  //   _currencyCode = await _storage.read(key: 'currency_code');
  //   String? rate = await _storage.read(key: 'exchange_rate');
  //   _exchangeRate = rate != null ? double.parse(rate) : null;
  //   notifyListeners();
  // }
  Future<void> initialize() async {
    _countryCode = await _storage.read(key: 'country_code');
    _countryName = await _storage.read(key: 'country_name');
    _currencyCode = await _storage.read(key: 'currency_code');
    String? rate = await _storage.read(key: 'exchange_rate');

    if (_countryCode != null && _currencyCode != null && rate == null) {
      // Refresh exchange rate if we have country data but no rate
      _exchangeRate = await CurrencyService.getExchangeRate(_currencyCode!);
      await _storage.write(
          key: 'exchange_rate', value: _exchangeRate.toString());
    } else {
      _exchangeRate = rate != null ? double.parse(rate) : null;
    }

    notifyListeners();
  }

  Future<void> setCountry(
      String code, String name, String currency, double rate) async {
    _countryCode = code;
    _countryName = name;
    _currencyCode = currency;
    _exchangeRate = rate;
    print(
        'Setting country: $code, currency: $currency, rate: $rate'); // Debug print

    await _storage.write(key: 'country_code', value: code);
    await _storage.write(key: 'country_name', value: name);
    await _storage.write(key: 'currency_code', value: currency);
    await _storage.write(key: 'exchange_rate', value: rate.toString());

    notifyListeners();
  }

  double convertPrice(double usdPrice) {
    if (_exchangeRate == null) return usdPrice;
    return usdPrice * _exchangeRate!;
  }

  String formatPrice(double price) {
    return '${_currencyCode ?? 'USD'} ${price.toStringAsFixed(2)}';
  }
}
