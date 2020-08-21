import 'dart:async';

import 'package:flutter_device_details/flutter_device_details.dart';
import 'package:flutter_template_project/src/blocs/bloc.dart';

class SampleBloc extends Bloc {
  final _controller = StreamController<dynamic>.broadcast();

  Stream<dynamic> get sampleStream => _controller.stream;

  void fabClick() {
    DeviceDetails.fromPlatform
        .then((value) => _controller.sink.add("App Name::: "+value.appName));
  }
}
