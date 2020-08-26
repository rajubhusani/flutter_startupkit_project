import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_device_details/flutter_device_details.dart';
import 'package:flutter_template_project/src/blocs/counter_bloc.dart';
import 'package:flutter_template_project/src/blocs/sample_bloc.dart';
import 'package:flutter_template_project/src/pages/widgets/decrement.dart';
import 'package:flutter_template_project/src/pages/widgets/increment.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription _subscription;
  String text = "";
  SampleBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SampleBloc();
    listenStream(_bloc.sampleStream);

    DeviceDetails.fromPlatform.then(
        (value) => "App Name::: '${value.appName}'"); // Device Details Plugin Device Info, Package Info, Telephony Info, Ip Info, Jaibreak/Root detection
  }

  @override
  Widget build(BuildContext context) {
  final CounterBloc counterBloc = Provider.of<CounterBloc>(context); //State Provider
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
            ),
            Text(
              counterBloc.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Increment(),
            Decrement()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.makeRequest(),
        child: Icon(Icons.send),
      ),
    );
  }

//Listen for the updates
  void listenStream(Stream stream) {
    _subscription = stream.asBroadcastStream().listen((event) {
      setState(() {
        text = event as String;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel(); 
  }
}
