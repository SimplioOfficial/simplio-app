import 'package:flutter_test/flutter_test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  late AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.androidDesiredCapabilitiesApp);
    await driver.timeouts.setImplicitTimeout(const Duration(seconds: 5));
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('open notification', () async {
    await driver.device.openNotification();
  });
}
