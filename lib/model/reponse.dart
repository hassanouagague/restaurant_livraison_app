class Reponse {
  String? id;
  String? reclamationId;
  String? reponse;
  String? userId;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  
  Reponse(
      {this.id,
      this.reclamationId,
      this.reponse,
      this.userId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Reponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reclamationId = json['reclamation_id'];
    reponse = json['reponse'];
    userId = json['user_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reclamation_id'] = reclamationId;
    data['reponse'] = reponse;
    data['user_id'] = userId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
