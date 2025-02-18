import 'package:cat_ai_gen/data/data.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton(() => LocalStorageService().init());
}

List<SingleChildWidget> get providers {
  return [
    ChangeNotifierProvider(
      create: (context) => AuthRepository(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeRepository(),
    ),
  ];
}
