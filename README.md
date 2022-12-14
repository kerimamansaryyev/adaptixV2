# adaptix
A powerful and lightweight package for building beautiful responsive and adaptive applications.

# Usage

## Initializing
1. Wrap your widget subtree (usually, the starting point of your app) with `AdaptixInitializer` and pass an instance of `AdaptixConfigs` to `configs` parameter.
```dart
 AdaptixInitializer(
        configs: const AdaptixConfigs.canonical(),
        builder: (context) {
          return  MaterialApp(
            home: ...
          );
    });
```
2. And access data through a `BuildContext`. You can access `AdaptixConstraints` with `Adaptix.of(context)` or use the extension methods designed for pretty semantics.
```dart
AdaptixInitializer(
        configs: const AdaptixConfigs.canonical(),
        builder: (context) {
          // Accessing adaptix
          print(Adaptix.of(context));
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
                      child: Text('${50.adaptedPx(context).round()} px'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
```
## ResponsiveBreakpoint 
Instances of `ResponsiveBreakpoint` represent a start point of a layout pattern that is used by `Adaptix` to switch onto when a layout of a device changes. Those breakpoints are distinguished by their `templateDeviceWidth` field. In a context of this package, `templateDeviceWidth` of `ResponsiveBreakpoint` is a device width that is used for `Adaptix` to decide whether to use the breakpoint if a layout of a device changes the metrics.

A width of a device will be used in comparison with all the declared breakpoints' values if `DeviceBreakpointDecisionStrategy.useOriginalWidth` was set in the configurations, else if `DeviceBreakpointDecisionStrategy.useShortestSide` was applied, the shortest side of a device will be selected in comparison with the `templateDeviceWidth` of the breakpoints. The strategy variations were added as options because there are devices with ultra wide displays.

## How `Adaptix` decides which breakpoint to use?
So, basically, the device side is selected, as described above, for comparing to the breakpoints and performs following logic:

The breakpoint is selected if the device side is more or equal than `n` breakpoint's `templateDeviceWidth` and less than `n+1` breakpoint's `templateDeviceWidth`. 

If the device side is less than `templateDeviceWidth` of the first breakpoint - then the first breakpoint will be selected.

If the device side is more than `templateDeviceWidth` of the last breakpoint - then the last breakpoint will be selected.

## Customization
You can define your own configurations using default constructor of `AdaptixConfigs`.
```dart
AdaptixConfigs(
          /// Here you define the breakpoints
          /// Use width of a template device as a templateDeviceWidth of a breakpoint
          breakpoints: const [
            ResponsiveBreakpoint(templateDeviceWidth: 375, key: 'iphone7'),
            ResponsiveBreakpoint(templateDeviceWidth: 414, key: 'iphone11'),
            ResponsiveBreakpoint(templateDeviceWidth: 768, key: 'ipadMini'),
          ],

          /// Define pixel scale rule per breakpoint
          pixelScaleRules: const {
            'iphone7': 1,
            'iphone11': 1.1,
            'ipadMini': 1.2,
          },
        )
```
# Extension methods

### .adaptedPx on `double`
Get a logical pixel scaled according to a current breakpoint of `Adaptix`.
```dart
print(1.adaptedPx(context));
```
### .widthFraction on `double`
Gives a percent fraction of the device width
```dart
// means 50 percent of the device width
print(50.widthFraction(context));
```
### .heightFraction on `double`
Gives a percent fraction of the device height
```dart
// means 50 percent of the device height
print(50.heightFraction(context));
```
### .shortestSideFraction on `double`
Gives a percent fraction of the device's shortest side
```dart
// means 50 percent of the shortest side of the device
print(50.shortestSideFraction(context));
```
### .longestSideFraction on `double`
Gives a percent fraction of the device's longest side
```dart
// means 50 percent of the longest side of the device
print(50.longestSideFraction(context));
```
### .orientationSwitch on `context`
Returns the text according to the current orientation
```dart
print(
  context.orientationSwitch<String>(
    onLandscape: 'Landscape text',
    onPortrait: 'Portrait text'
  )
);
```

