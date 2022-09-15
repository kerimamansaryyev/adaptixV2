import 'dart:math';

import 'package:flutter/material.dart';
import 'package:adaptix/adaptix.dart';

enum MyResposivenessPattern implements ResponsiveBreakpoint {
  iphone7(templateDeviceWidth: 375, pixelScale: 1),
  iphone11(templateDeviceWidth: 414, pixelScale: 1.1),
  ipadMini(templateDeviceWidth: 768, pixelScale: 1.12),
  someDesktopDevice(templateDeviceWidth: 1024, pixelScale: 1.2);

  static final myPixelScaleRules = MyResposivenessPattern.values
      .map<GenericResponsiveRule<double>>((devicePattern) =>
          GenericResponsiveRule(devicePattern.key, devicePattern.pixelScale))
      .toList();

  @override
  final double templateDeviceWidth;

  final double pixelScale;

  const MyResposivenessPattern(
      {required this.templateDeviceWidth, required this.pixelScale});

  @override
  String get debugLabel => key;

  @override
  bool hasSameValueAs(ResponsiveBreakpoint other) =>
      other.templateDeviceWidth == templateDeviceWidth;

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is ResponsiveBreakpoint &&
        other.templateDeviceWidth == templateDeviceWidth &&
        other.key == key;
  }

  /// key as a name of an element of this enum
  @override
  String get key => name;

  static GenericResponsiveSwitchArgs<T> myResponsiveSwitchArguments<T>(
      {required T defaultValue,
      T? iphone7Value,
      T? iphone11Value,
      T? ipadMiniValue,
      T? someDesktopDeviceValue}) {
    final ruleValues = [
      iphone7Value,
      iphone11Value,
      ipadMiniValue,
      someDesktopDeviceValue
    ];
    return GenericResponsiveSwitchArgs<T>(defaultValue: defaultValue, rules: [
      for (int i = 0;
          i < min(MyResposivenessPattern.values.length, ruleValues.length);
          i++)
        GenericResponsiveRule(
            MyResposivenessPattern.values[i].key, ruleValues[i] ?? defaultValue)
    ]);
  }

  static AdaptixConfigs configs() => AdaptixConfigs(
      breakpoints: MyResposivenessPattern.values,
      pixelScaleRules: MyResposivenessPattern.myPixelScaleRules);

  /// deprecated, implement as null
  @override
  double? get value => null;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AdaptixInitializer(
        configs: MyResposivenessPattern.configs(),
        builder: (context) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      width: 50.adaptedPx(context),
                      height: 50.adaptedPx(context),
                      child: Text(context.responsiveSwitch(
                          MyResposivenessPattern.myResponsiveSwitchArguments<
                                  String>(
                              defaultValue: 'Unrecognized device pattern',
                              iphone7Value: 'iphone7 device pattern',
                              iphone11Value: 'iphone11 device pattern',
                              ipadMiniValue: 'ipadMini device pattern'))),
                    ),
                    SizedBox(
                      child: Text(context.orientationSwitch<String>(
                          onLandscape: 'Landscape text',
                          onPortrait: 'Portrait text')),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
