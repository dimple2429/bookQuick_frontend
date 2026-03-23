class AppImages {
  static String getServiceImage(String serviceName) {
    final name = serviceName.toLowerCase();

    if (name.contains("cleaning")) return "assets/cleaning.jpg";
    if (name.contains("plumbing")) return "assets/plumber.jpg";
    if (name.contains("electrician")) return "assets/electrician.jpg";
    if (name.contains("car wash")) return "assets/car.jpg";
    if (name.contains("carpenter")) return "assets/carpenter.jpg";
    if (name.contains("gardening")) return "assets/gardening.jpg";
    if (name.contains("laundry")) return "assets/laundry.jpg";
    if (name.contains("painting")) return "assets/painter.jpg";
    if (name.contains("salon")) return "assets/salon.jpg";
    if (name.contains("ac")) return "assets/ac.jpg";
    return "assets/cleaning.jpg";
  }
}