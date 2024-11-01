import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ProfileUpdateHandler {
  static Future<Map<String, dynamic>> prepareProfileData({
    required TextEditingController displayNameController,
    required TextEditingController addressController,
    required TextEditingController shoeSizeController,
    required TextEditingController bioController,
    required File? selectedProfilePicture,
    required Map<String, dynamic>? currentUserData,
  }) async {
    final Map<String, dynamic> profileData = {};

    // Only include display_name if it's not empty and different from current
    if (displayNameController.text.trim().isNotEmpty &&
        displayNameController.text != currentUserData?['display_name']) {
      profileData['display_name'] = displayNameController.text.trim();
    }

    // Handle profile picture
    if (selectedProfilePicture != null) {
      final bytes = await selectedProfilePicture.readAsBytes();
      profileData['profile_picture'] = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    } else if (currentUserData?['profile_picture'] != null) {
      // Only include existing profile picture if we're not uploading a new one
      profileData['profile_picture'] = currentUserData!['profile_picture'];
    }

    // Only include address if it's not empty and different from current
    final trimmedAddress = addressController.text.trim();
    if (trimmedAddress.isNotEmpty && trimmedAddress != currentUserData?['address']) {
      profileData['address'] = trimmedAddress;
    }

    // Only include shoe_size if it's not empty and different from current
    final trimmedShoeSize = shoeSizeController.text.trim();
    if (trimmedShoeSize.isNotEmpty && trimmedShoeSize != currentUserData?['shoe_size']) {
      profileData['shoe_size'] = trimmedShoeSize;
    }

    // Only include bio if it's not empty and different from current
    final trimmedBio = bioController.text.trim();
    if (trimmedBio.isNotEmpty && trimmedBio != currentUserData?['bio']) {
      profileData['bio'] = trimmedBio;
    }

    return profileData;
  }
}