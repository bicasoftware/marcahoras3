class Routes {
  static const String empregosDetail = "/add_details";
  static const String empregos = "/empregos";
  static const String relatorio = "/reports";
  static const String calendar = "/calendar";
  static const String home = "/home";
}

enum ERoutes {  
  empregosDetail("/add_details"),
  empregos("/empregos"),
  relatorio("/reports"),
  calendar("/calendar"),
  home("/home"),
  unknown("/unknown");

  final String route;

  const ERoutes(this.route);

  static ERoutes fromRouteName(String? routeName) {
    if (routeName == null) return ERoutes.unknown;

    return values.firstWhere(
      (it) => it.route == routeName,
      orElse: () => ERoutes.unknown,
    );
  }
}
