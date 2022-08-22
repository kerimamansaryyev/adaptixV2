import 'package:adaptix/src/extensions/size_fraction.dart';
import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/widgets/adaptix_initializer.dart';
import 'package:flutter/material.dart';

class TestSizeFractionWidget extends StatelessWidget {
  const TestSizeFractionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AdaptixInitializer(
            configs: const AdaptixConfigs.canonical(),
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Initializer test'),
                ),
                body: Center(
                  child: ListView(
                    children: const [
                      Center(
                        child: TestSizeFractionSquareWidget(),
                      ),
                      Center(
                        child: TestLongestShortestSideWidget(),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

class TestSizeFractionSquareWidget extends StatelessWidget {
  const TestSizeFractionSquareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 50.widthFraction(context),
      height: 50.heightFraction(context),
    );
  }
}

class TestLongestShortestSideWidget extends StatelessWidget {
  const TestLongestShortestSideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 50.shortestSideFraction(context),
      height: 50.longestSideFraction(context),
    );
  }
}
