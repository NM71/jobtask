class CurrencyMapping {
  static Map<String, String> countryToCurrency = {
    'US': 'USD', // United States Dollar
    'GB': 'GBP', // British Pound Sterling
    'EU': 'EUR', // Euro
    'JP': 'JPY', // Japanese Yen
    'IN': 'INR', // Indian Rupee
    'AU': 'AUD', // Australian Dollar
    'CA': 'CAD', // Canadian Dollar
    'CH': 'CHF', // Swiss Franc
    'CN': 'CNY', // Chinese Yuan
    'NZ': 'NZD', // New Zealand Dollar
    'SE': 'SEK', // Swedish Krona
    'KR': 'KRW', // South Korean Won
    'SG': 'SGD', // Singapore Dollar
    'NO': 'NOK', // Norwegian Krone
    'MX': 'MXN', // Mexican Peso
    'HK': 'HKD', // Hong Kong Dollar
    'TR': 'TRY', // Turkish Lira
    'SA': 'SAR', // Saudi Riyal
    'AE': 'AED', // UAE Dirham
    'DK': 'DKK', // Danish Krone
    'PK': 'PKR', // Pakistani Rupee
    'IL': 'ILS', // Israeli Shekel
    'RU': 'RUB', // Russian Ruble
    'BR': 'BRL', // Brazilian Real
    'KW': 'KWD', // Kuwaiti Dinar
    'PH': 'PHP', // Philippine Peso
    'ID': 'IDR', // Indonesian Rupiah
    'TH': 'THB', // Thai Baht
    'MY': 'MYR', // Malaysian Ringgit
    'CL': 'CLP', // Chilean Peso
    'CO': 'COP', // Colombian Peso
    'ZA': 'ZAR', // South African Rand
    'EG': 'EGP', // Egyptian Pound
    'PL': 'PLN', // Polish Złoty
    'HU': 'HUF', // Hungarian Forint
    'CZ': 'CZK', // Czech Koruna
    'UA': 'UAH', // Ukrainian Hryvnia
  };
  // static Map<String, String> countryToCurrency = {
  //   'US': 'USD', // United States Dollar
  //   'GB': 'GBP', // British Pound Sterling
  //   'EU': 'EUR', // Euro
  //   'JP': 'JPY', // Japanese Yen
  //   'IN': 'INR', // Indian Rupee
  //   'AU': 'AUD', // Australian Dollar
  //   'CA': 'CAD', // Canadian Dollar
  //   'CH': 'CHF', // Swiss Franc
  //   'CN': 'CNY', // Chinese Yuan
  //   'NZ': 'NZD', // New Zealand Dollar
  //   'SE': 'SEK', // Swedish Krona
  //   'KR': 'KRW', // South Korean Won
  //   'SG': 'SGD', // Singapore Dollar
  //   'NO': 'NOK', // Norwegian Krone
  //   'MX': 'MXN', // Mexican Peso
  //   'HK': 'HKD', // Hong Kong Dollar
  //   'TR': 'TRY', // Turkish Lira
  //   'SA': 'SAR', // Saudi Riyal
  //   'AE': 'AED', // UAE Dirham
  //   'DK': 'DKK', // Danish Krone
  //   'PK': 'PKR', // Pakistani Rupee
  // };

  static String getCurrencyCode(String countryCode) {
    return countryToCurrency[countryCode] ??
        'USD'; // Default to USD if not found
  }
}
