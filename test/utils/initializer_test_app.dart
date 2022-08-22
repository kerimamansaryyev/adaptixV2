import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/widgets/adaptix_initializer.dart';
import 'package:adaptix/src/extensions/pixel_scale.dart';
import 'package:flutter/material.dart';

@visibleForTesting
class InitializerTestApp extends StatefulWidget {
  const InitializerTestApp({
    Key? key,
  }) : super(key: key);

  static const squareSizeMultiplier = 50;

  @override
  State<InitializerTestApp> createState() => InitializerTestAppState();
}

@visibleForTesting
class InitializerTestAppState extends State<InitializerTestApp> {
  AdaptixConfigs configs =
      AdaptixConfigs(breakpoints: AdaptixConfigs.canonicalBreakpoints);

  void changeAdaptixConfigs(AdaptixConfigs newConfigs) {
    setState(() {
      configs = newConfigs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitializerTestPage(
        configs: configs,
      ),
    );
  }
}

@visibleForTesting
class InitializerTestPage extends StatelessWidget {
  const InitializerTestPage({Key? key, required this.configs})
      : super(key: key);

  final AdaptixConfigs configs;

  @override
  Widget build(BuildContext context) {
    return AdaptixInitializer(
        configs: configs,
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
