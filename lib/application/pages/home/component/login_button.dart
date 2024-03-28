import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/app/bloc/cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        String buttonTitle = 'login'.tr();
        Function onPressed = () => context.pushNamed('login');

        if (state is AuthCubitInitial && state.isLoggedIn) {
          buttonTitle = 'profile'.tr();
          onPressed = () => context.pushNamed('profile');
        }

        return TextButton(
          onPressed: () => onPressed(),
          child: Text(buttonTitle),
        );
      },
    );
  }
}
