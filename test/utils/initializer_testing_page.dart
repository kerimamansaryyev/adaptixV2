import 'package:adaptix/adaptix.dart';
import 'package:flutter/material.dart';

class InitializerTestApp extends StatefulWidget {
  const InitializerTestApp({Key? key}) : super(key: key);

  static const squareSizeMultiplier = 50;

  @override
  State<InitializerTestApp> createState() => InitializerTestAppState();
}

class InitializerTestAppState extends State<InitializerTestApp> {
  DeviceWidthSideStrategy strategy = DeviceWidthSideStrategy.useOriginalWidth;

  void setShortSideStrategy() {
    strategy = DeviceWidthSideStrategy.useShortestSide;
    setState(() {});
  }

  void setOriginalWidthStrategy() {
    strategy = DeviceWidthSideStrategy.useOriginalWidth;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitializerTestPage(
        strategy: strategy,
      ),
    );
  }
}

class InitializerTestPage extends StatelessWidget {
  const InitializerTestPage({Key? key, required this.strategy})
      : super(key: key);

  final DeviceWidthSideStrategy strategy;

  @override
  Widget build(BuildContext context) {
    return AdaptixInitializer(
        configs: PixelScaleConfigs.canonical(deviceWidthSideStrategy: strategy),
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Initializer test'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: InitializerTestSquare(),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class InitializerTestSquare extends StatelessWidget {
  const InitializerTestSquare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: InitializerTestApp.squareSizeMultiplier.adaptedPx(context),
      height: InitializerTestApp.squareSizeMultiplier.adaptedPx(context),
    );
  }
}
