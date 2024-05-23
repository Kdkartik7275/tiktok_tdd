part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initReels();
  _initUser();
  _initSearch();
  _initChats();

// FIREBASE

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  sl.registerFactory(() => InternetConnection());

  // USECASES
  sl.registerFactory(() => GetCurrentUserData(repository: sl()));

  // APP
  sl.registerFactory(() => AppUserCubit(currentUserData: sl()));

// CORE

  sl.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(sl()));
  sl.registerLazySingleton(() => TFunctions());

  // CORE BLOCS
  sl.registerFactory(() => PickImageBloc(sl()));

  // CORE CUBITS
  sl.registerFactory(() => SingleUserCubit(userData: sl(), followUser: sl()));
  sl.registerFactory(() => ReelUserCubit(userData: sl(), followUser: sl()));
}

_initAuth() {
  // DATASOURCE
  sl
    ..registerFactory<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImpl(auth: sl(), firestore: sl(), storage: sl()))

    // REPOSITORY
    ..registerFactory<AuthRepository>(() =>
        AuthRepositoryImpl(connectionChecker: sl(), remoteDataSource: sl()))
    // USECASES
    ..registerFactory(() => GetCurrentUser(repository: sl()))
    ..registerFactory(() => LoginUser(repository: sl()))
    ..registerFactory(() => RegisterUser(repository: sl()))
    ..registerFactory(() => LogoutUser(repository: sl()))
    ..registerFactory(() => UpdateSingleField(repository: sl()))
    ..registerFactory(() => UploadUserProfile(repository: sl()))

    // BLOC
    ..registerFactory(() => AuthBloc(
          currentUser: sl(),
          loginUser: sl(),
          registerUser: sl(),
          logoutUser: sl(),
          updateSingleField: sl(),
          userProfile: sl(),
        ));
}

_initReels() {
  // DATASOURCE
  sl
    ..registerFactory<ReelDataSource>(() =>
        ReelDataSourceImpl(firestore: sl(), storage: sl(), functions: sl()))

    // REPOSITORY
    ..registerFactory<ReelRepository>(
        () => ReelRepositoryImpl(connectionChecker: sl(), reelDataSource: sl()))
    // USECASES
    ..registerFactory(() => UploadReel(repository: sl()))
    ..registerFactory(() => AddComment(repository: sl()))
    ..registerFactory(() => FetchComments(repository: sl()))
    ..registerFactory(() => FetchReels(repository: sl()))
    ..registerFactory(() => LikeReel(repository: sl()))
    ..registerFactory(() => UploadedReelUser(repository: sl()))

    // BLOC
    ..registerFactory(
      () => UploadReelBloc(
        uploadReel: sl(),
      ),
    )
    ..registerFactory(
      () => ReelsBloc(fetchReels: sl(), likeReel: sl()),
    )
    ..registerFactory(
      () => CommentsBloc(addComment: sl(), fetchComments: sl()),
    );
}

_initChats() {
  // DATASOURCE
  sl
    ..registerFactory<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(
        firestore: sl(), functions: sl(), storage: sl()))

    // REPOSITORY
    ..registerFactory<ChatRepository>(() =>
        ChatRepositoryImpl(connectionChecker: sl(), remoteDataSource: sl()))
    // USECASES
    ..registerFactory(() => CreateChatRoom(repository: sl()))
    ..registerFactory(() => FetchChatRooms(repository: sl()))
    ..registerFactory(() => ListenToMessages(repository: sl()))
    ..registerFactory(() => SendTextMessage(repository: sl()))
    ..registerFactory(() => SendFileMessage(repository: sl()))

    // BLOC
    ..registerFactory(
      () => ChatroomBloc(createChatRoom: sl(), fetchChatRooms: sl()),
    )
    ..registerFactory(
      () => MessagesBloc(
          listenToMessages: sl(),
          sendTextMessage: sl(),
          fileMessage: sl(),
          functions: sl()),
    );
}

_initSearch() {
  // DATASOURCE
  sl
    ..registerFactory<SearchUserDataSource>(
        () => SearchUserDataSourceImpl(firestore: sl()))

    // REPOSITORY
    ..registerFactory<SearchRepository>(() =>
        SearchUserRepositoryImpl(connectionChecker: sl(), dataSource: sl()))
    // USECASES
    ..registerFactory(() => SearchUser(repository: sl()))

    // BLOC
    ..registerFactory(
      () => SearchUserBloc(
        searchUser: sl(),
      ),
    );
}

_initUser() {
  // DATASOURCE
  sl
        ..registerFactory<UserRemoteDataSource>(
            () => UserRemoteDataSourceImpl(firestore: sl()))

        // REPOSITORY
        ..registerFactory<UserRepository>(() =>
            UserRepositoryImpl(connectionChecker: sl(), userDataSource: sl()))
        // USECASES
        ..registerFactory(() => FollowUser(repository: sl()))
        ..registerFactory(() => GetUserData(repository: sl()))

      // BLOC
      ;
}
