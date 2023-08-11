import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/values/app_colors.dart';
import '../../../common/values/app_layout.dart';
import '../../../logic/sign_up/sign_up_cubit.dart';
import '../../../logic/sign_up/sign_up_states.dart';
import '../login_page/login_page.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/bank_logo.svg',
                colorFilter: ColorFilter.mode(
                  AppColors.red,
                  BlendMode.srcIn,
                ),
                height: AppLayout.getHeight(120),
                width: AppLayout.getHeight(120),
              ),
              Gap(AppLayout.getHeight(15)),
              _AvatarInput(),
              Gap(AppLayout.getHeight(8)),
              _EmailInput(),
              Gap(AppLayout.getHeight(8)),
              _PasswordInput(),
              Gap(AppLayout.getHeight(8)),
              _ConfirmPasswordInput(),
              Gap(AppLayout.getHeight(8)),
              _UsernameInput(),
              Gap(AppLayout.getHeight(8)),
              _SignUpButton(),
              Gap(AppLayout.getHeight(8)),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().updateEmail(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText:
                state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().updatePassword(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .updateConfirmedPassword(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<SignUpCubit>().updateUsername(username),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'username',
            helperText: '',
            errorText:
                state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _AvatarInput extends StatefulWidget {
  @override
  _AvatarInputState createState() => _AvatarInputState();
}

class _AvatarInputState extends State<_AvatarInput> {
  File? _imageFile;

  // Function to open the image picker
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final Uint8List imageBytes = await imageFile.readAsBytes();

      setState(() {
        context.read<SignUpCubit>().updatePhoto(imageBytes);
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Convert File to ImageProvider
  ImageProvider<Object> _getImageProvider() {
    if (_imageFile != null) {
      return FileImage(_imageFile!);
    } else {
      // Return your default image provider here if no image is selected
      return const AssetImage('assets/images/users/default_user.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _getImageProvider(),
          backgroundColor: AppColors.grey,
          child: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      //TODO: Fix this
                      // title: const Text('Change Avatar'),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.photo_library),
                              SizedBox(width: 8),
                              Text('Choose from Gallery'),
                            ],
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.camera_alt),
                              SizedBox(width: 8),
                              Text('Take a Photo'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
                child: Icon(Icons.edit, size: 18, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator(
                color: AppColors.red,
              )
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: state.isValid
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('signUpForm_login_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(LoginPage.route()),
      child: Text(
        'LOGIN',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
