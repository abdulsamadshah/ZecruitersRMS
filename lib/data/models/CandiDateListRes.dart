class CandiDateListRes {
  bool? status;
  String? response;
  List<CandiDateData>? data;

  CandiDateListRes({this.status, this.response, this.data});

  CandiDateListRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    if (json['data'] != null) {
      data = <CandiDateData>[];
      json['data'].forEach((v) {
        data!.add(new CandiDateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CandiDateData {
  String? jdId;
  String? sourcedFor;
  String? firstName;
  String? lastName;
  String? gender;
  String? emailId;
  String? contactNo;
  String? resumeName;
  String? remarkst;
  String? remarks;
  String? totalCallDuration;

  CandiDateData(
      {this.jdId,
      this.sourcedFor,
      this.firstName,
      this.lastName,
      this.gender,
      this.emailId,
      this.contactNo,
      this.resumeName,
      this.remarkst,
      this.remarks,
      this.totalCallDuration});

  CandiDateData.fromJson(Map<String, dynamic> json) {
    jdId = json['jd_id'];
    sourcedFor = json['sourced_for'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    emailId = json['email_id'];
    contactNo = json['contact_no'];
    resumeName = json['resume_name'];
    remarkst = json['remarkst'];
    remarks = json['remarks'];
    totalCallDuration = json['total_call_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jd_id'] = this.jdId;
    data['sourced_for'] = this.sourcedFor;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['email_id'] = this.emailId;
    data['contact_no'] = this.contactNo;
    data['resume_name'] = this.resumeName;
    data['remarkst'] = this.remarkst;
    data['remarks'] = this.remarks;
    data['total_call_duration'] = this.totalCallDuration;
    return data;
  }
}
