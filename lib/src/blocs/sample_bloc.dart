import 'dart:async';

import 'package:flutter_template_project/src/blocs/bloc.dart';
import 'package:flutter_template_project/src/service/stores/APIStore.dart';

class SampleBloc extends Bloc {
  final _controller = StreamController<dynamic>.broadcast();
  final _store = APIStore();

  Stream<dynamic> get sampleStream => _controller.stream;

  void makeRequest() {
    _store.sampleService().then((value) => {_controller.sink.add(value)});
  }
}
