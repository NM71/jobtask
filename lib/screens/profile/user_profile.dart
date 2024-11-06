// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jobtask/sample_check.dart';
// import 'package:jobtask/startup_screen.dart';
// import 'package:jobtask/utils/custom_buttons/icon_text_button.dart';
// import 'package:lottie/lottie.dart';
//
// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // profile picture
//           Padding(
//             padding: const EdgeInsets.only(top: 40.0, bottom: 15),
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xffd9d9d9),
//               ),
//               child: const Icon(
//                 Icons.camera_enhance,
//                 size: 40,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//
//           // user name
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Text(
//               'User Name',
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//
//           // edit profile button
//           OutlinedButton(
//               onPressed: () => _showEditProfileModal(context),
//               child: const Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Text(
//                   'Edit Profile',
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               )),
//
//           const SizedBox(
//             height: 35,
//           ),
//
//           // row -> order history & settings
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconTextButton(
//                     imagePath: 'assets/icons/order_history_icon.png',
//                     text: 'Order History',
//                     textColor: Colors.black,
//                     onPressed: () {},
//                     iconColor: const Color(0xffbababa)),
//                 const SizedBox(
//                   height: 40,
//                   child: VerticalDivider(
//                     thickness: 3,
//                   ),
//                 ),
//                 IconTextButton(
//                     imagePath: 'assets/icons/settings_icon.png',
//                     text: 'Settings',
//                     textColor: Colors.black,
//                     onPressed: () {},
//                     iconColor: const Color(0xffbababa)),
//               ],
//             ),
//           ),
//
//           // member since
//
//           SizedBox(
//             height: 50,
//           ),
//           // logout
//           ElevatedButton(
//             onPressed: () async {
//               final storage = FlutterSecureStorage();
//               await storage.delete(key: 'auth_token'); // Clear the stored token
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => StartupScreen()),
//                 (route) => false,
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xff3c76ad),
//               foregroundColor: Colors.white,
//               side: const BorderSide(color: Colors.white24),
//             ),
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Future _showEditProfileModal(BuildContext context) {
//   final TextEditingController bioController = TextEditingController();
//   const int maxCharacters = 150;
//
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return Container(
//         color: Colors.white,
//         height: MediaQuery.of(context).size.height * 0.95,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: const Text("Cancel",
//                         style: TextStyle(color: Colors.black, fontSize: 20))),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text("Save",
//                         style: TextStyle(color: Colors.grey, fontSize: 20))),
//               ],
//             ),
//
//             // Profile Picture
//             const CircleAvatar(
//               radius: 60,
//               backgroundImage: AssetImage('assets/images/profile-sample.jpeg'),
//             ),
//             const SizedBox(height: 20),
//
//             // Name Heading
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Name',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'First Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Last Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hometown',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Hometown',
//                     hintText: 'Town/City, Country/Region',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//
//             // Bio Section
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Bio',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     ValueListenableBuilder<TextEditingValue>(
//                       valueListenable: bioController,
//                       builder: (context, value, child) {
//                         return Text(
//                           '${value.text.length}/$maxCharacters',
//                           style: TextStyle(
//                             color: value.text.length >= maxCharacters
//                                 ? Colors.red
//                                 : Colors.black,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: bioController,
//                         maxLength:
//                             maxCharacters, // Limit the number of characters
//                         decoration: const InputDecoration(
//                           labelText: 'Max 150 Characters',
//                           border: OutlineInputBorder(),
//                           counterText: '', // Hide default counter
//                         ),
//                         maxLines: 3,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// -----------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jobtask/sample_check.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/startup_screen.dart';
// import 'package:jobtask/utils/custom_buttons/icon_text_button.dart';
// import 'package:lottie/lottie.dart';
//
// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   Map<String, dynamic>? userData;
//   bool isLoading = true;
//   String? error;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }
//
//   Future<void> _loadUserProfile() async {
//     try {
//       final storage = FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');
//
//       if (token == null) {
//         setState(() {
//           error = 'No authentication token found';
//           isLoading = false;
//         });
//         return;
//       }
//
//       final profile = await ApiService.getUserProfile(token);
//       setState(() {
//         userData = profile;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : error != null
//           ? Center(child: Text('Error: $error'))
//           : Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // profile picture
//           Padding(
//             padding: const EdgeInsets.only(top: 40.0, bottom: 15),
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xffd9d9d9),
//               ),
//               child: const Icon(
//                 Icons.camera_enhance,
//                 size: 40,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//
//           // user name
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Text(
//               userData?['display_name'] ?? 'No Name',
//               style: const TextStyle(fontSize: 25),
//             ),
//           ),
//
//           // user details
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Email: ${userData?['email'] ?? 'N/A'}'),
//                 const SizedBox(height: 10),
//                 Text('Username: ${userData?['nicename'] ?? 'N/A'}'),
//                 const SizedBox(height: 10),
//                 Text('Member since: ${userData?['registered']?.split(' ')[0] ?? 'N/A'}'),
//               ],
//             ),
//           ),
//
//           // edit profile button
//           OutlinedButton(
//             onPressed: () => _showEditProfileModal(context),
//             child: const Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Text(
//                 'Edit Profile',
//                 style: TextStyle(fontSize: 18, color: Colors.black),
//               ),
//             ),
//           ),
//
//           const Spacer(),
//
//           // logout button
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ElevatedButton(
//               onPressed: () async {
//                 final storage = FlutterSecureStorage();
//                 await storage.delete(key: 'auth_token');
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => const StartupScreen()),
//                       (route) => false,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff3c76ad),
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Logout'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Future _showEditProfileModal(BuildContext context) {
//   final TextEditingController bioController = TextEditingController();
//   const int maxCharacters = 150;
//
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return Container(
//         color: Colors.white,
//         height: MediaQuery.of(context).size.height * 0.95,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel", style: TextStyle(color: Colors.black, fontSize: 20))),
//                 TextButton(onPressed: () {}, child: const Text("Save", style: TextStyle(color: Colors.grey, fontSize: 20))),
//               ],
//             ),
//
//             // Profile Picture
//             const CircleAvatar(
//               radius: 60,
//               backgroundImage: AssetImage('assets/images/profile-sample.jpeg'),
//             ),
//             const SizedBox(height: 20),
//
//             // Name Heading
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Name',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'First Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Last Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Address',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     hintText: 'Town/City, Country/Region',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//
//             // Bio Section
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Bio',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     ValueListenableBuilder<TextEditingValue>(
//                       valueListenable: bioController,
//                       builder: (context, value, child) {
//                         return Text(
//                           '${value.text.length}/$maxCharacters',
//                           style: TextStyle(
//                             color: value.text.length >= maxCharacters ? Colors.red : Colors.black,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: bioController,
//                         maxLength: maxCharacters, // Limit the number of characters
//                         decoration: const InputDecoration(
//                           labelText: 'Max 150 Characters',
//                           border: OutlineInputBorder(),
//                           counterText: '', // Hide default counter
//                         ),
//                         maxLines: 3,
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// ---------------------------------------------------------------------




// Working
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jobtask/screens/profile/profile_update_handler.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/startup_screen.dart';
//
// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   Map<String, dynamic>? userData;
//   bool isLoading = true;
//   String? error;
//   final storage = const FlutterSecureStorage();
//   File? _selectedProfilePicture;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }
//
//   Future<void> _loadUserProfile() async {
//     try {
//       final token = await storage.read(key: 'auth_token');
//
//       if (token == null) {
//         setState(() {
//           error = 'No authentication token found';
//           isLoading = false;
//         });
//         return;
//       }
//
//       final profile = await ApiService.getUserProfile(token);
//       setState(() {
//         userData = profile;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }
//
//   // update profile picture
//   Future<void> _updateProfilePicture() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedProfilePicture = File(pickedFile.path);
//       });
//
//       final token = await storage.read(key: 'auth_token');
//       if (token != null) {
//         try {
//           final success = await ApiService.updateUserProfile(token, {
//             'profile_picture':
//                 'data:image/jpeg;base64,${await _selectedProfilePicture!.readAsBytes().then(
//                       (value) => base64Encode(value),
//                     )}',
//           });
//
//           if (success && mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                   content: Text('Profile picture updated successfully')),
//             );
//             _loadUserProfile(); // Reload the profile
//           }
//         } catch (e) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to update profile picture: $e')),
//             );
//           }
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : error != null
//               ? Center(child: Text('Error: $error'))
//               : SingleChildScrollView(
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Profile picture
//                         Padding(
//                           padding: const EdgeInsets.only(top: 40.0, bottom: 15),
//                           child: GestureDetector(
//                             onTap: _updateProfilePicture,
//                             child: Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: const Color(0xffd9d9d9),
//                                 image: _selectedProfilePicture != null
//                                     ? DecorationImage(
//                                         image:
//                                             FileImage(_selectedProfilePicture!),
//                                         fit: BoxFit.cover,
//                                       )
//                                     : userData?['profile_picture'] != null
//                                         ? DecorationImage(
//                                             image: NetworkImage(
//                                                 userData!['profile_picture']),
//                                             fit: BoxFit.cover,
//                                           )
//                                         : null,
//                               ),
//                               child: (_selectedProfilePicture == null &&
//                                       userData?['profile_picture'] == null)
//                                   ? const Icon(
//                                       Icons.camera_enhance,
//                                       size: 40,
//                                       color: Colors.white,
//                                     )
//                                   : null,
//                             ),
//                           ),
//                         ),
//
//                         // User name
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           child: Text(
//                             userData?['display_name'] ?? 'No Name',
//                             style: const TextStyle(fontSize: 25),
//                           ),
//                         ),
//
//                         // User details
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Email: ${userData?['email'] ?? 'N/A'}'),
//                               const SizedBox(height: 10),
//                               Text(
//                                   'Username: ${userData?['nicename'] ?? 'N/A'}'),
//                               const SizedBox(height: 10),
//                               Text(
//                                   'Address: ${userData?['address'] ?? 'Not set'}'),
//                               const SizedBox(height: 10),
//                               Text(
//                                   'Shoe Size: ${userData?['shoe_size'] ?? 'Not set'}'),
//                               const SizedBox(height: 10),
//                               Text('Bio: ${userData?['bio'] ?? 'Not set'}'),
//                               const SizedBox(height: 10),
//                               Text(
//                                   'Member since: ${userData?['registered']?.split(' ')[0] ?? 'N/A'}'),
//                             ],
//                           ),
//                         ),
//
//                         // Edit profile button
//                         OutlinedButton(
//                           onPressed: () => _showEditProfileModal(context),
//                           child: const Padding(
//                             padding: EdgeInsets.all(15.0),
//                             child: Text(
//                               'Edit Profile',
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.black),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         // Logout button
//                         ElevatedButton(
//                           onPressed: () async {
//                             await storage.delete(key: 'auth_token');
//                             if (mounted) {
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const StartupScreen()),
//                                 (route) => false,
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff3c76ad),
//                             foregroundColor: Colors.white,
//                           ),
//                           child: const Text('Logout'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//     );
//   }
//
//   Future<void> _showEditProfileModal(BuildContext context) async {
//     final TextEditingController displayNameController =
//         TextEditingController(text: userData?['display_name']);
//     final TextEditingController addressController =
//         TextEditingController(text: userData?['address']);
//     final TextEditingController bioController =
//         TextEditingController(text: userData?['bio']);
//     final TextEditingController shoeSizeController =
//         TextEditingController(text: userData?['shoe_size']);
//     const int maxBioCharacters = 150;
//
//     final result = await showModalBottomSheet<bool>(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height * 0.9,
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, false),
//                     child: const Text("Cancel",
//                         style: TextStyle(color: Colors.black, fontSize: 20)),
//                   ),
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, true),
//                     child: const Text("Save",
//                         style: TextStyle(color: Colors.black, fontSize: 20)),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: _updateProfilePicture,
//                             child: Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: const Color(0xffd9d9d9),
//                                 image: _selectedProfilePicture != null
//                                     ? DecorationImage(
//                                         image: FileImage(_selectedProfilePicture!),
//                                         fit: BoxFit.cover,
//                                       )
//                                     : userData?['profile_picture'] != null
//                                         ? DecorationImage(
//                                             image: NetworkImage(
//                                                 userData!['profile_picture']),
//                                             fit: BoxFit.cover,
//                                           )
//                                         : null,
//                               ),
//                               child: (_selectedProfilePicture == null &&
//                                       userData?['profile_picture'] == null)
//                                   ? const Icon(
//                                       Icons.camera_enhance,
//                                       size: 40,
//                                       color: Colors.white,
//                                     )
//                                   : null,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       const Text('Display Name',
//                           style: TextStyle(fontSize: 18)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: displayNameController,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text('Address', style: TextStyle(fontSize: 18)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: addressController,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Enter your address',
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text('Shoe Size', style: TextStyle(fontSize: 18)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: shoeSizeController,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Enter your shoe size',
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text('Bio', style: TextStyle(fontSize: 18)),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: bioController,
//                         maxLength: maxBioCharacters,
//                         maxLines: 3,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Tell us about yourself',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     if (result == true) {
//       final token = await storage.read(key: 'auth_token');
//       if (token != null) {
//         try {
//           // Prepare the profile data using the new handler
//           final profileData = await ProfileUpdateHandler.prepareProfileData(
//             displayNameController: displayNameController,
//             addressController: addressController,
//             shoeSizeController: shoeSizeController,
//             bioController: bioController,
//             selectedProfilePicture: _selectedProfilePicture,
//             currentUserData: userData,
//           );
//
//           // Only proceed with the update if there are changes
//           if (profileData.isNotEmpty) {
//             final success = await ApiService.updateUserProfile(token, profileData);
//
//             if (success && mounted) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Profile updated successfully')),
//               );
//               _loadUserProfile(); // Reload the profile
//             }
//           } else {
//             if (mounted) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('No changes to update')),
//               );
//             }
//           }
//         } catch (e) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to update profile: $e')),
//             );
//           }
//         }
//       }
//     }
//     // if (result == true) {
//     //   final token = await storage.read(key: 'auth_token');
//     //   if (token != null) {
//     //     try {
//     //       final success = await ApiService.updateUserProfile(token, {
//     //         'display_name': displayNameController.text,
//     //         'profile_picture': _selectedProfilePicture != null
//     //             ? 'data:image/jpeg;base64,${await _selectedProfilePicture!.readAsBytes().then((value) => base64Encode(value))}'
//     //             : userData?['profile_picture'],
//     //         'address': addressController.text,
//     //         'shoe_size': shoeSizeController.text,
//     //         'bio': bioController.text,
//     //       });
//     //
//     //       if (success && mounted) {
//     //         ScaffoldMessenger.of(context).showSnackBar(
//     //           const SnackBar(content: Text('Profile updated successfully')),
//     //         );
//     //         _loadUserProfile(); // Reload the profile
//     //       }
//     //     } catch (e) {
//     //       if (mounted) {
//     //         ScaffoldMessenger.of(context).showSnackBar(
//     //           SnackBar(content: Text('Failed to update profile: $e')),
//     //         );
//     //       }
//     //     }
//     //   }
//     // }
//   }
// }

















































// // -----------------------------------------
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jobtask/screens/profile/profile_update_handler.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/startup_screen.dart';
// import 'package:jobtask/utils/custom_buttons/my_button.dart';
//
// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   Map<String, dynamic>? userData;
//   bool isLoading = true;
//   String? error;
//   final storage = const FlutterSecureStorage();
//   File? _selectedProfilePicture;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }
//
//   Future<void> _loadUserProfile() async {
//     try {
//       final token = await storage.read(key: 'auth_token');
//       if (token == null) {
//         setState(() {
//           error = 'No authentication token found';
//           isLoading = false;
//         });
//         return;
//       }
//
//       final profile = await ApiService.getUserProfile(token);
//       setState(() {
//         userData = profile;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }
//
//   Widget _buildProfileCard(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       elevation: 0,
//       shadowColor: Colors.blue,
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: const Color(0xffd9d9d9),
//               backgroundImage: userData?['profile_picture'] != null
//                   ? NetworkImage(userData!['profile_picture'])
//                   : null,
//               child: userData?['profile_picture'] == null
//                   ? const Icon(Icons.person, size: 50, color: Colors.white)
//                   : null,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               userData?['display_name'] ?? 'No Name',
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               userData?['email'] ?? 'N/A',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoSection(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff3c76ad),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator(color: Color(0xff3c76ad),))
//           : error != null
//           ? Center(child: Text('Error: $error'))
//           : LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: Center(
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 600),
//                 child: Column(
//                   children: [
//                     _buildProfileCard(context),
//                     Card(
//                       color: Colors.white,
//                       elevation: 0,
//                       shadowColor: Colors.blue,
//                       margin: const EdgeInsets.all(16),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildInfoSection(
//                               'Username',
//                               userData?['nicename'] ?? 'N/A',
//                             ),
//                             _buildInfoSection(
//                               'Address',
//                               userData?['address'] ?? 'Not set',
//                             ),
//                             _buildInfoSection(
//                               'Shoe Size',
//                               userData?['shoe_size'] ?? 'Not set',
//                             ),
//                             _buildInfoSection(
//                               'Bio',
//                               userData?['bio'] ?? 'Not set',
//                             ),
//                             _buildInfoSection(
//                               'Member since',
//                               userData?['registered']?.split(' ')[0] ?? 'N/A',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       child: Row(
//                         children: [
//                           // Expanded(
//                           //   child: ElevatedButton.icon(
//                           //     onPressed: () => _showEditProfileModal(context),
//                           //     icon: const Icon(Icons.edit),
//                           //     label: const Text('Edit Profile'),
//                           //     style: ElevatedButton.styleFrom(
//                           //       backgroundColor: const Color(0xff3c76ad),
//                           //       foregroundColor: Colors.white,
//                           //       padding: const EdgeInsets.all(16),
//                           //     ),
//                           //   ),
//                           // ),
//                           Expanded(
//                             child: MyButton(text: "Edit Profile", onTap: (){
//                               _showEditProfileModal(context);
//                             }),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton.icon(
//                               onPressed: () async {
//                                 await storage.delete(key: 'auth_token');
//                                 if (mounted) {
//                                   Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                       builder: (context) => const StartupScreen(),
//                                     ),
//                                         (route) => false,
//                                   );
//                                 }
//                               },
//                               icon: const Icon(Icons.logout),
//                               label: const Text('Logout'),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: Colors.red,
//                                 padding: const EdgeInsets.all(16),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> _updateProfilePicture(BuildContext context) async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedProfilePicture = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<void> _showEditProfileModal(BuildContext context) async {
//     final TextEditingController displayNameController =
//     TextEditingController(text: userData?['display_name']);
//     final TextEditingController addressController =
//     TextEditingController(text: userData?['address']);
//     final TextEditingController bioController =
//     TextEditingController(text: userData?['bio']);
//     final TextEditingController shoeSizeController =
//     TextEditingController(text: userData?['shoe_size']);
//     const int maxBioCharacters = 150;
//
//     final result = await showModalBottomSheet<bool>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           height: MediaQuery.of(context).size.height * 0.9,
//           padding: EdgeInsets.only(
//             top: 16,
//             left: 16,
//             right: 16,
//             bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, false),
//                     child: const Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                   ),
//                   const Text(
//                     "Edit Profile",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, true),
//                     child: const Text(
//                       "Save",
//                       style: TextStyle(
//                         color: Color(0xff3c76ad),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 50,
//                               backgroundColor: const Color(0xffd9d9d9),
//                               backgroundImage: _selectedProfilePicture != null
//                                   ? FileImage(_selectedProfilePicture!)
//                                   : userData?['profile_picture'] != null
//                                   ? NetworkImage(userData!['profile_picture'])
//                               as ImageProvider
//                                   : null,
//                               child: (_selectedProfilePicture == null &&
//                                   userData?['profile_picture'] == null)
//                                   ? const Icon(
//                                 Icons.person,
//                                 size: 50,
//                                 color: Colors.white,
//                               )
//                                   : null,
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: CircleAvatar(
//                                 radius: 18,
//                                 backgroundColor: const Color(0xff3c76ad),
//                                 child: IconButton(
//                                   icon: const Icon(
//                                     Icons.camera_alt,
//                                     size: 18,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: () => _updateProfilePicture(context),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       _buildEditField(
//                         "Display Name",
//                         displayNameController,
//                         "Enter your display name",
//                       ),
//                       _buildEditField(
//                         "Address",
//                         addressController,
//                         "Enter your address",
//                       ),
//                       _buildEditField(
//                         "Shoe Size",
//                         shoeSizeController,
//                         "Enter your shoe size",
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Bio',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: bioController,
//                         maxLength: maxBioCharacters,
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           hintText: 'Tell us about yourself',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey[50],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     if (result == true) {
//       final token = await storage.read(key: 'auth_token');
//       if (token != null) {
//         try {
//           final profileData = await ProfileUpdateHandler.prepareProfileData(
//             displayNameController: displayNameController,
//             addressController: addressController,
//             shoeSizeController: shoeSizeController,
//             bioController: bioController,
//             selectedProfilePicture: _selectedProfilePicture,
//             currentUserData: userData,
//           );
//
//           if (profileData.isNotEmpty) {
//             final success = await ApiService.updateUserProfile(token, profileData);
//
//             if (success && mounted) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Profile updated successfully')),
//               );
//               _loadUserProfile();
//             }
//           } else {
//             if (mounted) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('No changes to update')),
//               );
//             }
//           }
//         } catch (e) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to update profile: $e')),
//             );
//           }
//         }
//       }
//     }
//   }
//
//   Widget _buildEditField(
//       String label,
//       TextEditingController controller,
//       String hintText,
//       ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               hintText: hintText,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               filled: true,
//               fillColor: Colors.grey[50],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }











































import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobtask/screens/profile/profile_update_handler.dart';
import 'package:jobtask/screens/profile/settings_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/startup_screen.dart';
import 'package:jobtask/utils/custom_border.dart';
import 'package:jobtask/utils/custom_buttons/icon_text_button.dart';
import 'dart:io';

import 'package:jobtask/utils/custom_snackbar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? error;
  final storage = const FlutterSecureStorage();
  File? _selectedProfilePicture;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) {
        setState(() {
          error = 'No authentication token found';
          isLoading = false;
        });
        return;
      }

      final profile = await ApiService.getUserProfile(token);
      setState(() {
        userData = profile;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _updateProfilePicture(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedProfilePicture = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff3c76ad),))
          : error != null
          ? Center(child: Text('Error: $error'))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 15),
            child: GestureDetector(
              // onTap: () => _updateProfilePicture(context),
              onTap: () {},
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffd9d9d9),
                  image: _selectedProfilePicture != null
                      ? DecorationImage(
                      image: FileImage(_selectedProfilePicture!),
                      fit: BoxFit.cover)
                      : userData?['profile_picture'] != null
                      ? DecorationImage(
                      image: NetworkImage(userData!['profile_picture']),
                      fit: BoxFit.cover)
                      : null,
                ),
                child: _selectedProfilePicture == null &&
                    userData?['profile_picture'] == null
                    ? const Icon(
                  Icons.camera_enhance,
                  size: 40,
                  color: Colors.white,
                )
                    : null,
              ),
            ),
          ),

          // User Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              userData?['display_name'] ?? 'User Name',
              style: const TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 10,),
          // Edit Profile Button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey)
            ),
            onPressed: () => _showEditProfileModal(context),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Row -> Order History & Settings
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconTextButton(
                  imagePath: 'assets/icons/order_history_icon.png',
                  text: 'Order History',
                  textColor: Colors.black,
                  onPressed: () {},
                  iconColor: const Color(0xffbababa),
                ),
                const SizedBox(
                  height: 40,
                  child: VerticalDivider(thickness: 3),
                ),
                IconTextButton(
                  imagePath: 'assets/icons/settings_icon.png',
                  text: 'Settings',
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(
                          userData: userData,
                        ),
                      ),
                    );
                  },
                  iconColor: const Color(0xffbababa),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditProfileModal(BuildContext context) async {
    final TextEditingController displayNameController =
    TextEditingController(text: userData?['display_name']);
    final TextEditingController addressController =
    TextEditingController(text: userData?['address']);
    final TextEditingController bioController =
    TextEditingController(text: userData?['bio']);
    final TextEditingController shoeSizeController =
    TextEditingController(text: userData?['shoe_size']);
    const int maxBioCharacters = 150;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Color(0xff3c76ad),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xffd9d9d9),
                              backgroundImage: _selectedProfilePicture != null
                                  ? FileImage(_selectedProfilePicture!)
                                  : userData?['profile_picture'] != null
                                  ? NetworkImage(userData!['profile_picture'])
                              as ImageProvider
                                  : null,
                              child: (_selectedProfilePicture == null &&
                                  userData?['profile_picture'] == null)
                                  ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xff3c76ad),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _updateProfilePicture(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildEditField(
                        "Display Name",
                        displayNameController,
                        "Enter your display name",
                      ),
                      _buildEditField(
                        "Address",
                        addressController,
                        "Enter your address",
                      ),
                      _buildEditField(
                        "Shoe Size",
                        shoeSizeController,
                        "Enter your shoe size",
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Bio',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: bioController,
                        maxLength: maxBioCharacters,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Tell us about yourself',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result == true) {
      final token = await storage.read(key: 'auth_token');
      if (token != null) {
        try {
          final profileData = await ProfileUpdateHandler.prepareProfileData(
            displayNameController: displayNameController,
            addressController: addressController,
            shoeSizeController: shoeSizeController,
            bioController: bioController,
            selectedProfilePicture: _selectedProfilePicture,
            currentUserData: userData,
          );

          if (profileData.isNotEmpty) {
            final success = await ApiService.updateUserProfile(token, profileData);

            if (success && mounted) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text('Profile updated successfully')),
              // );
              CustomSnackbar.show(
                context: context,
                message: 'Profile updated successfully',
              );
              _loadUserProfile();
            }
          } else {
            if (mounted) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text('No changes to update')),
              // );
              CustomSnackbar.show(
                context: context,
                message: 'No changes to update',
              );
            }
          }
        } catch (e) {
          if (mounted) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Failed to update profile: $e')),
            // );
            CustomSnackbar.show(
              context: context,
              message: 'Failed to update profile: $e',
            );
          }
        }
      }
    }
  }

  Widget _buildEditField(
      String label,
      TextEditingController controller,
      String hintText,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelStyle: TextStyle(color: Color(0xff767676)),
              border: customBorder(),
              enabledBorder: customBorder(),
              focusedBorder: customBorder(),
              // border: OutlineInputBorder(
              //   // borderRadius: BorderRadius.circular(2),
              // ),
              // filled: true,
              // fillColor: Colors.grey[50],
            ),
          ),
        ],
      ),
    );
  }
}
