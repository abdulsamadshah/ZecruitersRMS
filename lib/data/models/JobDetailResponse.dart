class JDDetailResponse {
  bool? status;
  String? response;
  List<JD_DetailData>? data;

  JDDetailResponse({this.status, this.response, this.data});

  JDDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    if (json['data'] != null) {
      data = <JD_DetailData>[];
      json['data'].forEach((v) {
        data!.add(new JD_DetailData.fromJson(v));
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

class JD_DetailData {
  String? jdId;
  String? jdNcandidates;
  String? jdGender;
  String? jdExperianceFrom;
  String? jdExperianceTo;
  String? jdAgeFrom;
  String? jdAgeTo;
  String? jdDesignation;
  String? jdLocation;
  String? jdPincode;
  String? jdFctc;
  String? jdTctc;
  String? crnctype;
  String? jdVariable;
  String? jdSkill;
  String? jdPreference;
  String? jdDescription;
  String? cname;
  String? industryName;
  String? departmentSUbCategoryMasterName;
  String? departmentSubFunctionsName;

  JD_DetailData(
      {this.jdId,
      this.jdNcandidates,
      this.jdGender,
      this.jdExperianceFrom,
      this.jdExperianceTo,
      this.jdAgeFrom,
      this.jdAgeTo,
      this.jdDesignation,
      this.jdLocation,
      this.jdPincode,
      this.jdFctc,
      this.jdTctc,
      this.crnctype,
      this.jdVariable,
      this.jdSkill,
      this.jdPreference,
      this.jdDescription,
      this.cname,
      this.industryName,
      this.departmentSUbCategoryMasterName,
      this.departmentSubFunctionsName});

  JD_DetailData.fromJson(Map<String, dynamic> json) {
    jdId = json['jd_id'];
    jdNcandidates = json['jd_ncandidates'];
    jdGender = json['jd_gender'];
    jdExperianceFrom = json['jd_experiance_from'];
    jdExperianceTo = json['jd_experiance_to'];
    jdAgeFrom = json['jd_age_from'];
    jdAgeTo = json['jd_age_to'];
    jdDesignation = json['jd_designation'];
    jdLocation = json['jd_location'];
    jdPincode = json['jd_pincode'];
    jdFctc = json['jd_fctc'];
    jdTctc = json['jd_tctc'];
    crnctype = json['crnctype'];
    jdVariable = json['jd_variable'];
    jdSkill = json['jd_skill'];
    jdPreference = json['jd_preference'];
    jdDescription = json['jd_description'];
    cname = json['cname'];
    industryName = json['Industry_Name'];
    departmentSUbCategoryMasterName =
        json['Department_SUb_Category_Master_Name'];
    departmentSubFunctionsName = json['Department_SubFunctions_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jd_id'] = this.jdId;
    data['jd_ncandidates'] = this.jdNcandidates;
    data['jd_gender'] = this.jdGender;
    data['jd_experiance_from'] = this.jdExperianceFrom;
    data['jd_experiance_to'] = this.jdExperianceTo;
    data['jd_age_from'] = this.jdAgeFrom;
    data['jd_age_to'] = this.jdAgeTo;
    data['jd_designation'] = this.jdDesignation;
    data['jd_location'] = this.jdLocation;
    data['jd_pincode'] = this.jdPincode;
    data['jd_fctc'] = this.jdFctc;
    data['jd_tctc'] = this.jdTctc;
    data['crnctype'] = this.crnctype;
    data['jd_variable'] = this.jdVariable;
    data['jd_skill'] = this.jdSkill;
    data['jd_preference'] = this.jdPreference;
    data['jd_description'] = this.jdDescription;
    data['cname'] = this.cname;
    data['Industry_Name'] = this.industryName;
    data['Department_SUb_Category_Master_Name'] =
        this.departmentSUbCategoryMasterName;
    data['Department_SubFunctions_Name'] = this.departmentSubFunctionsName;
    return data;
  }
}
