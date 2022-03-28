import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'feature-list/ui/feature_list_screen.dart';
import 'feature-list-core/data/feature_list_api.dart';
import 'feature-list-core/data/feature_list_repository.dart';
import 'feature-list-core/domain/feature_list_controller/feature_list_controller.dart';
import 'generated/l10n.dart';

void main() {
  //debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(
      FeatureListController(
        featureListRepository: FeatureListRepositoryImpl(
          FeatureListApi(),
        ),
      )..loadData(),
    );
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: GetBuilder<MediaQueryDataProvider>(
        init: MediaQueryDataProvider(
          MediaQueryData.fromWindow(ui.window),
        ),
        builder: (data) {
          return const FeatureList();
        },
      ),
    );
  }
}

class MediaQueryDataProvider extends GetxController {
  //this class for escape MediaQuery.of context
  //it cause rebuild in getx
  
  final MediaQueryData mediaQueryData;

  MediaQueryDataProvider(this.mediaQueryData);
}
