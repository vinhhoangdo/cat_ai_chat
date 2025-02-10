import 'package:cat_ai_gen/data/data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return [
    ChangeNotifierProvider(
      create: (context) => AuthRepository(),
    ),
  ];
}
