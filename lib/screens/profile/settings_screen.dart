import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/screens/about/FAQS.dart';
import 'package:jobtask/screens/about/order_refund_policy.dart';
import 'package:jobtask/screens/about/privacy_policy_screen.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/payment/saved_cards_screen.dart';
import 'package:jobtask/screens/profile/payment_information_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/startup_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const SettingsScreen({super.key, this.userData});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storage = const FlutterSecureStorage();

  // logout function
  Future<void> _logout() async {
    bool confirmLogout = await showAdaptiveDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              title: const Text('Confirm Logout'),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3c76ad),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text('Logout'),
                ),
                // TextButton(
                //   onPressed: () => Navigator.of(context).pop(true),
                //   child: const Text('Logout',
                //       style: TextStyle(color: Color(0xff3c76ad), fontSize: 17)),
                // ),
              ],
            );
          },
        ) ??
        false;

    if (confirmLogout) {
      // Clear cart data before logout
      Provider.of<CartProvider>(context, listen: false).clearUserCart();
      Provider.of<CartProvider>(context, listen: false).setUserId(null);
      await storage.delete(key: 'auth_token');
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const StartupScreen()),
          (route) => false,
        );
      }
    }
  }

  // delete account function
  Future<void> _deleteAccount() async {
    bool confirmDelete = await showAdaptiveDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              title: const Text('Delete Account'),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              content: const Text(
                  'Are you sure you want to delete your account? This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text('Delete'),
                ),
                // TextButton(
                //   onPressed: () => Navigator.of(context).pop(true),
                //   child: const Text('Delete',
                //       style: TextStyle(color: Colors.red, fontSize: 17)),
                // ),
              ],
            );
          },
        ) ??
        false;

    if (confirmDelete) {
      try {
        // Get the auth token from secure storage
        final storage = const FlutterSecureStorage();
        final token = await storage.read(key: 'auth_token');

        if (token == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentication token not found')),
          );
          return;
        }

        // Call API to delete account
        final success = await ApiService.deleteAccount(token);

        if (success) {
          // Clear the auth token
          await storage.delete(key: 'auth_token');

          // Navigate to startup screen
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const StartupScreen()),
              (route) => false,
            );

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account deleted successfully')),
            );
          }
        } else {
          // Show error message if deletion failed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete account')),
          );
        }
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
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
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              title,
              style: TextStyle(
                  color: isLogout ? Colors.red : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.5 * MediaQuery.textScalerOf(context).scale(1)),
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email', style: TextStyle(fontSize: 13.5)),
                Text(
                  widget.userData?['email'] ?? 'Lorem@mail.com',
                  style: TextStyle(color: Color(0xffff821d)),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color(0xffE4E4E4),
            // indent: 16,
            // endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date of Birth', style: TextStyle(fontSize: 13.5)),
                Text(
                  '${widget.userData?['date_of_birth']?.split(' ')[0] ?? 'N/A'}',
                  style: TextStyle(color: Color(0xffff821d)),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color(0xffE4E4E4),
            // indent: 16,
            // endIndent: 16,
          ),
          // _buildSettingsItem(
          //   isDetails: true,
          //   title: 'Date of Birth',
          //   subtitle: widget.userData?['email'] ?? 'Lorem@mail.com',
          // ),
          // _buildSettingsItem(
          //     isDetails: true,
          //     title: 'Date of Birth',
          //     // subtitle: widget.userData?['date_of_birth'] ?? '12/2/95',
          //     subtitle:
          //         '${widget.userData?['date_of_birth']?.split(' ')[0] ?? 'N/A'}'),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentInformationScreen()),
              );
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
            onTap: () {
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
              Navigator.push(
                  context,
                  PageTransition(
                      child: FAQS(), type: PageTransitionType.rightToLeft));
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
            onTap: _deleteAccount,
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
