class CreateScheme {
  String? schemeID;
  String? schemeName;
  String? schemeDescription;
  String? schemeProviderID;
  String? schemeProviderName;
  String? schemeProviderDescription;
  String? schemeType;
  String? financialYear;
  List<SchemeFor>? schemeFor;
  String? schemeAmount;
  Eligibility? eligibility;
  String? isActive;
  String? startDate;
  String? endDate;
  String? documentsTobeSubmitted;
  String? spocName;
  String? spocEmail;
  String? helpdeskNo;
  String? schemeProviderWebsite;
  String? termsAndConditions;

  CreateScheme(
      {this.schemeID,
      this.schemeName,
      this.schemeDescription,
      this.schemeProviderID,
      this.schemeProviderName,
      this.schemeProviderDescription,
      this.schemeType,
      this.financialYear,
      this.schemeFor,
      this.schemeAmount,
      this.eligibility,
      this.isActive,
      this.startDate,
      this.endDate,
      this.documentsTobeSubmitted,
      this.spocName,
      this.spocEmail,
      this.helpdeskNo,
      this.schemeProviderWebsite,
      this.termsAndConditions});

  CreateScheme.fromJson(Map<String, dynamic> json) {
    schemeID = json['schemeID'];
    schemeName = json['schemeName'];
    schemeDescription = json['schemeDescription'];
    schemeProviderID = json['schemeProviderID'];
    schemeProviderName = json['schemeProviderName'];
    schemeProviderDescription = json['schemeProviderDescription'];
    schemeType = json['schemeType'];
    financialYear = json['financialYear'];
    if (json['schemeFor'] != null) {
      schemeFor = <SchemeFor>[];
      json['schemeFor'].forEach((v) {
        schemeFor!.add(SchemeFor.fromJson(v));
      });
    }
    schemeAmount = json['schemeAmount'];
    eligibility = json['eligibility'] != null
        ? Eligibility.fromJson(json['eligibility'])
        : null;
    isActive = json['isActive'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    documentsTobeSubmitted = json['documentsTobeSubmitted'];
    spocName = json['spocName'];
    spocEmail = json['spocEmail'];
    helpdeskNo = json['helpdeskNo'];
    schemeProviderWebsite = json['schemeProviderWebsite'];
    termsAndConditions = json['termsAndConditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schemeID'] = schemeID;
    data['schemeName'] = schemeName;
    data['schemeDescription'] = schemeDescription;
    data['schemeProviderID'] = schemeProviderID;
    data['schemeProviderName'] = schemeProviderName;
    data['schemeProviderDescription'] = schemeProviderDescription;
    data['schemeType'] = schemeType;
    data['financialYear'] = financialYear;

    if (schemeFor != null) {
      data['schemeFor'] = schemeFor!.map((v) => v.toJson()).toList();
    }
    data['schemeAmount'] = schemeAmount;
    if (eligibility != null) {
      data['eligibility'] = eligibility!.toJson();
    }
    data['isActive'] = isActive;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['documentsTobeSubmitted'] = documentsTobeSubmitted;
    data['spocName'] = spocName;
    data['spocEmail'] = spocEmail;
    data['helpdeskNo'] = helpdeskNo;
    data['schemeProviderWebsite'] = schemeProviderWebsite;
    data['termsAndConditions'] = termsAndConditions;
    return data;
  }
}

class SchemeFor {
  String? courseLevelID;
  String? courseLevelName;
  String? courseID;
  String? courseName;

  SchemeFor(
      {this.courseLevelID,
      this.courseLevelName,
      this.courseID,
      this.courseName});

  SchemeFor.fromJson(Map<String, dynamic> json) {
    courseLevelID = json['courseLevelID'];
    courseLevelName = json['courseLevelName'];
    courseID = json['courseID'];
    courseName = json['courseName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseLevelID'] = courseLevelID;
    data['courseLevelName'] = courseLevelName;
    data['courseID'] = courseID;
    data['courseName'] = courseName;
    return data;
  }
}

class Eligibility {
  List<PastEducation>? pastEducation;
  String? gender;
  String? familyIncome;
  String? state;
  String? district;
  String? cityOrBlockOrTaluka;
  String? nationality;
  String? religon;
  String? caste;
  String? courseLevelID;
  String? courseLevelName;
  String? courseName;
  String? scoreType;
  String? scoreValue;
  String? spocName;
  String? spocEmail;
  String? helpdeskNo;
  List? academicDetails;
  String? passingYear;
  bool? addtnlInfoReq;

