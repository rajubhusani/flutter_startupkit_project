import 'package:flutter/material.dart';
import 'package:flutter_template_project/src/blocs/counter_bloc.dart';
import 'package:flutter_template_project/src/common/utils/app_localization.dart';
import 'package:provider/provider.dart';

class Decrement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context);
    return RaisedButton.icon(
      onPressed: () => {counterBloc.decrementClick()},
      icon: Icon(Icons.remove),
      label: Text(AppLocalizations.of(context).translate("remove_txt")),
    );
  }
}
