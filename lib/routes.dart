class Routes {
  static const String empregosDetail = "/add_details";
  static const String relatorio = "/reports";
  static const String calendar = "/calendar";
}

enum ERoutes {  
  empregosDetail("/add_details"),
  relatorio("/reports"),
  calendar("/calendar"),
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
