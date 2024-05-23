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
import 'package:tiktok_tdd/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:tiktok_tdd/src/authentication/presentation/pages/add_bio.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obsecure = true;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  toggleObsecure() {
    setState(() {
      obsecure = !obsecure;
    });
  }

  @override
  void dispose() {
    username.dispose();
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
            if (state is AuthUserProfile) {
              TNavigators.offALL(
                  context,
                  AddBioScreen(
                    uid: state.uid,
                  ));
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
                              controller: username,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      "Username", value),
                              decoration: const InputDecoration(
                                  hintText: "Enter your Username"),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
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
                              obscureText: obsecure,
                              validator: (value) =>
                                  TValidator.validatePassword(value),
                              decoration: InputDecoration(
                                  hintText: "Enter your Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () => toggleObsecure(),
                                    child: Icon(
                                      obsecure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: TColors.textGrey,
                                    ),
                                  )),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TElevatedButton(
                              onPressed: () => context.read<AuthBloc>().add(
                                  AuthSignUp(
                                      email: email.text,
                                      password: password.text,
                                      formKey: formKey,
                                      username: username.text)),
                              width: 150,
                              text: state is AuthLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text('Sign Up',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!),
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
