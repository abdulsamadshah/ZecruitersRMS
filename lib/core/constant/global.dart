
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/logic/debug/Bloc_Observer.dart';
import 'storage_services.dart';


class Global {
  static late StorageServices storageServices;


  static Future init() async {




    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Bloc.observer = MyGlobalObserver();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ToggleThemeData.purple
    ));

    storageServices = await StorageServices().init();
  }


}
