import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:chantier_plus/domain/usecases/auth/signup_usecase.dart';
import 'package:chantier_plus/presentation/auth/widgets/custom_password_field.dart';
import 'package:chantier_plus/presentation/widgets/inputs/cutom_text_form_field.dart';
import 'package:chantier_plus/service_locator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  //TODO add form validation and add user info in the database

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _userNameController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                        labelText: "Nom d'utilisateur",
                        hintText: "Nom d'utilisateur",
                        controller: _userNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomTextFormField(
                        labelText: "Adresse mail",
                        hintText: "Adresse mail",
                        controller: _emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomPasswordField(
                        labelText: "Mot de passe",
                        hintText: "Mot de passe",
                        controller: _passwordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomPasswordField(
                        labelText: "Confirmer le mot de passe",
                        hintText: "Confirmer le mot de passe",
                        controller: TextEditingController(),
                      ),
                    ),
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
                          if (_formKey.currentState!.validate()) {
                            var result =
                                await serviceLocator<SignupUsecase>().call(
                              params: CreateUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  fullName: _userNameController.text),
                            );

                            if (result.success) {
                              // Si la connexion est réussie
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      result.content ?? "Login successful"),
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
                        child: const Text("SignUp"),
                      ),
                    ],
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
