import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/services/notifications/notification_services.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/local/cache_helper.dart';
import 'package:todo_list_app/features/add_task/presentation/pages/add_task_page.dart';
import 'package:todo_list_app/features/board/presentation/pages/board_page.dart';
import 'package:todo_list_app/features/board/presentation/widgets/all_tasks.dart';
import 'package:todo_list_app/features/board/presentation/widgets/completed_tasks.dart';
import 'package:todo_list_app/features/board/presentation/widgets/favorite_tasks.dart';
import 'package:todo_list_app/features/board/presentation/widgets/uncompleted_tasks.dart';
import 'package:todo_list_app/features/edit_task/presentation/pages/edit_task_page.dart';
import 'package:todo_list_app/features/schedule/presentation/pages/schedule_page.dart';
import 'package:todo_list_app/features/splash_page/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotificationsHelper().initialAwesomeNotifications();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()
        ..initialDatabase()
        ..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "TodoList",
            // light theme
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              // primarySwatch: Colors.deepOrange,
              fontFamily: 'Quicksand',
              tabBarTheme: const TabBarTheme(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.label,
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0.5,
              ),
            ),
            // dark theme
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0xff333739),
              // primarySwatch: Colors.deepOrange,
              fontFamily: 'Quicksand',
              tabBarTheme: const TabBarTheme(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.label,
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xff333739),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: Color(0xff333739),
                titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                elevation: 0.5,
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/splash_page',
            routes: {
              '/splash_page': (context) => const SplashPage(),
              '/board_page': (context) => const BoardPage(),
              '/schedule_page': (context) => const SchedulePage(),
              '/add_task_page': (context) => const AddTaskPage(),
              '/edit_task_page': (context) => const EditTaskPage(),
              '/all_tasks': (context) => const AllTasksPage(),
              '/completed_tasks': (context) => const CompletedTasksPage(),
              '/favorite_tasks': (context) => const FavoriteTasksPage(),
              '/uncompleted_tasks': (context) => const UncompletedTasksPage(),
            },
          );
        },
      ),
    );
  }
}
