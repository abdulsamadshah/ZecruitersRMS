class LoginRes {
  String? token;
  bool? status;
  String? response;
  ProfileData? data;

  LoginRes({this.token, this.status, this.response, this.data});

  LoginRes.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    status = json['status'];
    response = json['response'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['status'] = this.status;
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? userId;
  String? empId;
  String? userType;
  String? userLevel;
  String? workUnder;
  String? loingId;
  String? loginPassword;
  String? roleId;
  String? subRoleId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? emailId;
  String? emailPassword;
  String? mobileNumber;
  String? gender;
  String? address1;
  Null? address2;
  String? country;
  String? state;
  String? city;
  String? zip;
  String? location;
  String? isactive;
  String? isdelete;
  String? createdon;
  Null? createdby;
  String? modifiedon;
  Null? modifiedby;
  String? personalEmailId;
  String? bloodGrp;
  String? emargancyContact;
  String? emargancyContName;
  String? relationshipwithemergency;
  String? communicationaddress;
  String? cPincode;
  String? cLocation;
  String? cCity;
  String? cState;
  String? cCountry;
  String? adhaarNo;
  String? panNo;
  String? organisation;
  String? designation;
  String? bankName;
  String? bankAcType;
  String? bankAcNo;
  String? bankIfscCode;
  String? shiftType;
  String? pfApplied;
  String? ptApplied;
  Null? uanno;
  Null? monthlyDeductionHead;
  Null? monthlyDeductionAmt;
  String? doj;
  Null? dol;
  String? yearlyctc;
  Null? yearlyempfund;
  Null? commissionid;
  String? comfixed;
  String? comrefclt;
  String? comrefhandclt;
  String? comservclt;
  String? comrefservclt;
  String? dateOfBirth;
  String? profilepercentage;
  String? profileimage;
  String? referdBy;
  String? accessRights;

  ProfileData(
      {this.userId,
        this.empId,
        this.userType,
        this.userLevel,
        this.workUnder,
        this.loingId,
        this.loginPassword,
        this.roleId,
        this.subRoleId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.emailId,
        this.emailPassword,
        this.mobileNumber,
        this.gender,
        this.address1,
        this.address2,
        this.country,
        this.state,
        this.city,
        this.zip,
        this.location,
        this.isactive,
        this.isdelete,
        this.createdon,
        this.createdby,
        this.modifiedon,
        this.modifiedby,
        this.personalEmailId,
        this.bloodGrp,
        this.emargancyContact,
        this.emargancyContName,
        this.relationshipwithemergency,
        this.communicationaddress,
        this.cPincode,
        this.cLocation,
        this.cCity,
        this.cState,
        this.cCountry,
        this.adhaarNo,
        this.panNo,
        this.organisation,
        this.designation,
        this.bankName,
        this.bankAcType,
        this.bankAcNo,
        this.bankIfscCode,
        this.shiftType,
        this.pfApplied,
        this.ptApplied,
        this.uanno,
        this.monthlyDeductionHead,
        this.monthlyDeductionAmt,
        this.doj,
        this.dol,
        this.yearlyctc,
        this.yearlyempfund,
        this.commissionid,
        this.comfixed,
        this.comrefclt,
        this.comrefhandclt,
        this.comservclt,
        this.comrefservclt,
        this.dateOfBirth,
        this.profilepercentage,
        this.profileimage,
        this.referdBy,
        this.accessRights});

  ProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    empId = json['emp_id'];
    userType = json['user_type'];
    userLevel = json['user_level'];
    workUnder = json['work_under'];
    loingId = json['loing_id'];
    loginPassword = json['login_password'];
    roleId = json['role_id'];
    subRoleId = json['sub_role_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    emailPassword = json['email_password'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    country = json['Country'];
    state = json['State'];
    city = json['City'];
    zip = json['Zip'];
    location = json['location'];
    isactive = json['Isactive'];
    isdelete = json['Isdelete'];
    createdon = json['createdon'];
    createdby = json['createdby'];
    modifiedon = json['modifiedon'];
    modifiedby = json['modifiedby'];
    personalEmailId = json['personal_email_id'];
    bloodGrp = json['blood_grp'];
    emargancyContact = json['EmargancyContact'];
    emargancyContName = json['EmargancyContName'];
    relationshipwithemergency = json['relationshipwithemergency'];
    communicationaddress = json['communicationaddress'];
    cPincode = json['cPincode'];
    cLocation = json['cLocation'];
    cCity = json['cCity'];
    cState = json['cState'];
    cCountry = json['cCountry'];
    adhaarNo = json['adhaar_no'];
    panNo = json['pan_no'];
    organisation = json['organisation'];
    designation = json['designation'];
    bankName = json['bank_name'];
    bankAcType = json['bank_ac_type'];
    bankAcNo = json['bank_ac_no'];
    bankIfscCode = json['bank_ifsc_code'];
    shiftType = json['shift_type'];
    pfApplied = json['pf_applied'];
    ptApplied = json['pt_applied'];
    uanno = json['uanno'];
    monthlyDeductionHead = json['MonthlyDeductionHead'];
    monthlyDeductionAmt = json['MonthlyDeductionAmt'];
    doj = json['doj'];
    dol = json['dol'];
    yearlyctc = json['yearlyctc'];
    yearlyempfund = json['yearlyempfund'];
    commissionid = json['commissionid'];
    comfixed = json['comfixed'];
    comrefclt = json['comrefclt'];
    comrefhandclt = json['comrefhandclt'];
    comservclt = json['comservclt'];
    comrefservclt = json['comrefservclt'];
    dateOfBirth = json['date_of_birth'];
    profilepercentage = json['profilepercentage'];
    profileimage = json['profileimage'];
    referdBy = json['referd_by'];
    accessRights = json['access_rights'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['emp_id'] = this.empId;
    data['user_type'] = this.userType;
    data['user_level'] = this.userLevel;
    data['work_under'] = this.workUnder;
    data['loing_id'] = this.loingId;
    data['login_password'] = this.loginPassword;
    data['role_id'] = this.roleId;
    data['sub_role_id'] = this.subRoleId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email_id'] = this.emailId;
    data['email_password'] = this.emailPassword;
    data['mobile_number'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['Address1'] = this.address1;
    data['Address2'] = this.address2;
    data['Country'] = this.country;
    data['State'] = this.state;
    data['City'] = this.city;
    data['Zip'] = this.zip;
    data['location'] = this.location;
    data['Isactive'] = this.isactive;
    data['Isdelete'] = this.isdelete;
    data['createdon'] = this.createdon;
    data['createdby'] = this.createdby;
    data['modifiedon'] = this.modifiedon;
    data['modifiedby'] = this.modifiedby;
    data['personal_email_id'] = this.personalEmailId;
    data['blood_grp'] = this.bloodGrp;
    data['EmargancyContact'] = this.emargancyContact;
    data['EmargancyContName'] = this.emargancyContName;
    data['relationshipwithemergency'] = this.relationshipwithemergency;
    data['communicationaddress'] = this.communicationaddress;
    data['cPincode'] = this.cPincode;
    data['cLocation'] = this.cLocation;
    data['cCity'] = this.cCity;
    data['cState'] = this.cState;
    data['cCountry'] = this.cCountry;
    data['adhaar_no'] = this.adhaarNo;
    data['pan_no'] = this.panNo;
    data['organisation'] = this.organisation;
    data['designation'] = this.designation;
    data['bank_name'] = this.bankName;
    data['bank_ac_type'] = this.bankAcType;
    data['bank_ac_no'] = this.bankAcNo;
    data['bank_ifsc_code'] = this.bankIfscCode;
    data['shift_type'] = this.shiftType;
    data['pf_applied'] = this.pfApplied;
    data['pt_applied'] = this.ptApplied;
    data['uanno'] = this.uanno;
    data['MonthlyDeductionHead'] = this.monthlyDeductionHead;
    data['MonthlyDeductionAmt'] = this.monthlyDeductionAmt;
    data['doj'] = this.doj;
    data['dol'] = this.dol;
    data['yearlyctc'] = this.yearlyctc;
    data['yearlyempfund'] = this.yearlyempfund;
    data['commissionid'] = this.commissionid;
    data['comfixed'] = this.comfixed;
    data['comrefclt'] = this.comrefclt;
    data['comrefhandclt'] = this.comrefhandclt;
    data['comservclt'] = this.comservclt;
    data['comrefservclt'] = this.comrefservclt;
    data['date_of_birth'] = this.dateOfBirth;
    data['profilepercentage'] = this.profilepercentage;
    data['profileimage'] = this.profileimage;
    data['referd_by'] = this.referdBy;
    data['access_rights'] = this.accessRights;
    return data;
  }
}
