// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template_project/src/blocs/sample_bloc.dart';
import 'package:flutter_template_project/src/common/app_config.dart';
import 'package:flutter_template_project/src/models/error_handler.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template_project/main.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const _channel = MethodChannel("plugins.flutter.io/connectivity");

  setUp(() async {
    _channel.setMockMethodCallHandler((MethodCall methodCall) async => 'wifi');
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test("Service failed test case", () async {
    AppConfig.setEnvironment(Environment.DEV);
    final bloc = SampleBloc();
    bloc.makeRequest();
    bloc.sampleStream.asBroadcastStream().listen(expectAsync1((value) {
          print((value as ErrorHandler).message);
          expect(value, isA<ErrorHandler>());
        }));
  });
}

class MockClient extends Mock implements http.Client {}