  Eligibility(
      {this.pastEducation,
      this.gender,
      this.familyIncome,
      this.state,
      this.district,
      this.cityOrBlockOrTaluka,
      this.nationality,
      this.religon,
      this.caste,
      this.academicDetails,
      this.courseLevelID,
      this.courseLevelName,
      this.courseName,
      this.helpdeskNo,
      this.scoreType,
      this.scoreValue,
      this.spocEmail,
      this.spocName,
      this.passingYear,
      this.addtnlInfoReq});

  Eligibility.fromJson(Map<String, dynamic> json) {
    if (json['pastEducation'] != null) {
      pastEducation = <PastEducation>[];
      json['pastEducation'].forEach((v) {
        pastEducation!.add(PastEducation.fromJson(v));
      });
    }
    academicDetails = json['academicDetails'];
    addtnlInfoReq = json['addtnlInfoReq'];
    gender = json['gender'];
    familyIncome = json['familyIncome'];
    state = json['state'];
    district = json['district'];
    cityOrBlockOrTaluka = json['cityOrBlockOrTaluka'];
    nationality = json['nationality'];
    religon = json['religon'];
    caste = json['caste'];
    courseLevelID = json['courseLevelID'];
    courseLevelName = json['courseLevelName'];
    courseName = json['courseName'];
    scoreType = json['scoreType'];
    scoreValue = json['scoreValue'];
    spocName = json['spocName'];
    spocEmail = json['spocEmail'];
    helpdeskNo = json['helpDeskNo'];
    passingYear = json['Passing Year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pastEducation != null) {
      data['pastEducation'] = pastEducation!.map((v) => v.toJson()).toList();
    }
    data['gender'] = gender;
    data['familyIncome'] = familyIncome;
    data['addtnlInfoReq'] = addtnlInfoReq;
    data['state'] = state;
    data['district'] = district;
    data['cityOrBlockOrTaluka'] = cityOrBlockOrTaluka;
    data['nationality'] = nationality;
    data['religon'] = religon;
    data['caste'] = caste;
    data['courseLevelID'] = courseLevelID;
    data['courseLevelName'] = courseLevelName;
    data['courseName'] = courseName;
    data['scoreType'] = scoreType;
    data['scoreValue'] = scoreValue;
    data['spocName'] = spocName;
    data['spocEmail'] = spocEmail;
    data['helpDeskNo'] = helpdeskNo;
    data['Passing Year'] = passingYear;
    data['academicDetails'] = academicDetails;
    return data;
  }
}

class PastEducation {
  String? courseLevelID;
  String? courseLevelName;
  String? courseID;
  String? courseName;
  String? instituteName;
  String? instituteState;
  String? universityOrBoard;
  String? scoreType;
  String? scoreValue;

  PastEducation(
      {this.courseLevelID,
      this.courseLevelName,
      this.courseID,
      this.courseName,
      this.instituteName,
      this.instituteState,
      this.universityOrBoard,
      this.scoreType,
      this.scoreValue});

  PastEducation.fromJson(Map<String, dynamic> json) {
    courseLevelID = json['courseLevelID'];
    courseLevelName = json['courseLevelName'];
    courseID = json['courseID'];
    courseName = json['courseName'];
    instituteName = json['instituteName'];
    instituteState = json['instituteState'];
    universityOrBoard = json['universityOrBoard'];
    scoreType = json['scoreType'];
    scoreValue = json['scoreValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseLevelID'] = courseLevelID;
    data['courseLevelName'] = courseLevelName;
    data['courseID'] = courseID;
    data['courseName'] = courseName;
    data['instituteName'] = instituteName;
    data['instituteState'] = instituteState;
    data['universityOrBoard'] = universityOrBoard;
    data['scoreType'] = scoreType;
    data['scoreValue'] = scoreValue;
    return data;
  }
}
