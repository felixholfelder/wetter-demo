class LayoutUtils {
  static int MOBILE_WIDTH = 768;
  static int DESKTOP_WIDTH = 1200;

  static bool isMobile(double width) => width < MOBILE_WIDTH;
  static bool isTablet(double width) => width >= MOBILE_WIDTH && width <= DESKTOP_WIDTH;
  static bool isDesktop(double width) => width > DESKTOP_WIDTH;
}