import 'dart:io';

import 'package:flutter/material.dart';

class ProfileUpdateHandler {
  static Future<Map<String, dynamic>> prepareProfileData({
    required TextEditingController displayNameController,
    required TextEditingController addressController,
    required TextEditingController bioController,
    required TextEditingController shoeSizeController,
    File? selectedProfilePicture,
    Map<String, dynamic>? currentUserData,
  }) async {
    Map<String, dynamic> profileData = {};

    if (displayNameController.text != currentUserData?['display_name']) {
      profileData['display_name'] = displayNameController.text;
    }

    if (addressController.text != currentUserData?['address']) {
      profileData['address'] = addressController.text;
    }

    if (bioController.text != currentUserData?['bio']) {
      profileData['bio'] = bioController.text;
    }

    if (shoeSizeController.text != currentUserData?['shoe_size']) {
      profileData['shoe_size'] = shoeSizeController.text;
    }

    if (selectedProfilePicture != null) {
      profileData['profile_picture'] = selectedProfilePicture.path;
    }

    return profileData;
  }
}
