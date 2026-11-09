class Authorized {
  static bool isAuthenticated = false;
  static bool isGuest = false;

  static void authenticate() {
    Authorized.isAuthenticated = true;
  }

  static bool allowedToEdit() {
    return isAuthenticated && !isGuest;
  }
}
