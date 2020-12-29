import 'package:Oukami/modules/ModuleMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..openBox('komikcast');
        // ..openBox('komikcast');

  runApp(
    ModularApp(
      module: ModuleMain(),
    ),
  );
}
