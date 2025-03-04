import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/bloc/blocs.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/config/router/app_router.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorNotifire()),
      ],
      child: const MyApp(),
    )
  );
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Blocs.blocsProviders, 
      child: Builder(builder: (context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: ThemeData(
            fontFamily: 'SofiaRegular',
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryLightColor,
              primary: AppColors.primaryDarkColor,
              secondary: AppColors.accentColor,
              tertiary: AppColors.primaryColor,
              surface: AppColors.bgColor,
              inverseSurface: AppColors.greyColor,
            ),
            useMaterial3: true,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            dividerColor: Colors.transparent,
          ),
        );  
      }),
    );
    
  }
}