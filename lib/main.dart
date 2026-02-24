import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partnest/core/theme/app_theme.dart';
import 'package:partnest/features/auth/presentation/pages/onboarding/welcome_role_selection_page.dart';
import 'package:partnest/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:partnest/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:partnest/features/auth/presentation/blocs/sme_profile_cubit/sme_profile_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            authRepository: MockAuthRepository(),
          ),
        ),
        BlocProvider<SmeProfileCubit>(
          create: (_) => SmeProfileCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Partnex MVP',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const WelcomeRoleSelectionPage(),
      ),
    );
  }
}
