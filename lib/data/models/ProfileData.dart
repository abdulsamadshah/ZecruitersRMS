class ProfileDataRes {
  bool? status;
  String? message;
  ProfileData? profileData;

  ProfileDataRes({this.status, this.message, this.profileData});

  ProfileDataRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    profileData = json['ProfileData'] != null
        ? new ProfileData.fromJson(json['ProfileData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.profileData != null) {
      data['ProfileData'] = this.profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? classId;
  String? profileImage;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? password;


  ProfileData(
      {this.classId,
        this.profileImage,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNo,
    this.password});

  ProfileData.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'];
    profileImage = json['ProfileImage'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    mobileNo = json['MobileNo'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['ProfileImage'] = this.profileImage;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['MobileNo'] = this.mobileNo;

    data['Password'] = this.password;
    return data;
  }
}