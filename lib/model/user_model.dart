import 'package:food_livraison_app/model/date.dart';

import '../constant/path.dart';

class UserModel {
  String? id;
  String? etat;
  String? civilite;
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? adresse;
  String? rib;
  String? kbis;
  String? etatKbis;
  String? image;
  String? transport;
  String? offre;
  String? villeId;
  String? lat;
  String? long;
  String? rayon;
  String? lastVisite;
  String? stripeId;
  String? detailsSubmitted;
  String? emailVerifiedAt;
  String? password;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<DateDis>? dates;
  bool? et;
  String? message;
  String? nbrSignal;
  UserModel(
      {this.id,
      this.etat,
      this.civilite,
      this.nom,
      this.prenom,
      this.email,
      this.telephone,
      this.adresse,
      this.rib,
      this.kbis,
      this.etatKbis,
      this.image,
      this.transport,
      this.offre,
      this.villeId,
      this.lat,
      this.long,
      this.rayon,
      this.lastVisite,
      this.stripeId,
      this.detailsSubmitted,
      this.emailVerifiedAt,
      this.password,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.dates,
      this.message,
      this.et,
      this.nbrSignal});

  String toQueryParams() {
    String res = Path.register;
    return "$res&email=$email&nom=$nom&prenom=$prenom&password=$password";
  }

