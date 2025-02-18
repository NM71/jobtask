import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobtask/screens/profile/order_history_screen.dart';
import 'package:jobtask/screens/profile/profile_update_handler.dart';
import 'package:jobtask/screens/profile/settings_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_buttons/icon_text_button.dart';
import 'package:jobtask/utils/custom_profile_border.dart';
import 'dart:io';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

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
    if (!mounted) return;

    try {
      final token = await storage.read(key: 'auth_token');
      if (!mounted) return;

      if (token == null) {
        setState(() {
          error = 'No authentication token found';
          isLoading = false;
        });
        return;
      }

      final profile = await ApiService.getUserProfile(token);
      if (!mounted) return;

      setState(() {
        userData = profile;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _updateProfilePicture(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedProfilePicture = File(pickedFile.path);
      });
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';

    final date = DateTime.parse(dateString);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${months[date.month - 1]} ${date.year}';
  }

  // Shimmers for the Profile Page
  Widget _buildShimmerEffect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Picture Shimmer
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 84,
              width: 84,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // Name Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Edit Profile Button Shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
          ),
        ),

        const SizedBox(height: 40),

        // Order History & Settings Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconTextShimmer(),
              const SizedBox(
                height: 30,
                child: VerticalDivider(thickness: 3),
              ),
              _buildIconTextShimmer(),
            ],
          ),
        ),

        // Divider
        const Divider(
          color: Color(0xfff6f6f6),
          thickness: 8,
        ),

        const Spacer(),

        // Member Since Shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 19),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildIconTextShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 80,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? _buildShimmerEffect()
          : error != null
              // ? Center(child: Text('Error: $error'))
              ? Center(
                  child: Text(
                    'Profile could not be loaded, Reload the page ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 15),
                      child: GestureDetector(
                        // onTap: () => _updateProfilePicture(context),
                        onTap: () {
                          print(
                              'Profile Picture: ${userData?['profile_picture']}');
                        },
                        child: Container(
                          height: 84,
                          width: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffd9d9d9),
                            image: _selectedProfilePicture != null
                                ? DecorationImage(
                                    image: FileImage(_selectedProfilePicture!),
                                    fit: BoxFit.cover)
                                : userData?['profile_picture'] != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            userData!['profile_picture']),
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
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Edit Profile Button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey)),
                      onPressed: () => _showEditProfileModal(context),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 16, color: Colors.black),
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
                            imagePath: 'assets/icons/OrderHistory.png',
                            text: 'Order History',
                            textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: OrderHistoryScreen(),
                                      type: PageTransitionType.leftToRight));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => OrderHistoryScreen(),
                              //   ),
                              // );
                            },
                            iconColor: const Color(0xffbababa),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(thickness: 3),
                          ),
                          IconTextButton(
                            imagePath: 'assets/icons/Settings.png',
                            text: 'Settings',
                            textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            onPressed: () {
                              HapticFeedback.lightImpact();

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SettingsScreen(
                              //       userData: userData,
                              //     ),
                              //   ),
                              // );

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: SettingsScreen(
                                        userData: userData,
                                      ),
                                      type: PageTransitionType.fade));
                            },
                            iconColor: const Color(0xffbababa),
                          ),
                        ],
                      ),
                    ),

                    // horizontal divider
                    Divider(
                      color: Color(0xfff6f6f6),
                      thickness: 8,
                    ),

                    Spacer(),
                    // Member Since
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 19),
                        decoration: BoxDecoration(color: Color(0xfff6f6f6)),
                        child: Text(
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff767676)),
                            textAlign: TextAlign.center,
                            'Member Since ${_formatDate(userData?['registered'])}')),
                  ],
                ),
    );
  }

  // ModalSheet to edit the profile
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
    File? tempSelectedImage = _selectedProfilePicture;

    bool _hasChanges = false;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            void checkChanges() {
              setModalState(() {
                _hasChanges =
                    displayNameController.text != userData?['display_name'] ||
                        addressController.text != userData?['address'] ||
                        bioController.text != userData?['bio'] ||
                        shoeSizeController.text != userData?['shoe_size'] ||
                        _selectedProfilePicture != null;
              });
            }

            displayNameController.addListener(checkChanges);
            addressController.addListener(checkChanges);
            bioController.addListener(checkChanges);
            shoeSizeController.addListener(checkChanges);

            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              height: MediaQuery.of(context).size.height * 1,
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
                      TextButton(
                        onPressed: _hasChanges
                            ? () => Navigator.pop(context, true)
                            : null,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color:
                                _hasChanges ? Colors.black : Color(0xffBABABA),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                                  backgroundImage: tempSelectedImage != null
                                      ? FileImage(tempSelectedImage!)
                                      : userData?['profile_picture'] != null
                                          ? NetworkImage(
                                                  userData!['profile_picture'])
                                              as ImageProvider
                                          : null,
                                  child: (tempSelectedImage == null &&
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
                                      onPressed: () async {
                                        final pickedFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          setModalState(() {
                                            tempSelectedImage =
                                                File(pickedFile.path);
                                            _hasChanges = true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Center(
                              child: Text(
                            "Edit",
                            style: TextStyle(fontSize: 10),
                          )),
                          const SizedBox(height: 24),
                          _buildEditField(
                            "Name",
                            displayNameController,
                            "Enter your display name",
                          ),
                          _buildEditField(
                            "Hometown",
                            addressController,
                            "Town/City, Country/Region",
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
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: bioController,
                            maxLength: maxBioCharacters,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Tell us about yourself',
                              border: customProfileBorder(),
                              enabledBorder: customProfileBorder(),
                              focusedBorder: customProfileBorder(),
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
      },
    );

    if (result == true) {
      _selectedProfilePicture = tempSelectedImage;

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
            final success =
                await ApiService.updateUserProfile(token, profileData);

            if (success && mounted) {
              CustomSnackbar.show(
                context: context,
                message: 'Profile updated successfully',
              );
              _loadUserProfile();
            }
          } else {
            if (mounted) {
              CustomSnackbar.show(
                context: context,
                message: 'No changes to update',
              );
            }
          }
        } catch (e) {
          if (mounted) {
            CustomSnackbar.show(
              context: context,
              message: 'Failed to update profile: $e',
            );
          }
        }
      }
    }
  }

  // Edit profile custom components
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
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff767676)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelStyle: TextStyle(color: Color(0xff767676)),
              border: customProfileBorder(),
              enabledBorder: customProfileBorder(),
              focusedBorder: customProfileBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
