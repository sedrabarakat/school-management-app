
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/screens/absence.dart';
import 'package:school_app/ui/screens/articles.dart';
import 'package:school_app/ui/screens/chat/chat.dart';
import 'package:school_app/ui/screens/articles/all_articles.dart';
import 'package:school_app/ui/screens/articles/my_articles.dart';
import 'package:school_app/ui/screens/articles/post_articles.dart';
import 'package:school_app/ui/screens/chat.dart';
import 'package:school_app/ui/screens/contact_us.dart';
import 'package:school_app/ui/screens/course.dart';
import 'package:school_app/ui/screens/drawer.dart';
import 'package:school_app/ui/screens/grades.dart';
import 'package:school_app/ui/screens/home.dart';
import 'package:school_app/ui/screens/homework.dart';
import 'package:school_app/ui/screens/info.dart';
import 'package:school_app/ui/screens/library.dart';
import 'package:school_app/ui/screens/login.dart';
import 'package:school_app/ui/screens/marks/marks.dart';
import 'package:school_app/ui/screens/notifications.dart';
import 'package:school_app/ui/screens/onboarding/onboarding_screen.dart';
import 'package:school_app/ui/screens/profiles/student_profile.dart';
import 'package:school_app/ui/screens/profiles/teacher_profile.dart';
import 'package:school_app/ui/screens/schedule.dart';
import 'package:school_app/ui/screens/setting.dart';
import 'package:school_app/ui/screens/tution_fees.dart';

import '../ui/screens/chat/chat_list.dart';


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
          builder: (_) => Scaffold(backgroundColor: shadow,
            body:
             Stack(
              children: [
               DrawerScreen(),
                HomePage(),
              ],
            ),
          ),
        );
        break;
        case '/library':
        return MaterialPageRoute(
          builder: (_) => Library(),
        );
        break;
        case '/homework':
        return MaterialPageRoute(
          builder: (_) => HomeworkScreen(),
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
          builder: (_) => SchesuleScreen(),
        );
        break;
        case '/absences':
        return MaterialPageRoute(
          builder: (_) => AbsencesScreen(),
        );
        break;
        case '/course':
        return MaterialPageRoute(
          builder: (_) => CourseScreen(),
        );
        break;
         case '/chat':
        return MaterialPageRoute(
          builder: (_) => Chat(),
        );
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
        case '/contactus':
        return MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
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
