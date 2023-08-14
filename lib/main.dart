import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/BlocObserver.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/auth_cubit.dart';
import 'package:school_app/cubit/chat/chat/chat_cubit.dart';
import 'package:school_app/cubit/chat/chat_list/chat_list_cubit.dart';
import 'package:school_app/cubit/home_cubit.dart';
import 'package:school_app/network/local/cash_helper.dart';
import 'package:school_app/network/remote/dio_helper.dart';
import 'package:school_app/routes/app_router.dart';
import 'package:school_app/theme/app_theme.dart';
import 'cubit/add_homework_cubit/add_homework_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();


  print('token=$token');
  print('user_id=$user_id');

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
         BlocProvider(create: (BuildContext context) => Add_homework_cubit()),
         BlocProvider(create: (BuildContext context) => Chat_List_Cubit()..get_Chat_List()),
        BlocProvider(create: (BuildContext context) => Chat_cubit()),
      ],
      child: MaterialApp(
        title: 'School App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        // initialRoute: token!=null?'/home':'/login',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}


