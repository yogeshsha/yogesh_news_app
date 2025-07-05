import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:newsapp/data/login_data/login_bloc/login_bloc.dart';
import 'package:newsapp/data/sign_up_data/domain/usecases/sign_up_usecase_interface.dart';
import 'package:newsapp/route_generator.dart';
import 'package:newsapp/utils/app.dart';
import 'package:newsapp/utils/app_localization.dart';
import 'package:newsapp/utils/dark_theme_provider.dart';
import 'package:newsapp/utils/language.dart';
import 'package:newsapp/utils/notification_service.dart';
import 'package:newsapp/utils/share_chat.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:uni_links/uni_links.dart';
import 'constants/app_constant.dart';
import 'constants/colors_constants.dart';
import 'data/breaking_news_data/breaking_bloc/breaking_bloc.dart';
import 'data/breaking_news_data/domain/usecases/breaking_usecase_interface.dart';
import 'data/breaking_news_data/repo/breaking_impl.dart';
import 'data/category_data/category_bloc/category_bloc.dart';
import 'data/category_data/domain/usecases/category_usecase_interface.dart';
import 'data/category_data/repo/category_impl.dart';
import 'data/complain_data/complain_bloc/complain_bloc.dart';
import 'data/complain_data/domain/usecases/complain_usecase_interface.dart';
import 'data/complain_data/repo/complain_impl.dart';
import 'data/detail_page_data/detail_bloc/detail_bloc.dart';
import 'data/detail_page_data/domain/usecases/detail_usecase_interface.dart';
import 'data/detail_page_data/repo/detail_impl.dart';
import 'data/favorite_data/domain/usecases/favorite_usecase_interface.dart';
import 'data/favorite_data/favorite_bloc/favorite_bloc.dart';
import 'data/favorite_data/repo/favorite_impl.dart';
import 'data/infinite_data/domain/usecases/infinite_usecase_interface.dart';
import 'data/infinite_data/infinite_bloc/infinite_bloc.dart';
import 'data/infinite_data/repo/infinite_impl.dart';
import 'data/like_data/domain/usecases/like_usecase_interface.dart';
import 'data/like_data/repo/like_impl.dart';
import 'data/login_data/domain/usecases/login_usecase_interface.dart';
import 'data/login_data/repo/login_impl.dart';
import 'data/notification_data/domain/useCases/notification_usecase_interface.dart';
import 'data/notification_data/notification_bloc/notification_bloc.dart';
import 'data/notification_data/repo/notification_impl.dart';
import 'data/session_data/domain/usecases/session_usecase_interface.dart';
import 'data/session_data/repo/session_impl.dart';
import 'data/session_data/session_bloc/session_bloc.dart';
import 'data/settings_data/domain/usecases/settings_usecase_interface.dart';
import 'data/settings_data/repo/settings_impl.dart';
import 'data/settings_data/settings_bloc/settings_bloc.dart';
import 'data/sign_up_data/repo/sign_up_impl.dart';
import 'data/sign_up_data/sign_up_bloc/sign_up_bloc.dart';
import 'data/splash_data/domain/usecases/splash_usecase_interface.dart';
import 'data/splash_data/repo/splash_impl.dart';
import 'data/splash_data/splash_bloc/splash_bloc.dart';
import 'data/subscription_data/domain/usecases/subscription_usecase_interface.dart';
import 'data/subscription_data/repo/subscription_impl.dart';
import 'data/subscription_data/subscription_bloc/subscription_bloc.dart';
import 'data/terms_and_condition_data/domain/usecases/terms_usecase_interface.dart';
import 'data/terms_and_condition_data/repo/terms_impl.dart';
import 'data/terms_and_condition_data/terms_bloc/terms_bloc.dart';

