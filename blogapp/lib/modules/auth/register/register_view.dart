import 'package:blogapp/modules/auth/login/login_view.dart';
import 'package:blogapp/utils/colors/color.dart';
import 'package:blogapp/utils/services/auth_service.dart';
import 'package:blogapp/utils/ui/button/bg_button.dart';
import 'package:blogapp/utils/ui/input/bg_textfield.dart';
import 'package:blogapp/utils/ui/sizedbox/bg_sizedbox.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isShowError = false;
  String errorMassege = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circleAvatar('assets/images/logo.png'),
            const BgSizedBox(
              height: 20,
            ),
            _emailTextField(),
            const BgSizedBox(
              height: 10,
            ),
            _passwordTextField(),
            const BgSizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const Text(
                "Bir hesabınız var  mı?",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: CustomColor.accent,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const BgSizedBox(
              height: 10,
            ),
            _registerButton(),
            isShowError ? _errorMassege() : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  CircleAvatar circleAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 110,
      backgroundColor: CustomColor.primary,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(120),
            child: Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(color: CustomColor.primary);
  }

  FlutterLogo _logo() => const FlutterLogo(
        size: 100,
      );
  BgTextfield _emailTextField() => BgTextfield(
      textEditingController: emailController,
      hintText: "Email",
      keyboardType: TextInputType.emailAddress);

  BgTextfield _passwordTextField() => BgTextfield(
        textEditingController: passwordController,
        hintText: "Password",
        obscureText: true,
      );

  BgButton _registerButton() => BgButton(
      buttonTitle: "Kayıt ol",
      onPressed: () {
        registerButtonTapped();
      });

  Text _errorMassege() => Text(errorMassege,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: CustomColor.accent,
          fontSize: 20,
          fontWeight: FontWeight.bold));

  bool validateInputs() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showError("Lütfen boş alanları doldurunuz");
      return false;
    } else {
      if (EmailValidator.validate(emailController.text)) {
        hideError();
        return true;
      } else {
        showError("email formatı hatalı");
        return false;
      }
    }
  }

  Future<void> registerButtonTapped() async {
    try {
      if (validateInputs()) {
        final AuthService authService = AuthService();
        final User? user = await authService.signUp(
            emailController.text, passwordController.text);

        if (user != null) {
          Navigator.pushReplacementNamed(context, "/home-view");
        }
      }
    } catch (e) {
      showError(e.toString());
    }
  }

  void showError(String massege) {
    setState(() {
      isShowError = true;
      errorMassege = massege;
    });
  }

  void hideError() {
    setState(() {
      isShowError = false;
    });
  }
}
