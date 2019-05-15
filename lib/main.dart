import 'package:flutter/material.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:dependencies/dependencies.dart';
import 'package:injection/ui/post/post_component.dart';
import 'services/module.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: InjectorWidget(
            injector: Injector.fromModule(module: ServiceModule()),
            child: MaterialApp(
              title: 'post app',
              theme: ThemeData.dark(),
              home: new PostScreen(),
            )
        )
    );
  }
}