import 'package:flutter_template_project/src/service/service_constants.dart';
import 'package:flutter_template_project/src/service/service_invoker.dart';

enum REQUESTTYPE { POST, GET }

class APIStore {
  final _invoker = ServiceInvoker();

  //Sample Request
  Future<dynamic> sampleService() async =>
      await _invoker.makeRequest(SAMPLE, REQUESTTYPE.GET);
}
