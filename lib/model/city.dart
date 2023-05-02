class City {
  String? id;
  String? nom;
  String? code;
  String? etat;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
 
  City(
      {this.id,
      this.nom,
      this.code,
      this.etat,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      
      });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    code = json['code'];
    etat = json['etat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['code'] = code;
    data['etat'] = etat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    
    return data;
  }
}
