import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/widgets/modal/loginmodal.dart';
import 'package:flutterapp/widgets/modal/signupmodal.dart';
import 'package:flutterapp/widgets/rectangletextbutton.dart';

class Restrictionmodal extends StatelessWidget {
  const Restrictionmodal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: Appkeys.signUpOrLoginModal,
      backgroundColor: AppColors.modalBackground,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 12,
            children: [
              RectangleTextbutton(
                buttonColor: AppColors.info,
                size: Size(120, 32),
                onPressed: () {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    barrierColor: AppColors.modalBarrier,
                    builder: (context) => const Signupmodal(),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(height: 16),
                  const Expanded(
                    child: Divider(color: AppColors.modalBorder, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.modalLabel,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.modalBorder, thickness: 1),
                  ),
                ],
              ),
              RectangleTextbutton(
                buttonColor: AppColors.modalButtonFilled,
                size: Size(120, 32),
                onPressed: () {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    barrierColor: AppColors.modalBarrier,
                    builder: (context) => const Loginmodal(),
                  );
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
