import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/profile_screen/riverpod/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
import '../../../core/services/api_services/api_endpoints.dart';

final profileProvider = StateNotifierProvider<ProfileProvider, ProfileState>((
  ref,
) {
  final userToken = ref.watch(authProvider).userToken ?? '';
  final authNotifier = ref.read(authProvider.notifier);
  return ProfileProvider(userToken, authNotifier);
});

class ProfileProvider extends StateNotifier<ProfileState> {
  final String userToken;
  final AuthProvider authNotifier;

  ProfileProvider(this.userToken, this.authNotifier) : super(ProfileState());

  Future<void> pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      state = state.copyWith(temporaryProfilePicture: File(picked.path));
    }
  }

  Future<void> onSubmit({String? name}) async {
    try {
      ReceivePort receivePort = ReceivePort();
      final Map<String, dynamic> args = {
        "name": name,
        "userToken": userToken,
        "profileImage": state.temporaryProfilePicture,
        "sendPort": receivePort.sendPort,
      };

      await Isolate.spawn(onSubmitInAnotherThread, args);

      receivePort.listen((data) async {
        if (data == true) {
          Fluttertoast.showToast(
            msg: "Successfully updated profile",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Failed to update profile",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
          );
        }
        authNotifier.updateUserModel();
      });
    } catch (error) {
      throw Exception(
        "Error while updating profile in another thread : $error",
      );
    }
  }
}

Future<void> onSubmitInAnotherThread(Map<String, dynamic> args) async {
  try {
    String? name = args["name"];
    String userToken = args["userToken"];
    File? profileImage = args["profileImage"];
    SendPort sendPort = args['sendPort'];

    /// Define the URI
    var uri = Uri.parse('${ApiEndPoints.baseUrl}/${ApiEndPoints.editProfile}');

    /// Create a MultipartRequest
    var request = http.MultipartRequest('PATCH', uri);

    debugPrint("\ntoken in edit profile : $userToken\n");

    /// Add headers
    request.headers['Authorization'] = "$userToken";

    /// Add text fields
    if (name != null) {
      request.fields['name'] = name;
    }

    /// Add the image file if it exists
    if (profileImage != null) {
      //  XFile compressedImage = XFile(profileImage.path);

      File imageFile = profileImage;

      // Determine the MIME type of the image (you might need to adjust this)
      String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
      var mimeSplit = mimeType.split('/');

      // Create a MultipartFile
      var multipartFile = await http.MultipartFile.fromPath(
        'avatar',
        imageFile.path,
        contentType: MediaType(mimeSplit[0], mimeSplit[1]),
      );

      request.files.add(multipartFile);
    }

    /// Send the request
    var streamedResponse = await request.send();

    /// Get the response
    var response = await http.Response.fromStream(streamedResponse);
    var decodedData = jsonDecode(response.body);

    if (decodedData["success"] == true) {
      //   await updateUserModel();
      sendPort.send(true);
    } else {
      sendPort.send(false);
      throw Exception(
        "failed to edit profile. Update failed: ${decodedData["message"]}",
      );
    }
  } catch (error) {
    throw Exception("Error during profile update: $error");
  }
}

/// Utility method to determine MIME type
String? lookupMimeType(String path) {
  final extension = path.split('.').last.toLowerCase();
  switch (extension) {
    case 'png':
      return 'image/png';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'gif':
      return 'image/gif';
    default:
      return null;
  }
}
