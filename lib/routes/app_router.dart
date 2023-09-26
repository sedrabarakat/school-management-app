import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/ui/screens/absence.dart';
import 'package:school_app/ui/screens/chat/chat.dart';
import 'package:school_app/ui/screens/articles/all_articles.dart';
import 'package:school_app/ui/screens/articles/my_articles.dart';
import 'package:school_app/ui/screens/articles/post_articles.dart';
import 'package:school_app/ui/screens/courses/courses.dart';
import 'package:school_app/ui/screens/courses/my_courses.dart';
import 'package:school_app/ui/screens/home.dart';
import 'package:school_app/ui/screens/homework_student.dart';
import 'package:school_app/ui/screens/info.dart';
import 'package:school_app/ui/screens/library.dart';
import 'package:school_app/ui/screens/login.dart';
import 'package:school_app/ui/screens/marks/marks.dart';
import 'package:school_app/ui/screens/notifications.dart';
import 'package:school_app/ui/screens/onboarding/onboarding_screen.dart';
import 'package:school_app/ui/screens/profiles/student_profile.dart';
import 'package:school_app/ui/screens/profiles/teacher_profile.dart';
import 'package:school_app/ui/screens/schedule.dart';
import 'package:school_app/ui/screens/settings.dart';
import 'package:school_app/ui/screens/tution_fees.dart';
import '../cubit/chat/chat/chat_cubit.dart';
import '../network/local/cash_helper.dart';
import '../ui/screens/chat/chat_list.dart';
import '../ui/screens/teacher_homework.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/init':
        return MaterialPageRoute(
          builder: (_) => isonboarding ? LoginScreen() : OnboardingScreen(),
        );
        break;
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
        case '/home':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
        break;
        case '/library':
        return MaterialPageRoute(
          builder: (_) => Library(),
        );
        break;
        case '/homework_teacher':
        return MaterialPageRoute(
          builder: (_) => Teacher_Homework(),
        );
        case '/homework_Student':
        return MaterialPageRoute(
          builder: (_) => Homework_student(),
        );
        break;
        case '/marks':
        return MaterialPageRoute(
          builder: (_) => MarksScreen(),
        );
        break;
        case '/articles':
        return MaterialPageRoute(
          builder: (_) => ArticlesScreen(),
        );
        break;
        case '/schedule':
        return MaterialPageRoute(
          builder: (_) => Schedule_Screen(),
        );
        break;
        case '/absences':
        return MaterialPageRoute(
          builder: (_) => AbsencesScreen(),
        );
        break;
        case '/course':
        return MaterialPageRoute(
          builder: (_) => CoursesScreen(),
        );
        break;
        case '/my_courses':
        return MaterialPageRoute(
          builder: (_) => MyCoursesScreen(),
        );
         case '/chat':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: Chat_cubit()..getMessages(id:CacheHelper.getData(key: 'reciever_id')),
              child: Chat(),
            ));
        break;
         case '/chat_list':
        return MaterialPageRoute(
          builder: (_) => Chat_List(),
        );
        break;
        case '/tuitionfees':
        return MaterialPageRoute(
          builder: (_) => TutionfeesScreen(),
        );
         break;

        case '/info':
        return MaterialPageRoute(
          builder: (_) => InfoScreen(),
        );
        break;
        case '/settings':
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
        break;
      case '/send_article':
        return MaterialPageRoute(
          builder: (_) => SendArticle(),
        );
        break;
      case '/my_articles':
        return MaterialPageRoute(
          builder: (_) => MyArticles(),
        );
        break;
      case '/notifications':
        return MaterialPageRoute(
          builder: (_) => NotificationsScreen(),
        );
        break;

      case '/onboarding':
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );
        break;
      case '/student_profile':
        return MaterialPageRoute(
          builder: (_) => StudentProfile(),
        );
        break;
      case '/teacher_profile':
        return MaterialPageRoute(
          builder: (_) => TeacherProfile(),
        );
        break;

        

      default:
        return null;
    }
  }
}
