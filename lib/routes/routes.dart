import 'package:get/get.dart';

import '/view/profile/reclamation/add_reclamation.dart';
import '/view/profile/reclamation/reclamation.dart';
import '/view/app.dart';
import '/view/auth/login.dart';
import '/view/livraison_inst.dart';
import '/view/penalite_view.dart';
import '/view/reglement_view.dart';
import '/view/profile/work_area.dart';
import '/view/livraison_pre.dart';
import '/view/profile/password.dart';
import '/view/profile/info.dart';
import '/view/auth/register.dart';
import '/view/splash.dart';

import 'route_constant.dart';

abstract class Routes {
  static final List<GetPage<dynamic>> route = [
    GetPage(name: RouteConstant.home, page: () => App(pageindex: 0)),

    GetPage(
      name: RouteConstant.register,
      page: () => Register(),
    ),
    GetPage(name: RouteConstant.login, page: () => Login()),
    GetPage(name: RouteConstant.profile, page: () => App(pageindex: 3)),
    GetPage(name: RouteConstant.splash, page: () => const Splash()),
    GetPage(name: RouteConstant.info, page: () => Info()),
    GetPage(name: RouteConstant.pass, page: () => Password()),
    GetPage(name: RouteConstant.workArea, page: () => WorkArea()),
    // GetPage(name: RouteConstant.transport, page: () => Transport()),
    GetPage(name: RouteConstant.livraisonPre, page: () => LivraisonPre()),
    GetPage(name: RouteConstant.livraisonInst, page: () => LivraisonInst()),
    GetPage(name: RouteConstant.reglement, page: () => ReglementView()),
    GetPage(name: RouteConstant.penalite, page: () => PenaliteView()),  
    GetPage(name: RouteConstant.addReclamation, page: () => AddReclamation()),
    GetPage(name: RouteConstant.reclamation, page: () => Reclamation()),
  ];
}
