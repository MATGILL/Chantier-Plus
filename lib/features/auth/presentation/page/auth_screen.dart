import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/auth/application(services)/services/auth_service.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/presentation/page/signup_screen.dart';
import 'package:chantier_plus/features/auth/presentation/widget/custom_password_field.dart';
import 'package:chantier_plus/common/widgets/inputs/cutom_text_form_field.dart';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false; // État de chargement
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
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
                      controller: emailController,
                    ),
                  ),
                  CustomPasswordField(
                    labelText: "Mot de passe",
                    hintText: "Mot de passe",
                    controller: passwordController,
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
                      onPressed: _isLoading
                          ? null
                          : _login, // Désactive le bouton pendant le chargement
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            ) // Montre un loader pendant le chargement
                          : const Text("Login"),
                    ),
                    TextButton(
                      child: const Text("forget password"),
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
      ),
    );
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Commence le chargement
      });

      var result = await serviceLocator<AuthService>().login(
          UserEntity(
            email: emailController.text,
          ),
          passwordController.text);

      setState(() {
        _isLoading = false; // Arrête le chargement
      });

      if (result.success) {
        // Si la connexion est réussie
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.content ?? "Login successful"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // En cas d'échec de la connexion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.getErrorMessage()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class TextNoAccount extends StatelessWidget {
  const TextNoAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Pas encore inscrit ? ',
          style: TextStyle(fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            'Créer un compte',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
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
