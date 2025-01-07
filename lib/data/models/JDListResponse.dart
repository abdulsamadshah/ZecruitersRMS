class JDResponse {
  bool? status;
  String? response;
  List<JDData>? data;

  JDResponse({this.status, this.response, this.data});

  JDResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    if (json['data'] != null) {
      data = <JDData>[];
      json['data'].forEach((v) {
        data!.add(new JDData.fromJson(v));
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

class JDData {
  String? jDID;
  String? sOURCED;
  String? pENDING;
  String? iNPROCESS;
  String? sHORTLIST;
  String? l2PENDING;
  String? cLIENTNAME;
  String? dESIGNATION;

  JDData(
      {this.jDID,
      this.sOURCED,
      this.pENDING,
      this.iNPROCESS,
      this.sHORTLIST,
      this.l2PENDING,
      this.cLIENTNAME,
      this.dESIGNATION});

  JDData.fromJson(Map<String, dynamic> json) {
    jDID = json['JDID'];
    sOURCED = json['SOURCED'];
    pENDING = json['PENDING'];
    iNPROCESS = json['INPROCESS'];
    sHORTLIST = json['SHORTLIST'];
    l2PENDING = json['L2PENDING'];
    cLIENTNAME = json['CLIENTNAME'];
    dESIGNATION = json['DESIGNATION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['JDID'] = this.jDID;
    data['SOURCED'] = this.sOURCED;
    data['PENDING'] = this.pENDING;
    data['INPROCESS'] = this.iNPROCESS;
    data['SHORTLIST'] = this.sHORTLIST;
    data['L2PENDING'] = this.l2PENDING;
    data['CLIENTNAME'] = this.cLIENTNAME;
    data['DESIGNATION'] = this.dESIGNATION;
    return data;
  }
}
