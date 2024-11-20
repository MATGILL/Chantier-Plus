import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/auth/domain/services/auth_service.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/presentation/page/auth_gate.dart';
import 'package:chantier_plus/features/auth/presentation/widget/custom_password_field.dart';
import 'package:chantier_plus/common/widgets/inputs/cutom_text_form_field.dart';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ignore: unused_field
  bool _isLoading = false; // État de chargement
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Variable pour stocker le rôle sélectionné
  String _selectedRole = "";

  @override
  void dispose() {
    // Nettoyer les contrôleurs pour éviter les fuites de mémoire
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWidget(),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomTextFormField(
                        labelText: "Nom d'utilisateur",
                        hintText: "Nom d'utilisateur",
                        controller: userNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomTextFormField(
                        labelText: "Adresse mail",
                        hintText: "Adresse mail",
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomPasswordField(
                        labelText: "Mot de passe",
                        hintText: "Mot de passe",
                        controller: passwordController,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 12),
                      child: Text(
                        "Vous êtes :",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Responsable de chantier",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Radio<String>(
                                value: "RESP",
                                activeColor: AppColors.primary,
                                groupValue: _selectedRole,
                                onChanged: onChanged,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Chef de chantier",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Radio<String>(
                                value: "CHEF",
                                activeColor: AppColors.primary,
                                groupValue: _selectedRole,
                                onChanged: onChanged,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: const Text("SignUp"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onPressed() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Commence le chargement
      });

      var result = await serviceLocator<AuthService>().signUp(
        UserEntity(
            email: emailController.text,
            fullName: userNameController.text,
            role: _selectedRole),
        passwordController.text,
      );

      setState(() {
        _isLoading = false; // Arrête le chargement
      });

      if (result.success) {
        // Si la connexion est réussie
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.content ?? "Inscription réussie"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
        );
        // Naviguer vers une autre page si nécessaire
      } else {
        // En cas d'échec
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.getErrorMessage()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void onChanged(String? value) {
    setState(() {
      _selectedRole = value!;
    });
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

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
