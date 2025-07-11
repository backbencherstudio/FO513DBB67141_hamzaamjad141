import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfileState {
  File? temporaryProfilePicture;
  ProfileState({this.temporaryProfilePicture});

  ProfileState copyWith({File? temporaryProfilePicture}) {
    return ProfileState(
      temporaryProfilePicture:
          temporaryProfilePicture ?? this.temporaryProfilePicture,
    );
  }

  ProfileState clearTemporaryData() =>
      ProfileState(temporaryProfilePicture: null);
}
