import 'dart:io';

class TestHelper {
  static var localServer = Uri.parse('http://127.0.0.1:4723/wd/hub/');

  static var androidDesiredCapabilitiesApp = {
    'platformName': 'Android',
    'app': File('/build/app/outputs/apk/debug/app-debug.apk').absolute.path,
    'deviceName': 'Android',
    'automationName': 'UiAutomator2',
    'appPackage': 'io.appium.android.apis',
    'appActivity': 'io.appium.android.apis.ApiDemos',
    'unicodeKeyboard': true,
    'resetKeyboard': true,
    'disableWindowAnimation': true,
    'autoGrantPermissions': true,
    'language': 'en',
    'locale': 'US',
  };

  static var iOSDesiredCapabilitiesApp = {
    'platformName': 'iOS',
    'platformVersion': '14.4',
    'app': File('test/functional/app/UICatalog.app.zip').absolute.path,
    'deviceName': 'iPhone 12', // Runs tests in parallel per file by default
    'automationName': 'xcuitest',
    'wdaLocalPort': 8100,
    'useJSONSource': true,
    'reduceMotion': true
  };

  static var iOSDesiredCapabilitiesWeb = {
    'platformName': 'iOS',
    'platformVersion': '14.4',
    'browserName': 'Safari',
    'deviceName': 'iPhone 12', // Runs tests in parallel per file by default
    'automationName': 'xcuitest',
    'wdaLocalPort': 8101,
    'useJSONSource': true,
    'reduceMotion': true
  };
}
