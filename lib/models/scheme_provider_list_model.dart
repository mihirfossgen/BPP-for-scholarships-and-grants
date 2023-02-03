import 'dart:convert';

List<SchemeProviderListModel> schemeProviderListModelFromJson(String str) =>
    List<SchemeProviderListModel>.from(
        json.decode(str).map((x) => SchemeProviderListModel.fromJson(x)));

String schemeProviderListModelToJson(List<SchemeProviderListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchemeProviderListModel {
  SchemeProviderListModel({
    this.id,
    this.schemeProviderId,
    this.schemeProviderName,
    this.schemeProviderWebsite,
    this.schemeProviderDescription,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.createdIp,
    this.updatedIp,
    this.active,
    this.deleted,
  });

  String? id;
  String? schemeProviderId;
  String? schemeProviderName;
  String? schemeProviderWebsite;
  String? schemeProviderDescription;
  int? createdAt;
  int? updatedAt;
  String? createdBy;
  dynamic updatedBy;
  String? createdIp;
  dynamic updatedIp;
  bool? active;
  bool? deleted;

  factory SchemeProviderListModel.fromJson(Map<String, dynamic> json) =>
      SchemeProviderListModel(
        id: json["id"] == null ? null : json["id"],
        schemeProviderId:
            json["schemeProviderId"] == null ? null : json["schemeProviderId"],
        schemeProviderName: json["schemeProviderName"] == null
            ? null
            : json["schemeProviderName"],
        schemeProviderWebsite: json["schemeProviderWebsite"] == null
            ? null
            : json["schemeProviderWebsite"],
        schemeProviderDescription: json["schemeProviderDescription"] == null
            ? null
            : json["schemeProviderDescription"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        updatedBy: json["updatedBy"],
        createdIp: json["createdIP"] == null ? null : json["createdIP"],
        updatedIp: json["updatedIP"],
        active: json["active"] == null ? null : json["active"],
        deleted: json["deleted"] == null ? null : json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "schemeProviderId": schemeProviderId == null ? null : schemeProviderId,
        "schemeProviderName":
            schemeProviderName == null ? null : schemeProviderName,
        "schemeProviderWebsite":
            schemeProviderWebsite == null ? null : schemeProviderWebsite,
        "schemeProviderDescription": schemeProviderDescription == null
            ? null
            : schemeProviderDescription,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "createdBy": createdBy == null ? null : createdBy,
        "updatedBy": updatedBy,
        "createdIP": createdIp == null ? null : createdIp,
        "updatedIP": updatedIp,
        "active": active == null ? null : active,
        "deleted": deleted == null ? null : deleted,
      };
}
