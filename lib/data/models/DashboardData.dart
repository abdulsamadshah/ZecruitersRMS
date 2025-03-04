
class DashboardData {
  bool? status;
  String? response;
  DashData? data;

  DashboardData({this.status, this.response, this.data});

  DashboardData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    data = json['data'] != null ? new DashData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashData {
  String? tOTALCALL;
  String? vALIDCALL;

  DashData({this.tOTALCALL, this.vALIDCALL});

  DashData.fromJson(Map<String, dynamic> json) {
    tOTALCALL = json['TOTAL CALL'];
    vALIDCALL = json['VALID CALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTAL CALL'] = this.tOTALCALL;
    data['VALID CALL'] = this.vALIDCALL;
    return data;
  }
}

