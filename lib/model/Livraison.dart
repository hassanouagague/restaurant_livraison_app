class Livraison {
  String? id;
  String? commandeId;
  String? cookerId;
  String? livreurId;
  String? idDetailsCommandes;
  String? etat;
  String? distance;
  String? temps;
  String? cout;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? addressClt;
  String? latClt;
  String? longClt;
  String? addressCkr;
  String? latCkr;
  String? longCkr;
  String? adresseCltid;
  String? codeCooker;
  String? telClt;
  String? telCkr;
  String? dcEtat;
  bool? notif;
  Livraison(
      {this.id,
      this.commandeId,
      this.cookerId,
      this.livreurId,
      this.idDetailsCommandes,
      this.etat,
      this.distance,
      this.temps,
      this.cout,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.addressClt,
      this.latClt,
      this.longClt,
      this.addressCkr,
      this.latCkr,
      this.longCkr,
      this.adresseCltid,
      this.codeCooker,
      this.telClt,
      this.telCkr,
      this.notif,
        this.dcEtat,
      });

  Livraison.fromJson(Map json) {
    id = json['id'];
    commandeId = json['commande_id'];
    cookerId = json['cooker_id'];
    livreurId = json['livreur_id'];
    idDetailsCommandes = json['id_details__commandes'];
    etat = json['etat'];
    distance = json['distance'];
    temps = json['temps'];
    cout = json['cout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    addressClt = json['addressClt'];
    latClt = json['latClt'];
    longClt = json['longClt'];
    addressCkr = json['addressCkr'];
    latCkr = json['latCkr'];
    longCkr = json['longCkr'];
    adresseCltid = json['adresseClt_id'];
    codeCooker = json["code_cooker"];
    telClt = json["telClt"];
    telCkr = json["telCkr"];
    dcEtat = json['dcEtat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['commande_id'] = commandeId;
    data['cooker_id'] = cookerId;
    data['livreur_id'] = livreurId;
    data['id_details__commandes'] = idDetailsCommandes;
    data['etat'] = etat;
    data['distance'] = distance;
    data['temps'] = temps;
    data['cout'] = cout;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['addressClt'] = addressClt;
    data['latClt'] = latClt;
    data['longClt'] = longClt;
    data['addressCkr'] = addressCkr;
    data['latCkr'] = latCkr;
    data['longCkr'] = longCkr;
    data['adresseClt_id'] = adresseCltid;
    data["code_cooker"] = codeCooker;
    data["telClt"] = telClt;
    data["telCkr"] = telCkr;
    data["dcEtat"] = dcEtat;
    return data;
  }
}
