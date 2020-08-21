import 'package:flutter/material.dart';
import 'package:flutter_template_project/src/blocs/counter_bloc.dart';
import 'package:provider/provider.dart';

class Increment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context);
    return RaisedButton.icon(onPressed: () => counterBloc.incrementClick(),
    icon: Icon(Icons.add),
    label: Text("Add"),
    );
  }
}
