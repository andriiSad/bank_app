import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../models/confirmed_password.dart';
import '../../models/password.dart';

enum UploadStatus { initial, inProgress, success, failure }

enum PasswordChangeStatus { initial, inProgress, success, failure }

class EditState extends Equatable {
  const EditState({
    this.photo,
    this.photoUploadStatus = UploadStatus.initial,
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.passwordChangeStatus = PasswordChangeStatus.initial,
    this.isValid = false,
  });

  final Uint8List? photo;
  final UploadStatus photoUploadStatus;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final PasswordChangeStatus passwordChangeStatus;
  final bool isValid;

  @override
  List<Object?> get props => [
        photo,
        photoUploadStatus,
        password,
        confirmedPassword,
        passwordChangeStatus,
        isValid,
      ];

  EditState copyWith({
    Uint8List? photo,
    UploadStatus? photoUploadStatus,
    String? photoDownloadUrl,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    PasswordChangeStatus? passwordChangeStatus,
    bool? isValid,
  }) {
    return EditState(
      photo: photo ?? this.photo,
      photoUploadStatus: photoUploadStatus ?? this.photoUploadStatus,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      passwordChangeStatus: passwordChangeStatus ?? this.passwordChangeStatus,
      isValid: isValid ?? this.isValid,
    );
  }
}
