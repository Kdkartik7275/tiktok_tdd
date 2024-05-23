import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/buttons/elevated_button.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/images.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/core/utils/validators/validation.dart';
import 'package:tiktok_tdd/navaigation_menu.dart';
import 'package:tiktok_tdd/src/authentication/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return TSnackBar.showErrorSnackBar(
                  context: context, message: state.error);
            }
            if (state is Authenticated) {
              return TNavigators.offALL(context, const NavigationMenu());
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(TImages.logo),
                      height: 150,
                    ),
                    Text(
                      "Welcome to Tik Tok",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              validator: (value) =>
                                  TValidator.validateEmail(value),
                              decoration: const InputDecoration(
                                  hintText: "Enter your Email"),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TextFormField(
                              controller: password,
                              validator: (value) =>
                                  TValidator.validatePassword(value),
                              decoration: const InputDecoration(
                                  hintText: "Enter your Password"),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text("Forgot Password?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(color: TColors.lightRed)),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthLogin(
                                    email: email.text.trim(),
                                    password: password.text,
                                    formKey: formKey));
                              },
                              width: 150,
                              text: state is AuthLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: TColors.white,
                                      ),
                                    )
                                  : Text('Log In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
