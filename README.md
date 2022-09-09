# adaptix
A powerful and lightweight package for building beautiful responsive and adaptive applications.

# Usage
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
