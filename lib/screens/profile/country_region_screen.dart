// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:country_picker/country_picker.dart';

// class CountryRegionScreen extends StatefulWidget {
//   @override
//   _CountryRegionScreenState createState() => _CountryRegionScreenState();
// }

// class _CountryRegionScreenState extends State<CountryRegionScreen> {
//   String? selectedCountryCode;
//   String? selectedCountryName;
//   final storage = const FlutterSecureStorage();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedCountry();
//   }

//   Future<void> _loadSelectedCountry() async {
//     final code = await storage.read(key: 'country_code');
//     final name = await storage.read(key: 'country_name');
//     if (mounted) {
//       setState(() {
//         selectedCountryCode = code;
//         selectedCountryName = name;
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _saveCountry(String code, String name) async {
//     await storage.write(key: 'country_code', value: code);
//     await storage.write(key: 'country_name', value: name);
//     setState(() {
//       selectedCountryCode = code;
//       selectedCountryName = name;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: Colors.white,
//         title: Text('Country / Region'),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator(color: Color(0xff3c76ad)))
//           : Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Card(
//                     elevation: 2,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       side:
//                           BorderSide(color: Color(0xff3c76ad).withOpacity(0.2)),
//                     ),
//                     child: ListTile(
//                       title: Text(
//                         selectedCountryName ?? 'Select Country',
//                         style: TextStyle(
//                           color: selectedCountryName != null
//                               ? Color(0xff3c76ad)
//                               : Color(0xffCA462A),
//                         ),
//                       ),
//                       subtitle: selectedCountryCode != null
//                           ? Text(
//                               'Country Code: $selectedCountryCode',
//                               style: TextStyle(color: Color(0xff3c76ad)),
//                             )
//                           : null,
//                       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                       iconColor: Color(0xff3c76ad),
//                       onTap: () {
//                         showCountryPicker(
//                           context: context,
//                           showPhoneCode: false,
//                           countryListTheme: CountryListThemeData(
//                             flagSize: 25,
//                             backgroundColor: Colors.white,
//                             textStyle: TextStyle(fontSize: 16),
//                             bottomSheetHeight: 500,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(12),
//                               topRight: Radius.circular(12),
//                             ),
//                             inputDecoration: InputDecoration(
//                               labelText: 'Search',
//                               prefixIcon: Icon(Icons.search),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide:
//                                     BorderSide(color: Color(0xff3c76ad)),
//                               ),
//                             ),
//                           ),
//                           onSelect: (Country country) {
//                             _saveCountry(country.countryCode, country.name);
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Your selected country/region will be used throughout the app for a better experience.',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:jobtask/screens/profile/country_provider.dart';
import 'package:jobtask/services/currency_service.dart';
import 'package:jobtask/utils/currency_mapping.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';

class CountryRegionScreen extends StatefulWidget {
  @override
  _CountryRegionScreenState createState() => _CountryRegionScreenState();
}

class _CountryRegionScreenState extends State<CountryRegionScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeCountry();
  }

  Future<void> _initializeCountry() async {
    await Provider.of<CountryProvider>(context, listen: false).initialize();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text('Country / Region'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xff3c76ad)))
          : Consumer<CountryProvider>(
              builder: (context, countryProvider, child) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(
                              color: Color(0xff3c76ad).withOpacity(0.2)),
                        ),
                        child: ListTile(
                          title: Text(
                            countryProvider.countryName ?? 'Select Country',
                            style: TextStyle(
                              color: countryProvider.countryName != null
                                  ? Color(0xff3c76ad)
                                  : Color(0xffCA462A),
                            ),
                          ),
                          subtitle: countryProvider.countryCode != null
                              ? Text(
                                  'Currency: ${countryProvider.currencyCode}',
                                  style: TextStyle(color: Color(0xff3c76ad)),
                                )
                              : null,
                          trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          iconColor: Color(0xff3c76ad),
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              countryListTheme: CountryListThemeData(
                                flagSize: 25,
                                backgroundColor: Colors.white,
                                textStyle: TextStyle(fontSize: 16),
                                bottomSheetHeight: 500,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(0xff3c76ad)),
                                  ),
                                ),
                              ),
                              onSelect: (Country country) async {
                                String currencyCode =
                                    CurrencyMapping.getCurrencyCode(
                                        country.countryCode);
                                double rate =
                                    await _fetchExchangeRate(currencyCode);
                                countryProvider.setCountry(
                                  country.countryCode,
                                  country.name,
                                  currencyCode,
                                  rate,
                                );
                              },
                              // onSelect: (Country country) async {
                              //   // Here we'll need to fetch exchange rate
                              //   double rate = await _fetchExchangeRate(
                              //       country.countryCode);
                              //   countryProvider.setCountry(
                              //     country.countryCode,
                              //     country.name,
                              //     country.currencyCode,
                              //     rate,
                              //   );
                              // },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your selected country/region will be used throughout the app for a better experience.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<double> _fetchExchangeRate(String currencyCode) async {
    return await CurrencyService.getExchangeRate(currencyCode);
  }

  // Future<double> _fetchExchangeRate(String countryCode) async {
  //   // TODO: Implement exchange rate fetching
  //   // For now returning a dummy value
  //   return 1.0;
  // }
}
