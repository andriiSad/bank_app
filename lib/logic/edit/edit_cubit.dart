import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

import '../../models/confirmed_password.dart';
import '../../models/password.dart';
import '../../repository/authentication_repository.dart';
import '../../repository/firestore_repository.dart';
import 'edit_states.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit(
    this._firestoreRepository,
    this._authenticationRepository,
  ) : super(const EditState());

  final FirestoreRepository _firestoreRepository;
  final AuthenticationRepository _authenticationRepository;

  void photoChanged(Uint8List photo) {
    emit(
      state.copyWith(
        photo: photo,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> updateUserPhoto() async {
    if (state.photo == null) {
      return;
    }
    emit(state.copyWith(photoUploadStatus: UploadStatus.inProgress));

    try {
      final downloadUrl = await _firestoreRepository.updateUserProfilePhoto(
          userId: _authenticationRepository.currentUser.id,
          file: state.photo!.buffer.asUint8List());

      emit(state.copyWith(
        photoUploadStatus: UploadStatus.success,
        photoDownloadUrl: downloadUrl,
      ));
    } catch (_) {
      emit(state.copyWith(photoUploadStatus: UploadStatus.failure));
    }
  }

  Future<void> changePassword() async {
    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(passwordChangeStatus: PasswordChangeStatus.inProgress));

    try {
      // Call a function in your authentication repository to change the password
      await _authenticationRepository.changePassword(state.password.value);

      emit(state.copyWith(passwordChangeStatus: PasswordChangeStatus.success));

      emit(const EditState());
    } catch (_) {
      emit(state.copyWith(passwordChangeStatus: PasswordChangeStatus.failure));
    }
  }

  Future<Uint8List> loadImageBytes(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }
}
