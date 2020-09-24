# flutter_startupkit_project

A new Flutter Startup Kit project.

## Contents

This startup kit explaining about the following features,

   *  BLOC Pattern
   *  State Provider Pattern
   *  Router - Navigations
   *  Service Component
   *  Localization support
   *  Build configurations
   *  DeviceDetails

### BLOC Pattern

The BLoC Pattern is really just an interface around Dart streams:

Your First BLoC
Create a new directory in the lib folder named BLoC. This will be the home for all your BLoC classes.
Create a new file in that directory called bloc.dart and add the following:
```
abstract class Bloc extends ChangeNotifier{
  void dispose();
}
```
In the bloc directory, create a new file, sample_bloc.dart, and add the following code:
```
class SampleBloc extends Bloc {
  final _controller = StreamController<dynamic>.broadcast();

  Stream<dynamic> get sampleStream => _controller.stream;

  void btnClick() {
    DeviceDetails.fromPlatform
        .then((value) => _controller.sink.add("App Name::: "+value.appName));
  }
}
```
In the home_page.dart file, add the following code for listening the data updates from the bloc:
```
 void listenStream() {
    _subscription = _bloc.sampleStream.asBroadcastStream().listen((event) {
      setState(() {
        text = event as String;
      });
    });
  }
  ```
  
### State Provider

In the bloc directory, create a new file, counter_bloc.dart and add the following code:
```
class CounterBloc extends Bloc {
  int _counter = 0;
  int get counter => _counter;

  set counter(int val) {
    _counter = val;
    notifyListeners();
  }

  void incrementClick() {
    _counter++;
    notifyListeners(); //Notify the consumers
  }

  void decrementClick() {
    _counter--;
    notifyListeners(); //Notify the consumers
  }
}
```
In home_page.dart, add the following code for consuming the data updated by the CounterBloc using change notifier listener,
```
final CounterBloc _counterBloc = Provider.of<CounterBloc>(context);
Text(_counterBloc.counter.toString()),
```
And add the below code in the main.dart to define the multi provider widgets to main tree widget.
```
MultiProvider(
   providers: [
       ChangeNotifierProvider<CounterBloc>.value(value: CounterBloc())
    ])
```

### Router - Navigation

Add the below code in the main.dart for providing the routing to the application.
```
 onGenerateRoute: Router().generateRoute
```
Add the new file router.dart in "common/helper" folder for defining the different routing pages with routing condition.
```
Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "home":
        return getRouter(HomePage(title: settings.arguments as String));

      default:
        return getRouter(SplashPage());
    }
  }
```

### Service Component

This service component explains about how the application can communicate with backend REST API's, handling the server response and returning the result back to the Bloc.
It has Service Invoker, Service Provider & APIStore. APIStore contains the services information which can invoke from the invoker, below is the sample request.

```
Future<dynamic> sampleService() async =>
      await _invoker.makeRequest(SAMPLE, REQUESTTYPE.GET);
```
Service Invoker responsible for handling the exceptions NETWORK_ERROR, CONNECTION_TIMEOUT, FORMAT_EXCEPTION.

### Localization support

In flutter under assets folder create "locale/en.json" file for the english support and you can add other languages json files with locale short code with .json.

And create a folder "common/utils" and file "app_localization.dart" to pick the specific translation file dynamically based on the device locale.

Add the following code in main.dart file to configure the localization support for the application,
```
supportedLocales: [Locale('en', 'US')],
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
 ```
Use the following code to get the proper locale string from the localizations,
```
AppLocalizations.of(context).translate("add_txt");
```

### Build Configurations

When the application is required to deliver in DEV/SIT/UAT & PROD environments, it is difficult to manage the environment configurations like server endpoint, server certificates and other specific env details. So this build configuration will help in managing all in one place.

Crate a new file "app_config.dart" under common folder, which consists of ENVIRONMENT enum class and other config details.
Create different main.dart files for the specific environment (main_sit.dart, main_prod.dart) which will internally invoke the main.dart file.

Add the below code in main_prod.dart file,
```
AppConfig.setEnvironment(Environment.PROD);
launchApp(); //This will invoke the main.dart file main function
```
To build the Android application for specific environment using Command line tool,
```
flutter build apk lib/main_prod.dart
```

### DeviceDetails

Flutter plugin project for the Native device essentials.

Supported for both Android & iOS 
Device Info
Package Info
Telephony Info
Ip Info
Jaibreak/Root detection

