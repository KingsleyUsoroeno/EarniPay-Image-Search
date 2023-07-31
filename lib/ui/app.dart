import 'package:earnipay_image_search/di/injection.dart';
import 'package:earnipay_image_search/ui/counter_app.dart';
import 'package:earnipay_image_search/ui/photo-search/photo_search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

void initApp(Environment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(environment);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(MyApp(environment: environment.name));
}


class MyApp extends StatelessWidget {
  final String environment;

  const MyApp({super.key, required this.environment});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'ProximaNova'),
      home: environment == Environment.test ? const CounterAppScreen() : const PhotoSearchScreen(),
    );
  }
}