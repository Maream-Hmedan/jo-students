import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/theme/theme.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/theme/theme_controller.dart';

Future<void> _saveSelectedItem() async {
  General.savePrefInt(ConstantValues.selectedIndexKey, 0);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    Get.put(ThemeToggleController());
    runApp(const MyApp());
  });
  _saveSelectedItem();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return OKToast(
        child: GetMaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              boldText: false,
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          ),
          title: 'E_Learning Flutter App',
          debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home:  const SplashScreen(),
        ),
      );
    });
  }
}
