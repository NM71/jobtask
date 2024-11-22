// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jobtask/startup_screen.dart';
//
// class SettingsScreen extends StatefulWidget {
//   final Map<String, dynamic>? userData;
//
//   const SettingsScreen({super.key, this.userData});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   final storage = const FlutterSecureStorage();
//
//   Future<void> _logout() async {
//     await storage.delete(key: 'auth_token');
//     if (mounted) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const StartupScreen()),
//             (route) => false,
//       );
//     }
//   }
//
//   Future<void> _showLogoutDialog() async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Logout'),
//           content: const Text('Are you sure you want to logout?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(color: Colors.red),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _logout();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildSettingsItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     VoidCallback? onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xff3c76ad)),
//       title: Text(title),
//       subtitle: Text(
//         subtitle,
//         style: const TextStyle(color: Colors.grey),
//       ),
//       onTap: onTap,
//     );
//   }
//
//   Widget _buildSectionDivider() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.0),
//       child: Divider(height: 1),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: Color(0xff3c76ad),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Settings'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           // Personal Information Section
//           _buildSectionHeader('Personal Information'),
//           _buildSettingsItem(
//             icon: Icons.person,
//             title: 'Username',
//             subtitle: widget.userData?['nicename'] ?? 'N/A',
//           ),
//           _buildSettingsItem(
//             icon: Icons.location_on,
//             title: 'Address',
//             subtitle: widget.userData?['address'] ?? 'Not set',
//           ),
//           _buildSettingsItem(
//             icon: Icons.straighten,
//             title: 'Shoe Size',
//             subtitle: widget.userData?['shoe_size'] ?? 'Not set',
//           ),
//           _buildSettingsItem(
//             icon: Icons.description,
//             title: 'Bio',
//             subtitle: widget.userData?['bio'] ?? 'Not set',
//           ),
//           _buildSettingsItem(
//             icon: Icons.calendar_today,
//             title: 'Member since',
//             subtitle: widget.userData?['registered']?.split(' ')[0] ?? 'N/A',
//           ),
//           _buildSectionDivider(),
//
//           // Account Section
//           _buildSectionHeader('Account'),
//           _buildSettingsItem(
//             icon: Icons.email,
//             title: 'Email',
//             subtitle: widget.userData?['email'] ?? 'N/A',
//           ),
//           _buildSettingsItem(
//             icon: Icons.privacy_tip,
//             title: 'Privacy Settings',
//             subtitle: 'Manage your privacy preferences',
//             onTap: () {
//               // Navigate to privacy settings
//             },
//           ),
//           _buildSettingsItem(
//             icon: Icons.notifications,
//             title: 'Notifications',
//             subtitle: 'Manage your notifications',
//             onTap: () {
//               // Navigate to notifications settings
//             },
//           ),
//           _buildSectionDivider(),
//
//           // App Settings Section
//           _buildSectionHeader('App Settings'),
//           _buildSettingsItem(
//             icon: Icons.language,
//             title: 'Language',
//             subtitle: 'English',
//             onTap: () {
//               // Show language selection
//             },
//           ),
//           _buildSettingsItem(
//             icon: Icons.dark_mode,
//             title: 'Theme',
//             subtitle: 'Light',
//             onTap: () {
//               // Show theme selection
//             },
//           ),
//           _buildSectionDivider(),
//
//           // Help & Support Section
//           _buildSectionHeader('Help & Support'),
//           _buildSettingsItem(
//             icon: Icons.help_outline,
//             title: 'Help Center',
//             subtitle: 'Get help with your account',
//             onTap: () {
//               // Navigate to help center
//             },
//           ),
//           _buildSettingsItem(
//             icon: Icons.policy,
//             title: 'Terms & Policies',
//             subtitle: 'Read our terms and policies',
//             onTap: () {
//               // Navigate to terms and policies
//             },
//           ),
//           _buildSettingsItem(
//             icon: Icons.info_outline,
//             title: 'About',
//             subtitle: 'Learn more about our app',
//             onTap: () {
//               // Navigate to about page
//             },
//           ),
//           _buildSectionDivider(),
//
//           // Logout Section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: _showLogoutDialog,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.all(16),
//               ),
//               child: const Text('Logout'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jobtask/startup_screen.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class SettingsScreen extends StatefulWidget {
//   final Map<String, dynamic>? userData;
//
//   const SettingsScreen({super.key, this.userData});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   final storage = const FlutterSecureStorage();
//
//   // Future<void> _logout() async {
//   //   await storage.delete(key: 'auth_token');
//   //   if (mounted) {
//   //     Navigator.of(context).pushAndRemoveUntil(
//   //       MaterialPageRoute(builder: (context) => const StartupScreen()),
//   //           (route) => false,
//   //     );
//   //   }
//   // }
//
//   // logout function
//   Future<void> _logout() async {
//     // Show confirmation dialog
//     bool confirmLogout = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Logout'),
//           backgroundColor: const Color(0xffc2c2c2),
//           content: const Text('Are you sure you want to log out?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('Cancel',style: TextStyle(color: Colors.black,fontSize: 16),),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('Logout', style: TextStyle(color: Color(0xff3c76ad),fontSize: 16),),
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//
//     if (confirmLogout) {
//       // Proceed with logout
//       await storage.delete(key: 'auth_token');
//       if (mounted) {
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const StartupScreen()),
//               (route) => false,
//         );
//       }
//     }
//   }
//
//
//   Widget _buildSettingsItem({
//     required String title,
//     String? subtitle,
//     VoidCallback? onTap,
//     bool showDivider = true,
//     bool isLogout = false,
//     bool isDetails = false,
//   }) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(
//             title,
//             style: TextStyle(
//               color: isLogout ? Colors.red : Colors.black,
//               fontSize: 16,
//             ),
//           ),
//           subtitle: subtitle != null ? Text(subtitle) : null,
//           trailing: isDetails? null : const Icon(
//             Icons.chevron_right,
//             color: Colors.grey,
//           ),
//           onTap: onTap,
//         ),
//         if (showDivider)
//           const Divider(
//             height: 1,
//             indent: 16,
//             endIndent: 16,
//           ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Settings'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           _buildSettingsItem(
//             isDetails: true,
//             title: 'Email',
//             subtitle: widget.userData?['email'] ?? 'Lorem@mail.com',
//           ),
//           _buildSettingsItem(
//             isDetails: true,
//             title: 'Date of Birth',
//             subtitle: '12/2/95',
//           ),
//           _buildSettingsItem(
//             title: 'Delivery Information',
//             onTap: () {
//               // Navigate to delivery information
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Payment Information',
//             onTap: () {
//               // Navigate to payment information
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Country / Region',
//             onTap: () {
//               // Navigate to country selection
//             },
//           ),_buildSettingsItem(
//             title: 'Refund Order Policy',
//             onTap: () async {
//               // Navigate to language selection
//               const url =
//                   'https://rfkicks.com/refund-order-policy/';
//               if (await canLaunch(
//               url)) {
//               await launch(url);
//               } else {
//               throw 'Could not launch $url';
//               }
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Language',
//             onTap: () {
//               // Navigate to language selection
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Shopping Settings',
//             onTap: () {
//               // Navigate to shopping settings
//             },
//           ),
//           // _buildSettingsItem(
//           //   title: 'Location Settings',
//           //   onTap: () {
//           //     // Navigate to location settings
//           //   },
//           // ),
//           // _buildSettingsItem(
//           //   title: 'Notification Preferences',
//           //   onTap: () {
//           //     // Navigate to notification settings
//           //   },
//           // ),
//           // _buildSettingsItem(
//           //   title: 'Privacy',
//           //   onTap: () {
//           //     // Navigate to privacy settings
//           //   },
//           // ),
//           // _buildSettingsItem(
//           //   title: 'Get Support',
//           //   onTap: () {
//           //     // Navigate to support
//           //   },
//           // ),
//           _buildSettingsItem(
//             title: 'Explore Our Website',
//             onTap: () async {
//               // Navigate to website
//               const url =
//                   'https://rfkicks.com/';
//               if (await canLaunch(
//               url)) {
//               await launch(url);
//               } else {
//               throw 'Could not launch $url';
//               }
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Terms of Use',
//             onTap: () async {
//               // Navigate to terms
//               const url =
//                   'https://rfkicks.com/terms-conditions/';
//               if (await canLaunch(
//               url)) {
//               await launch(url);
//               } else {
//               throw 'Could not launch $url';
//               }
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Privacy Policy',
//             onTap: () {
//               // Navigate to privacy policy
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Delete Account',
//             onTap: () {
//               // Show delete account confirmation
//             },
//           ),
//           _buildSettingsItem(
//             title: 'Log Out',
//             isLogout: true,
//             showDivider: false,
//             onTap: _logout,
//           ),
//         ],
//       ),
//     );
//   }
// }


