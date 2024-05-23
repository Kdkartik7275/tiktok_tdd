// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tiktok_tdd/core/common/bloc/pick_image/pick_image_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/circular_container.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/navaigation_menu.dart';
import 'package:tiktok_tdd/src/authentication/presentation/bloc/auth_bloc.dart';

class AddBioScreen extends StatefulWidget {
  final String uid;
  const AddBioScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<AddBioScreen> createState() => _AddBioScreenState();
}

class _AddBioScreenState extends State<AddBioScreen> {
  XFile? image;
  final bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthBloc, AuthState>(
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
          return Scaffold(
            appBar: TAppBar(
              title: const Text("Add Your Bio"),
              actions: [
                IconButton(
                    onPressed: () {
                      if (image != null) {
                        context.read<AuthBloc>().add(OnAddUserProfileInfo(
                            bio: bio.text, profile: image!, uid: widget.uid));
                      }
                    },
                    icon: Icon(
                      Icons.done,
                      color: TColors.lightBlue,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwSections),
                    TCircularContainer(
                      height: 100,
                      width: 100,
                      backgroundColor: TColors.white,
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    backgroundColor: TColors.background,
                                    title: const Text('Choose an Option'),
                                    children: [
                                      SimpleDialogOption(
                                        onPressed: () {
                                          context
                                              .read<PickImageBloc>()
                                              .add(PickFromGallery());
                                        },
                                        child:
                                            const Text("Choose from Gallery"),
                                      ),
                                      // Padding(padding: EdgeInsets.all(8.0)),
                                      SimpleDialogOption(
                                        onPressed: () {
                                          context
                                              .read<PickImageBloc>()
                                              .add(PickFromCamera());
                                        },
                                        child: const Text("Take a Picture"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: BlocConsumer<PickImageBloc, PickImageState>(
                              listener: (context, state) {
                                if (state is PickImageFile) {
                                  TNavigators.navigatePop(context);
                                  image = state.image;
                                }
                              },
                              builder: (context, state) {
                                if (state is PickImageFile) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        TSizes.borderRadiusXl),
                                    child: Image(
                                        image:
                                            FileImage(File(state.image!.path))),
                                  );
                                }
                                return const Icon(Icons.camera_alt);
                              },
                            )),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TextFormField(
                      maxLines: null,
                      controller: bio,
                      decoration: const InputDecoration(
                        hintText: "Add Bio",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
