import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

import '../../models/confirmed_password.dart';
import '../../models/credit_card.dart';
import '../../models/email.dart';
import '../../models/password.dart';
import '../../models/user.dart';
import '../../models/username.dart';
import '../../repository/authentication_repository.dart';
import '../../repository/firestore_repository.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this._authenticationRepository,
    this._firestoreRepository,
  ) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final FirestoreRepository _firestoreRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
          state.username,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.username,
          password,
          confirmedPassword,
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
          state.email,
          state.password,
          state.username,
          confirmedPassword,
        ]),
      ),
    );
  }

  void userNameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          username,
        ]),
      ),
    );
  }

  void photoChanged(Uint8List photo) {
    emit(
      state.copyWith(
        photo: photo,
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) {
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final userId = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      final User user = User(
        id: userId,
        email: state.email.value,
        username: state.username.value,
      );
      final cards = [
        CreditCard.generateNew(
          ownerId: userId,
          balance: 5000,
          type: CreditCardType.premium,
        ),
        CreditCard.generateNew(
          ownerId: userId,
          balance: 10000,
          type: CreditCardType.platinum,
        ),
      ];
      await _firestoreRepository.createUser(
        user: user,
        cards: cards,
        file: state.photo,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<Uint8List> loadImageBytes(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }
}
