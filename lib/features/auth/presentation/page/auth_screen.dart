import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/auth/data/models%20(Dto)/login_user.dart';
import 'package:chantier_plus/features/auth/domain/usecases/login_usecase.dart';
import 'package:chantier_plus/features/auth/presentation/page/signup_screen.dart';
import 'package:chantier_plus/features/auth/presentation/widget/custom_password_field.dart';
import 'package:chantier_plus/common/widgets/inputs/cutom_text_form_field.dart';
import 'package:chantier_plus/service_locator.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var result =
                              await serviceLocator<LoginUsecase>().call(
                            params: LoginUser(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );

                          if (result.success) {
                            // Si la connexion est réussie
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(result.content ?? "Login successful"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Vous pouvez également naviguer vers une autre page ici
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Pas encore inscrit ? ',
          style: TextStyle(fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            // Action à effectuer lorsque le texte est tapé
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SignUpScreen())); // Remplacez par votre route
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
