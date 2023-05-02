class Reglement {
  String? id;
  String? livreurId;
  String? montant;
  String? periode;
  String? etat;
  String? createdAt;
  Stream? updatedAt;
  String? deletedAt;

  Reglement(
      {this.id,
      this.livreurId,
      this.montant,
      this.periode,
      this.etat,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Reglement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    livreurId = json['livreur_id'];
    montant = json['montant'];
    periode = json['periode'];
    etat = json['etat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['livreur_id'] = livreurId;
    data['montant'] = montant;
    data['periode'] = periode;
    data['etat'] = etat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}