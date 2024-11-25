import 'package:chantier_plus/core/configs/theme/app_theme.dart';
import 'package:chantier_plus/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:chantier_plus/features/auth/presentation/page/auth_gate.dart';
import 'package:chantier_plus/firebase_options.dart';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              AuthenticationBloc()..add(AuthenticationSubscriptionRequested()),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const AuthGate(),
      ),
    );
  }
}
