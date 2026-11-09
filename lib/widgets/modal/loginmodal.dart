import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/service/authservice.dart';
import 'package:flutterapp/service/toastservice.dart';
import 'package:flutterapp/widgets/modal/modaltextfield.dart';
import 'package:flutterapp/widgets/modal/modaltextfieldpassword.dart';
import 'package:flutterapp/widgets/modal/signupmodal.dart';
import 'package:flutterapp/widgets/rectangletextbutton.dart';

class Loginmodal extends StatefulWidget {
  const Loginmodal({super.key});

  @override
  State<Loginmodal> createState() => _LoginmodalState();
}

class _LoginmodalState extends State<Loginmodal> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _emailValid => _emailController.text.contains('@');
  bool get _passwordValid =>
      _passwordController.text.length > 8 &&
      RegExp(r'\d').hasMatch(_passwordController.text) &&
      RegExp(r'[a-z]').hasMatch(_passwordController.text);
  bool get _formValid => _emailValid && _passwordValid;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: Appkeys.loginModal,
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
              Row(
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(
                      color: AppColors.modalTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.modalTitle),
                    onPressed: () =>
                        Navigator.of(context).pop(), // schließt das Modal
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ModalTextField(
                key: Appkeys.emailTextField,
                label: 'Email',
                hintText: 'mail@site.com',
                controller: _emailController,
                onChanged: (_) => setState(() {}),
                errorText: _emailController.text.isEmpty || _emailValid
                    ? null
                    : 'Enter valid email address',
              ),
              ModalTextFieldPassword(
                key: Appkeys.passwordTextField,
                label: 'Password',
                hintText: 'Password',
                controller: _passwordController,
                onChanged: (_) => setState(() {}),
                errorText: _passwordController.text.isEmpty || _passwordValid
                    ? null
                    : 'Must be more than 8 characters, including\nAt least one number\nAt least one lowercase letter',
              ),
              RectangleTextbutton(
                key: Appkeys.logInButton,
                buttonColor: _formValid
                    ? AppColors.info
                    : AppColors.modalButtonDisabled,
                onPressed: !_formValid
                    ? null
                    : () async {
                        await Toastservice().useToastWithUserInfo(
                          context,
                          "Log in successful, Welcome",
                          "Log in failed for an unknown reason, please try again.",
                          () async {
                            return await AuthService().logIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                        );
                      },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _formValid ? Colors.black : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
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
              const SizedBox(height: 16),
              RectangleTextbutton(
                key: Appkeys.switchToSignUpButton,
                buttonColor: AppColors.modalButtonFilled,
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
                    color: AppColors.info,
                  ),
                ),
              ),
              RectangleTextbutton(
                buttonColor: Colors.transparent,
                borderColor: AppColors.info,
                onPressed: () {},
                child: Text(
                  "Login as Guest",
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
  }
}