// -----------------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/screens/about/FAQS.dart';
import 'package:jobtask/screens/about/order_refund_policy.dart';
import 'package:jobtask/screens/about/privacy_policy_screen.dart';
import 'package:jobtask/startup_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const SettingsScreen({super.key, this.userData});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storage = const FlutterSecureStorage();

  Future<void> _logout() async {
    bool confirmLogout = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Logout'),
              backgroundColor: const Color(0xccf2f2f2),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Logout',
                      style: TextStyle(color: Color(0xff3c76ad), fontSize: 16)),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmLogout) {
      await storage.delete(key: 'auth_token');
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const StartupScreen()),
          (route) => false,
        );
      }
    }
  }

  Widget _buildSettingsItem({
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool showDivider = true,
    bool isLogout = false,
    bool isDetails = false,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.5 *
                  MediaQuery.textScalerOf(context).scale(1)
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: isDetails
              ? null
              : const Icon(Icons.chevron_right, color: Colors.black),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            color: Color(0xffE4E4E4),
            // indent: 16,
            // endIndent: 16,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        // padding: EdgeInsets.symmetric(
        //     vertical: 10, horizontal: 16), // Responsive padding
        children: [
          _buildSettingsItem(
            isDetails: true,
            title: 'Email',
            subtitle: widget.userData?['email'] ?? 'Lorem@mail.com',
          ),
          _buildSettingsItem(
            isDetails: true,
            title: 'Date of Birth',
            // subtitle: widget.userData?['date_of_birth'] ?? '12/2/95',
            subtitle: '${widget.userData?['date_of_birth']?.split(' ')[0] ?? 'N/A'}'
          ),
          _buildSettingsItem(
            title: 'Delivery Information',
            onTap: () {
              // Navigate to delivery information
            },
          ),
          _buildSettingsItem(
            title: 'Payment Information',
            onTap: () {
              // Navigate to payment information
            },
          ),
          _buildSettingsItem(
            title: 'Country / Region',
            onTap: () {
              // Navigate to country selection
            },
          ),
          _buildSettingsItem(
            title: 'Refund Order Policy',
            onTap: ()  {
              Navigator.push(
                  context,
                  PageTransition(
                      child: OrderRefundPolicy(),
                      type: PageTransitionType.rightToLeft));
            },
          ),
          _buildSettingsItem(
            title: 'Language',
            onTap: () {
              // Navigate to language selection
            },
          ),
          _buildSettingsItem(
            title: 'FAQ\'S ',
            onTap: () {
              // Navigate to Frequently Asked Questions
              Navigator.push(context, PageTransition(child: FAQS(), type: PageTransitionType.rightToLeft));
            },
          ),
          _buildSettingsItem(
            title: 'Explore Our Website ',
            onTap: () async {
              Uri url = Uri.parse('https://rfkicks.com/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          _buildSettingsItem(
            title: 'Terms of Use ',
            onTap: () async {
              Uri url = Uri.parse('https://rfkicks.com/terms-conditions/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          _buildSettingsItem(
            title: 'Privacy Policy ',
            onTap: () {
              // Navigate to privacy policy
              Navigator.push(
                  context,
                  PageTransition(
                      child: PrivacyPolicyScreen(),
                      type: PageTransitionType.rightToLeft));
            },
          ),
          _buildSettingsItem(
            title: 'Delete Account',
            onTap: () {
              // Show delete account confirmation
            },
          ),
          _buildSettingsItem(
            title: 'Log Out ',
            isLogout: true,
            showDivider: false,
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
