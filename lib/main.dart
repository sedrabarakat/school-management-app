import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:school_app/BlocObserver.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/auth_cubit.dart';
import 'package:school_app/cubit/home_cubit.dart';
import 'package:school_app/network/local/cash_helper.dart';
import 'package:school_app/network/remote/dio_helper.dart';
import 'package:school_app/routes/app_router.dart';
import 'package:school_app/theme/app_theme.dart';
import 'package:school_app/theme/colors.dart';
import 'cubit/add_homework_cubit/add_homework_cubit.dart';
import 'cubit/articles/articles_cubit.dart';
import 'cubit/chat/chat/chat_cubit.dart';
import 'cubit/chat/chat_list/chat_list_cubit.dart';
import 'cubit/onboarding_screens/onboarding_cubit.dart';
import 'cubit/schedule/schedule_cubit.dart';
import 'firebase_api.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  //await FirebaseApi().initNotifications();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  isonboarding = CacheHelper.getData(key: 'isonboarding') ?? false;

  token = CacheHelper.getData(key: 'token');

  user_id = CacheHelper.getData(key: 'user_id');

  isteacher = CacheHelper.getData(key: 'isteacher');

  isparent = CacheHelper.getData(key: 'isparent');

  print('onboarding=${isonboarding}');
  print('fcmToken=$fcmToken');
  print('token=$token');
  print('user_id=$user_id');
  print('isteacher=$isteacher');
  print('isparent=$isparent');

  //The color of the status bar and system navigation bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => HomeCubit()),
        BlocProvider(create: (BuildContext context) => ArticlesCubit(ScrollController())),
        BlocProvider(create: (BuildContext context) => OnboardingCubit()),
        BlocProvider(create: (BuildContext context) => Add_homework_cubit()..get_teacher_classes()..get_teacher_subject()


        ),

        BlocProvider(create: (BuildContext context) => Chat_List_Cubit()..get_Chat_List()),
        BlocProvider(create: (BuildContext context) => Chat_cubit()),


      ],
      child: ScreenUtilInit(
        designSize: const Size(834, 400),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            scrollBehavior: MyBehavior(),
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            title: 'School App',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home:
            AnimatedSplashScreen.withScreenRouteFunction(
              splash: 'assets/home/logo.png',
              //animationDuration: Duration(seconds: 7),
              splashIconSize: 600,
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,

              backgroundColor: backgroundColor,
              screenRouteFunction: () async {

                if (token == null) {
                  return '/init';
                }

                return '/home';
              },
            ),
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
