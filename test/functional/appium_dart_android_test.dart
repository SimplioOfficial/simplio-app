import 'package:flutter_test/flutter_test.dart';

import 'package:appium_driver/async_io.dart';
import 'package:simplio_app/main.dart';
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

  test('start activity', () async {
    await driver.app.background(seconds: const Duration(seconds: -1));
    expect(
        await driver.appState.get('io.appium.android.apis') !=
            AppState.RunningInForeground,
        true);
    await driver.device.startActivity(
        appPackage: 'io.appium.android.apis',
        appActivity: 'io.appium.android.apis.ApiDemos');
    expect(await driver.appState.get('io.appium.android.apis'),
        AppState.RunningInForeground);

    expect('io.appium.android.apis', await driver.device.getCurrentPackage());
    expect('.ApiDemos', await driver.device.getCurrentActivity());
  });
}