  //for login
  Map<String, dynamic> loginToJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    return data;
  }

  //get User
  Map<String, dynamic> getuserToJson() {
    final Map<String, dynamic> data = {};
    data['userID'] = id;
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    return data;
  }

  //for update compte
  Map<String, dynamic> infoToJson() {
    final Map<String, dynamic> data = {};
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    data['part'] = "info";
    data['civilite'] = civilite;
    data["nom"] = nom;
    data["prenom"] = prenom;
    data['email'] = email;
    data['telephone'] = telephone;
    data['userID'] = id;

    return data;
  }

  Map<String, dynamic> passToJson() {
    final Map<String, dynamic> data = {};
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    data['part'] = "pwd";
    data["password"] = password;
    data['userID'] = id;

    return data;
  }

  Map<String, dynamic> indisponibiliteToJson() {
    final Map<String, dynamic> data = {};
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    data['part'] = "indisponibilite";
    data["dates"] = data;
    data['userID'] = id;

    return data;
  }

  Map<String, dynamic> adresseToJson() {
    final Map<String, dynamic> data = {};
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    data['part'] = "adresse";
    data['adresse'] = adresse;
    data["lat"] = lat;
    data["long"] = long;
    data["rayon"] = rayon;
    data['userID'] = id;
    data['villeID'] = villeId;
    return data;
  }

  Map<String, dynamic> traspToJson() {
    final Map<String, dynamic> data = {};
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    data['part'] = "trsprt";
    data["transport"] = transport;
    data['userID'] = id;

    return data;
  }

  Map<String, dynamic> disponibiliteToJson(String date) {
    final Map<String, dynamic> data = {};
    data['KEY'] = "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg";
    data['part'] = "indisponibilite";
    data["dates"] = date;
    data['userID'] = id;

    return data;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    List date = json["dates"] ?? [];

    if (date.isEmpty) {
      dates = [];
    } else {
      dates = [];
      for (Map<String, dynamic> element in date) {
        dates!.add(DateDis.fromJson(element));
      }
    }

    id = json["user"]['id'];
    etat = json["user"]['etat'];
    civilite = json["user"]['civilite'];
    nom = json["user"]['nom'];
    prenom = json["user"]['prenom'];
    email = json["user"]['email'];
    telephone = json["user"]['telephone'];
    adresse = json["user"]['adresse'];
    rib = json["user"]['rib'];

    kbis = json["user"]['kbis'];
    etatKbis = json["user"]['etat_kbis'];

    image = json["user"]['image'];
    transport = json["user"]['transport'];
    offre = json["user"]['offre'];
    villeId = json["user"]['ville_id'];
    lat = json["user"]['lat'];
    long = json["user"]['long'];
    rayon = json["user"]['rayon'];
    lastVisite = json["user"]['last_visite'];
    stripeId = json["user"]['stripe_id'];
    detailsSubmitted = json["user"]['details_submitted'];
    emailVerifiedAt = json["user"]['email_verified_at'];
    rememberToken = json["user"]['remember_token'];
    createdAt = json["user"]['created_at'];
    updatedAt = json["user"]['updated_at'];
    deletedAt = json["user"]['deleted_at'];
  }
  UserModel.getUserfromJson(Map<String, dynamic> json) {
    List date = json["dates"] ?? [];

    if (date.isEmpty) {
      dates = [];
    } else {
      dates = [];
      for (Map<String, dynamic> element in date) {
        dates!.add(DateDis.fromJson(element));
      }
    }
    print("nbrsModel ${json['NbrSignal']['NbrSignal']}");
    nbrSignal = json['NbrSignal']['NbrSignal'] ?? "0";
    id = json["data"]['id'];
    etat = json["data"]['etat'];
    civilite = json["data"]['civilite'];
    nom = json["data"]['nom'];
    prenom = json["data"]['prenom'];
    email = json["data"]['email'];
    telephone = json["data"]['telephone'];
    adresse = json["data"]['adresse'];
    rib = json["data"]['rib'];
    kbis = json["data"]['kbis'];
    etatKbis = json["data"]['etat_kbis'];
    image = json["data"]['image'];
    transport = json["data"]['transport'];
    offre = json["data"]['offre'];
    villeId = json["data"]['ville_id'];
    lat = json["data"]['lat'];
    long = json["data"]['long'];
    rayon = json["data"]['rayon'];
    lastVisite = json["data"]['last_visite'];
    stripeId = json["data"]['stripe_id'];
    detailsSubmitted = json["data"]['details_submitted'];
    emailVerifiedAt = json["data"]['email_verified_at'];
    rememberToken = json["data"]['remember_token'];
    createdAt = json["data"]['created_at'];
    updatedAt = json["data"]['updated_at'];
    deletedAt = json["data"]['deleted_at'];
  }
  UserModel.fromJsonlocal(Map<String, dynamic> json) {
    List date = json["dates"] ?? [];

    if (date.isEmpty) {
      dates = [];
    } else {
      print("locallocallocallocal");
      dates = [];
      for (Map<String, dynamic> element in date) {
        dates!.add(DateDis.fromJson(element));
      }
    }
    id = json['id'];
    etat = json['etat'];
    civilite = json['civilite'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    telephone = json['telephone'];
    adresse = json['adresse'];
    rib = json['rib'];
    kbis = json['kbis'];
    etatKbis = json['etat_kbis'];
    image = json['image'];
    transport = json['transport'];
    offre = json['offre'];
    villeId = json['ville_id'];
    lat = json['lat'];
    long = json['long'];
    rayon = json['rayon'];
    lastVisite = json['last_visite'];
    stripeId = json['stripe_id'];
    detailsSubmitted = json['details_submitted'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    nbrSignal = json['nbrSignal'];
    // dates = DateDis.fromJson(json["dates"]);
    // et = json['et'];
    // message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    List date = [];
    if (dates != null) {
      if (dates!.isNotEmpty) {
        for (DateDis element in dates!) {
          date.add(element.toJson());
        }
      }
    }

    data['id'] = id;
    data['etat'] = etat;
    data['civilite'] = civilite;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['email'] = email;
    data['telephone'] = telephone;
    data['adresse'] = adresse;
    data['rib'] = rib;
    data['kbis'] = kbis;
    data['etat_kbis'] = etatKbis;
    data['image'] = image;
    data['transport'] = transport;
    data['offre'] = offre;
    data['ville_id'] = villeId;
    data['lat'] = lat;
    data['long'] = long;
    data['rayon'] = rayon;
    data['last_visite'] = lastVisite;
    data['stripe_id'] = stripeId;
    data['details_submitted'] = detailsSubmitted;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;

    data['dates'] = date;
    data['message'] = message;
    data['et'] = et;
    data['nbrSignal'] = nbrSignal;

    return data;
  }
}
