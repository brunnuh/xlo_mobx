import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // garante que o flutter widgets esteja iniciado
  await initializeParse();
  setupLocators(); // chamando singletons
  runApp(MyApp());
}

Future<void> initializeParse() async {
  await Parse().initialize("cWiKFEECIMojnCk6KbqNgKe7bwDDIa3jUg1rYM8W",
      "https://parseapi.back4app.com/",
      clientKey: "RXNQhEbK1UO1vADOjdXLrAW7Mrjk4ki6pmCN2CEb",
      autoSendSessionId: true,
      debug: true);
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
  GetIt.I.registerSingleton(FilterStore());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),
          cursorColor: Colors.orange // cor do cursor
          ),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
    );
  }
}