LocalNotificationService localNotificationService = LocalNotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if(checkIsWeb()){
  //   // AdManagerWeb.init();
  // }else {
  await Firebase.initializeApp();
  // }
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  settingsForNotification();
  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;

  const MyApp({super.key, required this.appLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();
// AppLanguage appLanguage = AppLanguage();

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  List<SingleChildWidget> providers = [];

  late SplashUseCase splashUseCase;
  late NotificationUseCase notificationUseCase;
  late SessionUseCase sessionUseCase;
  late SettingsUseCase settingsUseCase;
  late CategoryUseCase categoryUseCase;
  late DetailUseCase detailUseCase;
  late TermsUseCase termsUseCase;
  late SignUpUseCase signUpUseCase;
  late LoginUseCase loginUseCase;
  late ComplainUseCase complainUseCase;
  late InfiniteUseCase infiniteUseCase;
  late BreakingUseCase breakingUseCase;
  late SubscriptionUseCase subscriptionUseCase;
  late LikeUseCase likeUseCase;
  late FavoriteUseCase favoriteUseCase;

  @override
  void initState() {

    setData(context);

    super.initState();
  }

  void setData(BuildContext context) async {
    setBlocProvider(context);
    getCurrentAppTheme();
    await initSessionHelper(context);
    initUniLinks();
  }

  Future<void> initSessionHelper(BuildContext context) async {
    await SessionHelper.getInstance(context);
    if(context.mounted){
      AppLanguage appLanguage = AppLanguage();
      SessionHelper().put(SessionHelper.languageCode, await appLanguage.fetchLocale());
    }
  }

  void initUniLinks() async {
    await getInitialUri().then((uri) => Future.delayed(const Duration(seconds: 2))
        .then((value) => ShareChat.handleDeeplink(uri)));
    linkStream.listen((uri) {
      AppHelper.myPrint("------- Inside Link Stream Url ----- $uri");
      ShareChat.handleDeeplink(Uri.parse(uri ?? ""));
    });
  }

  void setBlocProvider(BuildContext context) {
    notificationUseCase = NotificationUseCase(notificationRepository: NotificationRepositoryImpl());
    splashUseCase = SplashUseCase(splashRepository: SplashRepositoryImpl());
    sessionUseCase = SessionUseCase(sessionRepository: SessionRepositoryImpl());
    settingsUseCase =
        SettingsUseCase(settingsRepository: SettingsRepositoryImpl());
    categoryUseCase =
        CategoryUseCase(categoryRepository: CategoryRepositoryImpl());
    detailUseCase = DetailUseCase(detailRepository: DetailRepositoryImpl());
    termsUseCase = TermsUseCase(termsRepository: TermsRepositoryImpl());
    signUpUseCase = SignUpUseCase(signUpRepository: SignUpRepositoryImpl());
    loginUseCase = LoginUseCase(loginRepository: LoginRepositoryImpl());
    complainUseCase =
        ComplainUseCase(complainRepository: ComplainRepositoryImpl());
    infiniteUseCase =
        InfiniteUseCase(infiniteRepository: InfiniteRepositoryImpl());
    breakingUseCase =
        BreakingUseCase(breakingRepository: BreakingRepositoryImpl());
    subscriptionUseCase = SubscriptionUseCase(
        subscriptionRepository: SubscriptionRepositoryImpl());
    likeUseCase = LikeUseCase(likeRepository: LikeRepositoryImpl());
    favoriteUseCase =
        FavoriteUseCase(favoriteRepository: FavoriteRepositoryImpl());
    providers = [
      BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(notificationUseCase: notificationUseCase)),
      BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(categoryUseCase: categoryUseCase)),
      BlocProvider<SessionBloc>(
          create: (context) => SessionBloc(sessionUseCase: sessionUseCase)),
      BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(splashUseCase: splashUseCase)),
      BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(settingsUseCase: settingsUseCase)),
      BlocProvider<DetailBloc>(
          create: (context) => DetailBloc(detailUseCase: detailUseCase)),
      BlocProvider<TermsBloc>(
          create: (context) => TermsBloc(termsUseCase: termsUseCase)),
      BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(signUpUseCase: signUpUseCase)),
      BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginUseCase: loginUseCase)),
      BlocProvider<ComplainBloc>(
          create: (context) => ComplainBloc(complainUseCase: complainUseCase)),
      BlocProvider<InfiniteBloc>(
          create: (context) => InfiniteBloc(infiniteUseCase: infiniteUseCase)),
      BlocProvider<BreakingBloc>(
          create: (context) => BreakingBloc(breakingUseCase: breakingUseCase)
            ..add(FetchBreaking())),
      BlocProvider<SubscriptionBloc>(
          create: (context) =>
              SubscriptionBloc(subscriptionUseCase: subscriptionUseCase)),
      BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(favoriteUseCase: favoriteUseCase)),
    ];
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return MultiBlocProvider(
          providers: providers,
          child: ChangeNotifierProvider<AppLanguage>(
              create: (_) => widget.appLanguage,
              child: Consumer<AppLanguage>(builder: (context, model, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  initialRoute: '/splashScreen',
                  locale: model.appLocal,
                  supportedLocales: const [
                    Locale('en', "US"),
                    Locale('hi', "IN"),
                  ],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  onGenerateRoute: RouteGenerator.generateRoute,
                );
              })));
    }));
  }
}
