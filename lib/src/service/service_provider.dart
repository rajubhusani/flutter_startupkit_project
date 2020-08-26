
import 'package:flutter_template_project/src/service/service_constants.dart';

class ServiceProvider{
  Map<String, String> resources;
  ServiceProvider() {
    this.resources = {
      'posts': POSTS,
    };
  }
}