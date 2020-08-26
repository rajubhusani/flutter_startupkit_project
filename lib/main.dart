import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template_project/src/blocs/counter_bloc.dart';
import 'package:flutter_template_project/src/common/helpers/navigation_service.dart';
import 'package:flutter_template_project/src/common/helpers/router.dart';
import 'package:flutter_template_project/src/common/utils/app_localization.dart';
import 'package:provider/provider.dart';

void launchApp() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      //State provider pattern, declare the providers
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CounterBloc>.value(value: CounterBloc())
        ],
        child: MaterialApp(
          title: 'Flutter Template App',
          navigatorKey: NavigationService.navigationKey,
          supportedLocales: [Locale('en', 'US')], //Supported Locales
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              return supportedLocales.first;
            }
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: Router().generateRoute, //Providing the routing for the application
        ),
      );
}
