import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/confirmed_password.dart';
import '../../models/email.dart';
import '../../models/password.dart';
import '../../models/username.dart';

enum ConfirmPasswordValidationError { invalid }

final class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.username = const Username.pure(),
    this.photo,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Username username;
  final Uint8List? photo;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        username,
        photo,
        status,
        isValid,
        errorMessage,
      ];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Username? username,
    Uint8List? photo,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      username: username ?? this.username,
      photo: photo ?? this.photo,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
