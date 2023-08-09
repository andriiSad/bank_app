import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/values/app_colors.dart';
import '../../../common/values/app_styles.dart';
import '../../../logic/app/bloc/app_bloc.dart';
import '../../../logic/app/bloc/app_events.dart';
import '../../../logic/bottom_navigation/bottom_navigation_cubit.dart';
import '../../../logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import '../../../logic/edit/edit_cubit.dart';
import '../../../logic/edit/edit_states.dart';
import '../../widgets/app_button.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmedPasswordController =
        TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          const _SettingsAppBar(),
          const Gap(15),
          Center(
            child: _AvatarInput(photoUrl: appBloc.state.user.photoUrl),
          ),
          const Gap(15),
          _PasswordInput(
            controller: passwordController,
          ),
          const Gap(15),
          _ConfirmPasswordInput(
            controller: confirmedPasswordController,
          ),
          const Gap(15),
          _SaveButton(
            passwordController: passwordController,
            confirmedPasswordController: confirmedPasswordController,
          ),
          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _SettingsAppBar extends StatelessWidget {
  const _SettingsAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            BlocProvider.of<BottomNavigationCubit>(context)
                .getNavBarItem(BottomNavbarItem.home);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Settings',
              style: AppStyles.textStyle.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 24,
          height: 24,
        ),
      ],
    );
  }
}

class _AvatarInput extends StatefulWidget {
  const _AvatarInput({
    required this.photoUrl,
  });

  final String? photoUrl;
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
        context.read<EditCubit>().photoChanged(imageBytes);
        context.read<EditCubit>().updateUserPhoto();
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Convert File to ImageProvider
  ImageProvider<Object> _getImageProvider() {
    if (_imageFile != null) {
      return FileImage(_imageFile!);
    } else {
      return widget.photoUrl == null
          ? const AssetImage('assets/images/users/default_user.png')
          : NetworkImage(widget.photoUrl!) as ImageProvider<Object>;
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

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    required this.controller,
  });

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('settings_form_passwordInput_textField'),
          controller: controller,
          onChanged: (password) =>
              context.read<EditCubit>().passwordChanged(password),
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
  const _ConfirmPasswordInput({
    required this.controller,
  });

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('settings_form_confirmedPasswordInput_textField'),
          controller: controller,
          onChanged: (confirmPassword) => context
              .read<EditCubit>()
              .confirmedPasswordChanged(confirmPassword),
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

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.passwordController,
    required this.confirmedPasswordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmedPasswordController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      builder: (context, state) {
        return state.passwordChangeStatus == PasswordChangeStatus.inProgress
            ? CircularProgressIndicator(
                color: AppColors.red,
              )
            : ElevatedButton(
                key: const Key('settingsPage_save_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.black,
                ),
                onPressed: state.isValid
                    ? () async {
                        FocusScope.of(context).unfocus();
                        await context.read<EditCubit>().changePassword();
                        passwordController.clear();
                        confirmedPasswordController.clear();
                      }
                    : null,
                child: const Text('Save'),
              );
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'Log out',
      callback: () {
        context
            .read<BottomNavigationCubit>()
            .getNavBarItem(BottomNavbarItem.home);
        context.read<AppBloc>().add(const AppLogoutRequested());
      },
      backGroundColor: AppColors.black,
      textColor: AppColors.white,
    );
  }
}
