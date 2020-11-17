import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_dot/green_dot.dart';

void main() {
  const MethodChannel channel = MethodChannel('green_dot');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GreenDot.platformVersion, '42');
  });
}
