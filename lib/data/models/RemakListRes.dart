
class RemakListRes {
  bool? status;
  String? response;
  List<RemakListData>? data;

  RemakListRes({this.status, this.response, this.data});

  RemakListRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    if (json['data'] != null) {
      data = <RemakListData>[];
      json['data'].forEach((v) {
        data!.add(new RemakListData.fromJson(v));
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

class RemakListData {
  String? id;
  String? remarks;

  RemakListData({this.id, this.remarks});

  RemakListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['remarks'] = this.remarks;
    return data;
  }
}

