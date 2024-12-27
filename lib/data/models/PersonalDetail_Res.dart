class PersonalDetail_Res {
  //login and personal detai same rwesp
  bool? status;
  String? message;
  Data? data;

  PersonalDetail_Res({this.status, this.message, this.data});

  PersonalDetail_Res.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  bool? stepOne;

  Data({this.token, this.stepOne});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    stepOne = json['stepOne'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['stepOne'] = this.stepOne;
    return data;
  }
}
