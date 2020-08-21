import 'package:flutter_template_project/src/blocs/bloc.dart';

class CounterBloc extends Bloc {
  int _counter = 0;
  int get counter => _counter;

  set counter(int val) {
    _counter = val;
    notifyListeners();
  }

  void incrementClick() {
    _counter++;
    notifyListeners(); //Notify the widget
  }

  void decrementClick() {
    _counter--;
    notifyListeners(); //Notify the widget
  }
}
