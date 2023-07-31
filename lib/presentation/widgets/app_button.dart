import 'package:flutter/material.dart';

import '../../common/values/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.callback,
    required this.backGroundColor,
    required this.textColor,
  });
  final String text;
  final void Function() callback;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                text,
                style: AppStyles.textStyle.copyWith(
                  color: textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Icon(
                Icons.arrow_right_alt,
                size: 35,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
