import 'package:flutter/widgets.dart';

/// Responsive breakpoints for different screen sizes
class Breakpoints {
  Breakpoints._();

  static const double mobile = 0;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1440;
}

/// Enum representing different screen size categories
enum ScreenType {
  mobile,
  tablet,
  desktop,
  wide;

  bool get isMobile => this == mobile;
  bool get isTablet => this == tablet;
  bool get isDesktop => this == desktop || this == wide;
  bool get isWide => this == wide;
}

/// Extension on BuildContext to easily check screen type
extension ResponsiveContext on BuildContext {
  /// Get the screen type based on current width
  ScreenType get screenType {
    final width = MediaQuery.of(this).size.width;
    if (width < Breakpoints.tablet) return ScreenType.mobile;
    if (width < Breakpoints.desktop) return ScreenType.tablet;
    if (width < Breakpoints.wide) return ScreenType.desktop;
    return ScreenType.wide;
  }

  /// Check if current screen is mobile
  bool get isMobile => screenType.isMobile;

  /// Check if current screen is tablet
  bool get isTablet => screenType.isTablet;

  /// Check if current screen is desktop (desktop or wide)
  bool get isDesktop => screenType.isDesktop;

  /// Check if current screen is wide
  bool get isWide => screenType.isWide;

  /// Check if current screen is mobile or tablet
  bool get isMobileOrTablet => isMobile || isTablet;

  /// Check if current screen is tablet or desktop
  bool get isTabletOrDesktop => isTablet || isDesktop;
}

/// Responsive utility class for layout decisions
class Responsive {
  Responsive._();

  /// Get the number of columns for a grid layout based on screen type
  static int gridColumns(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.mobile:
        return 1;
      case ScreenType.tablet:
        return 2;
      case ScreenType.desktop:
      case ScreenType.wide:
        return 3;
    }
  }

  /// Get the max content width for the current screen
  static double maxContentWidth(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.mobile:
        return double.infinity;
      case ScreenType.tablet:
        return 700;
      case ScreenType.desktop:
        return 1000;
      case ScreenType.wide:
        return 1200;
    }
  }

  /// Get the appropriate padding for the screen
  static EdgeInsets paddingForScreen(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.mobile:
        return const EdgeInsets.all(16);
      case ScreenType.tablet:
        return const EdgeInsets.all(24);
      case ScreenType.desktop:
      case ScreenType.wide:
        return const EdgeInsets.all(32);
    }
  }

  /// Get navigation rail width for desktop/tablet
  static double navigationRailWidth(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.mobile:
        return 0;
      case ScreenType.tablet:
        return 72;
      case ScreenType.desktop:
      case ScreenType.wide:
        return 80;
    }
  }

  /// Get sidebar width for desktop
  static double sidebarWidth(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.mobile:
      case ScreenType.tablet:
        return 0;
      case ScreenType.desktop:
        return 250;
      case ScreenType.wide:
        return 280;
    }
  }
}

/// Widget that builds different layouts based on screen type
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenType screenType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, context.screenType);
  }
}

/// Widget that constrains max width on larger screens
class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.alignment = Alignment.topCenter,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMaxWidth = maxWidth ?? Responsive.maxContentWidth(context.screenType);

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
        width: double.infinity,
        padding: padding,
        child: child,
      ),
    );
  }
}

/// Widget that shows different children based on screen type
class AdaptiveWidget extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? wide;

  const AdaptiveWidget({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = context.screenType;

    switch (screenType) {
      case ScreenType.mobile:
        return mobile ?? const SizedBox.shrink();
      case ScreenType.tablet:
        return tablet ?? mobile ?? const SizedBox.shrink();
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile ?? const SizedBox.shrink();
      case ScreenType.wide:
        return wide ?? desktop ?? tablet ?? mobile ?? const SizedBox.shrink();
    }
  }
}
