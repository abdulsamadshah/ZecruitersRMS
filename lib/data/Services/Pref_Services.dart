import 'dart:convert';
import 'dart:developer';


import 'package:zecruiters_rms/data/models/PersonalDetail_Res.dart';

import '../../core/constant/global.dart';


class Pref_Services {
  void saveProfileData(ProfileData? data) {
    try {
      ProfileData userdata = ProfileData(
        userId: data!.userId,
        empId: data.emailId,
     emailId: data.emailId,
        firstName: data.firstName,
        lastName: data.lastName,
        userType: data.userType,

      );
      Global.storageServices.setString('profileData', jsonEncode(userdata));
    } catch (e) {
      log(e.toString());
    }
  }




}
