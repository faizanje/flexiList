import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/controllers/app_controller.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/models/todo_item.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/screens/bottom_nav_screen.dart';
import 'package:noteapp/screens/onboarding_screen.dart';
import 'package:noteapp/screens/select_country_screen.dart';
import 'package:noteapp/services/application.dart';
import 'package:noteapp/utils/themes.dart';
import 'package:path_provider/path_provider.dart';

import 'constant/constant.dart';
import 'language/LocaleString.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(TASKSTATUSAdapter());
  Hive.registerAdapter(TodoItemModelAdapter());
  Hive.registerAdapter(HomeTaskItemModelAdapter());
  await Hive.openBox<HomeTaskItemModel>(kBoxTodo);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        // navigatorKey: Application.materialKey,
        // GlobalKey()
        translations: LocaleString(),
        locale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        color: Colors.white,
        home: GetBuilder<AppController>(
          init: AppController(),
          assignId: true,
          builder: (logic) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                // appBar: AppBar(
                //   title: Text("Note App"),
                //   backgroundColor: kNavbarColor,
                // ),
                // body: ArchiveScreen(),
                // body: BottomNavScreen(),
                // body: OnBordingScreen(),
                // body: BottomNavScreen(),
                body: SelectCountryScreen(),
                // body: AddTaskScreen(),
                // body: SideBarLayout(),
              ),
            );
          },
        ),
      ),
    );
  }
}
