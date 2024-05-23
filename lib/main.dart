import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/bloc/pick_image/pick_image_bloc.dart';
import 'package:tiktok_tdd/core/common/cubits/reel_user/reel_user_cubit.dart';
import 'package:tiktok_tdd/core/common/cubits/single_user/single_user_cubit.dart';
import 'package:tiktok_tdd/core/utils/constants/texts.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/theme/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tiktok_tdd/init_dependencies.dart';
import 'package:tiktok_tdd/navaigation_menu.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/app/presentation/pages/splash_screen.dart';
import 'package:tiktok_tdd/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:tiktok_tdd/src/chat/presentation/blocs/chatroom/chatroom_bloc.dart';
import 'package:tiktok_tdd/src/chat/presentation/blocs/messages/messages_bloc.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/comments/comments_bloc.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/reels/reels_bloc.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/upload/upload_reel_bloc.dart';
import 'package:tiktok_tdd/src/search/presentation/bloc/search_user_bloc.dart';
import 'firebase_options.dart';
import 'package:tiktok_tdd/src/app/presentation/pages/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => sl<AuthBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<AppUserCubit>(),
    ),
    BlocProvider(
      create: (_) => sl<PickImageBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<ReelsBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<UploadReelBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<CommentsBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<SearchUserBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<SingleUserCubit>(),
    ),
    BlocProvider(
      create: (_) => sl<ReelUserCubit>(),
    ),
    BlocProvider(
      create: (_) => sl<ChatroomBloc>(),
    ),
    BlocProvider(
      create: (_) => sl<MessagesBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TTexts.appName,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const InitialScreen(),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(OnGetCurrenUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          return TNavigators.offALL(context, const NavigationMenu());
        } else if (state is UnAuthenticated) {
          return TNavigators.offALL(context, const OnBoardingPage());
        }
      },
      child: const SplashScreen(),
    );
  }
}
