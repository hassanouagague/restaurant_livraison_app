class Penalite {
  String? id;
  String? commandeId;
  String? transactionId;
  String? userId;
  String? userType;
  String? somme;
  String? pinalite;
  String? etat;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Penalite(
      {this.id,
      this.commandeId,
      this.transactionId,
      this.userId,
      this.userType,
      this.somme,
      this.pinalite,
      this.etat,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Penalite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commandeId = json['commande_id'];
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    somme = json['somme'];
    pinalite = json['pinalite'];
    etat = json['etat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['commande_id'] = commandeId;
    data['transaction_id'] = transactionId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['somme'] = somme;
    data['pinalite'] = pinalite;
    data['etat'] = etat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}