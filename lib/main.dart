import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'feature-list/ui/feature_list_screen.dart';
import 'feature-list-core/data/feature_list_api.dart';
import 'feature-list-core/data/feature_list_repository.dart';
import 'feature-list-core/domain/feature_list_controller/feature_list_controller.dart';


void main() {
  //debugRepaintRainbowEnabled = true;
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
      home: const FeatureList(),
    );
  }
}
