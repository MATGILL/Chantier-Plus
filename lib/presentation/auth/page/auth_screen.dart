import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/presentation/auth/widgets/custom_password_field.dart';
import 'package:chantier_plus/presentation/widgets/inputs/cutom_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 126.0, bottom: 35),
            child: Center(
              child: Image.asset(
                "assets/images/logo_crop.png",
                width: 230,
                height: 236,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const TitleWidget(),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: CustomTextFormField(
                    labelText: "Adresse mail",
                    hintText: "Adresse mail",
                    controller: TextEditingController(),
                  ),
                ),
                CustomPasswordField(
                  labelText: "Mot de passe",
                  hintText: "Mot de passe",
                  controller: TextEditingController(),
                ),
                const TextNoAccount()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //TODO implement methos
                    },
                    child: const Text("Login"),
                  ),
                  TextButton(
                    child: Text("forget password"),
                    onPressed: () {
                      //TODO implement methos
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextNoAccount extends StatelessWidget {
  const TextNoAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Pas encore inscrit ? ',
            style: TextStyle(fontSize: 15),
          ),
          TextSpan(
            text: 'Créer un compte ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
                color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        style: TextStyle(height: 0.1),
        children: [
          TextSpan(
            text: 'Welcome!\n',
            style: TextStyle(
                height: 0.1, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          TextSpan(
            text: 'to ',
            style: TextStyle(
                height: 1.5, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          TextSpan(
            text: 'ChantierPlus',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
