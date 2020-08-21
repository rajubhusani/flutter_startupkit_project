enum Environment { STUB, DEV, SIT, UAT, PROD }

class AppConfig {
  static Map<String, dynamic> _appConfig;
  static Environment _environment;

  static void setEnvironment(Environment environment) {
    _environment = environment;
    switch (environment) {
      case Environment.STUB:
        _appConfig = _Config.stub;
        break;
      case Environment.DEV:
        _appConfig = _Config.dev;
        break;
      case Environment.SIT:
        _appConfig = _Config.sit;
        break;
      case Environment.UAT:
        _appConfig = _Config.uat;
        break;
      case Environment.PROD:
        _appConfig = _Config.prod;
        break;
    }
  }

  static getEnvironment() => _environment;
  static get BASE_URL => _appConfig[_Config._SERVER];
  static get APP_NAME => _appConfig[_Config._APP_NAME];
  static get STUB_ENABLED => _appConfig[_Config._STUB_ENABLED];
  static get ENVIRONMENT => _appConfig[_Config._ENV];
  static get KEY_CODE => _appConfig[_Config._KEY_CODE];
  static get SERVER_CERT => _appConfig[_Config._CERTIFICATE];
}

class _Config {
  static const _SERVER = "server";
  static const _CERTIFICATE = "cer";
  static const _APP_NAME = "name";
  static const _STUB_ENABLED = "stub";
  static const _ENV = "environment";
  static const _KEY_CODE = "keyCode";

  static final String dev_server = "YOUR SERVER_INFO";
  static final String prod_server = "YOUR SERVER_INFO";
  static final String DEV = "/dev";
  static final String SIT = "/sit";
  static final String UAT = "/uat";
  static final String PROD = "/cma";

  static Map<String, dynamic> stub = {
    _SERVER: 'assets/stubs/',
    _ENV: '',
    _CERTIFICATE: "",
    _APP_NAME: "Flutter Application Template STUB",
    _STUB_ENABLED: true,
  };

  static Map<String, dynamic> dev = {
    _SERVER: dev_server,
    _ENV: DEV,
    _CERTIFICATE: "asset cert file location",
    _APP_NAME: "Flutter Application Template DEV",
    _STUB_ENABLED: false,
  };

  static Map<String, dynamic> sit = {
    _SERVER: dev_server,
    _ENV: SIT,
    _CERTIFICATE: "asset cert file location",
    _APP_NAME: "Flutter Application Template SIT",
    _STUB_ENABLED: false,
  };

  static Map<String, dynamic> uat = {
    _SERVER: dev_server,
    _ENV: UAT,
    _CERTIFICATE: "asset cert file location",
    _APP_NAME: "Flutter Application Template UAT",
    _STUB_ENABLED: false,
  };

  static Map<String, dynamic> prod = {
    _SERVER: prod_server,
    _ENV: PROD,
    _CERTIFICATE: "asset cert file location",
    _APP_NAME: "Flutter Application Template",
    _STUB_ENABLED: false,
  };
}
