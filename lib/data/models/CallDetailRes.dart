class CallDetailRes {
  bool? status;
  String? response;
  List<CallDetail>? data;

  CallDetailRes({this.status, this.response, this.data});

  CallDetailRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    if (json['data'] != null) {
      data = <CallDetail>[];
      json['data'].forEach((v) {
        data!.add(new CallDetail.fromJson(v));
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

class CallDetail {
  String? id;
  String? jdId;
  String? mobileNo;
  String? callStartTime;
  String? callEndTime;
  String? callDuration;
  String? callRecord;
  String? callBy;
  String? dateTime;

  CallDetail(
      {this.id,
      this.jdId,
      this.mobileNo,
      this.callStartTime,
      this.callEndTime,
      this.callDuration,
      this.callRecord,
      this.callBy,
      this.dateTime});

  CallDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jdId = json['jd_id'];
    mobileNo = json['mobile_no'];
    callStartTime = json['call_start_time'];
    callEndTime = json['call_end_time'];
    callDuration = json['call_duration'];
    callRecord = json['call_record'];
    callBy = json['call_by'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jd_id'] = this.jdId;
    data['mobile_no'] = this.mobileNo;
    data['call_start_time'] = this.callStartTime;
    data['call_end_time'] = this.callEndTime;
    data['call_duration'] = this.callDuration;
    data['call_record'] = this.callRecord;
    data['call_by'] = this.callBy;
    data['date_time'] = this.dateTime;
    return data;
  }
}