### .responsiveSwitch on `context`
Do you want to display some widget according to a current breakpoint or maybe to display some text instead? This extension method allows to return a generic value of type `T` according to a current breakpoint of `Adaptix`.
```dart
AdaptixInitializer(
        configs: AdaptixConfigs(
          /// Here you define the breakpoints
          /// Use width of a template device as a value of a breakpoint
          breakpoints: const [
            ResponsiveBreakpoint(templateDeviceWidth: 375, key: 'iphone7'),
            ResponsiveBreakpoint(templateDeviceWidth: 414, key: 'iphone11'),
            ResponsiveBreakpoint(templateDeviceWidth: 768, key: 'ipadMini'),
          ],

          /// Define pixel scale rule per breakpoint.
          pixelScaleRules: const {
            'iphone7': 1,
            'iphone11': 1.1,
            'ipadMini': 1.2,
          },
        ),
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
                      child: Text(
                        context.responsiveSwitch(
                          const GenericResponsiveSwitchArgs<String>(
                            defaultValue: 'This is a default text',
                            rules: const {
                              'iphone7': 'Hello, I am a pattern based on width of iphone7',
                              'iphone11':
                                  'Hello, I am a pattern based on dimensions of iphone11',
                              'ipadMini':
                                  'Hello, I am a pattern based on dimensions of ipadMini',
                            },
                          ),
                        ),
                      ),
                    );
                  ],
                ),
              ),
            ),
          );
        });
```
## **Note**:
If you use `AdaptixConfigs.canonical`, then pass `CanonicalResponsiveBreakpoint.createCanonicalSwitchArguments` as an argument to `.responsiveSwitch`
```dart
context.responsiveSwitch(CanonicalResponsiveBreakpoint
.createCanonicalSwitchArguments<String>(
                  defaultValue: 'Some default text',
                  xSmall: 'Text of xSmall devices',
                  small: 'Text of small devices',
                  medium: 'Text of medium devices',
                  tablet: 'Text of tablets',
                  desktop: 'Text of desktop apps'));
```

# Best practice
It's recommended to implement the value object pattern using this package for an elegant semantics and maintainable architecture. For that purpose you can use enhanced enums that come out of the box with `Dart 2.17`. Example:
```dart
enum MyResposivenessPattern implements ResponsiveBreakpoint {
  iphone11(templateDeviceWidth: 414, pixelScale: 1.1),
  iphone7(templateDeviceWidth: 375, pixelScale: 1),
  ipadMini(templateDeviceWidth: 768, pixelScale: 1.12),
  someDesktopDevice(templateDeviceWidth: 1024, pixelScale: 1.2);

  static final myPixelScaleRules = {
    for (var value in values) value.key: value.pixelScale,
  };

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
    return ResponsiveBreakpoint.breakpointEquality(
      this,
      other,
    );
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
    return GenericResponsiveSwitchArgs(
      defaultValue: defaultValue,
      rules: {
        iphone7.key: iphone7Value ?? defaultValue,
        iphone11.key: iphone11Value ?? defaultValue,
        ipadMini.key: ipadMiniValue ?? defaultValue,
        someDesktopDevice.key: someDesktopDeviceValue ?? defaultValue,
      },
    );
  }

  static AdaptixConfigs configs() => AdaptixConfigs(
      breakpoints: MyResposivenessPattern.values,
      pixelScaleRules: MyResposivenessPattern.myPixelScaleRules);
}

```

And use it as:
```dart
AdaptixInitializer(
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
                          MyResposivenessPattern.myResponsiveSwitchArguments(
                              defaultValue: 'Unrecognized device pattern',
                              iphone7Value: 'iphone7 device pattern',
                              iphone11Value: 'iphone11 device pattern',
                              ipadMiniValue: 'ipadMini device pattern'))),
                    )
                  ],
                ),
              ),
            ),
          );
        });
```
