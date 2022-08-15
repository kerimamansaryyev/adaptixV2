import 'package:adaptix/src/models/configs.dart';
import 'package:adaptix/src/models/data.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:flutter/material.dart';

class AdaptixInitializer extends StatefulWidget with StraighComparisonMixin {
  const AdaptixInitializer({Key? key, required this.configs}) : super(key: key);

  final AdaptixConfigs configs;

  @override
  State<AdaptixInitializer> createState() => _AdaptixInitializerState();

  @override
  bool isSameAs(StraighComparisonMixin other) {
    return other is AdaptixInitializer && other.configs.isSameAs(configs);
  }
}

class _AdaptixInitializerState extends State<AdaptixInitializer> {
  late AdaptixConstraints _constraints;

  void _setConstraints(double width) {}

  @override
  void didUpdateWidget(covariant AdaptixInitializer oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
