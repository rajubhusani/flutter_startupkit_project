import 'package:flutter_template_project/src/common/app_config.dart';
import 'package:flutter_template_project/src/service/service_constants.dart';

class ServiceProvider{
  Map<String, String> resources;
  ServiceProvider() {
    this.resources = {
      'baseUrl': AppConfig.BASE_URL as String,
      'sample': sample_endpoint,
    };
  }
}