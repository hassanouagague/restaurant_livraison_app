class Notificationn {
  String? id;
  String? userId;
  String? userType;
  String? typeNotif;
  String? typeId;
  String? msg;
  String? etat;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? check;
  Notificationn(
      {this.id,
      this.userId,
      this.userType,
      this.typeNotif,
      this.typeId,
      this.msg,
      this.etat,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.check
      });
  
  Notificationn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    typeNotif = json['type_notif'];
    typeId = json['type_id'];
    msg = json['msg'];
    etat = json['etat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['type_notif'] = typeNotif;
    data['type_id'] = typeId;
    data['msg'] = msg;
    data['etat'] = etat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
  
}
