
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/ui/screens/absence.dart';
import 'package:school_app/ui/screens/articles.dart';
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
import 'package:school_app/ui/screens/schedule.dart';
import 'package:school_app/ui/screens/setting.dart';
import 'package:school_app/ui/screens/tution_fees.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
        case '/home':
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Stack(
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
          builder: (_) => LibrarySreen(),
        );
        break;
        case '/homework':
        return MaterialPageRoute(
          builder: (_) => HomeworkScreen(),
        );
        break;
        case '/grades':
        return MaterialPageRoute(
          builder: (_) => GradesScreen(),
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
          builder: (_) => ChatScreen(),
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
      
        

      default:
        return null;
    }
  }
}
