import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import '../../models/confirmed_password.dart';
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

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) {
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      final User user = User(
        id: _authenticationRepository.currentUser.id,
        email: state.email.value,
        balance: 9000,
        photo: 'assets/images/users/ivan.jpg',
        username: state.username.value,
      );
      await _firestoreRepository.createUser(user: user);

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
}
