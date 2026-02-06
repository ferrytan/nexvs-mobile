import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/responsive.dart';

/// Navigation destination data for adaptive navigation
class NavDestination {
  const NavDestination({
    required this.icon,
    required this.label,
    required this.selectedIcon,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Adaptive navigation widget that switches between:
/// - BottomNavigationBar on mobile
/// - NavigationRail on tablet
/// - NavigationDrawer/NavigationRail on desktop
class AdaptiveNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavDestination> destinations;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? leading;
  final Widget? trailing;

  const AdaptiveNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.body,
    this.floatingActionButton,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        switch (screenType) {
          case ScreenType.mobile:
            return Scaffold(
              body: body,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: NavigationBar(
                currentIndex: currentIndex,
                onDestinationSelected: onDestinationSelected,
                destinations: destinations
                    .map((dest) => NavigationDestination(
                          icon: Icon(dest.icon),
                          selectedIcon: Icon(dest.selectedIcon),
                          label: dest.label,
                        ))
                    .toList(),
              ),
            );
          case ScreenType.tablet:
            return Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    currentIndex: currentIndex,
                    onDestinationSelected: onDestinationSelected,
                    leading: leading,
                    trailing: trailing,
                    labelType: NavigationRailLabelType.all,
                    destinations: destinations
                        .map((dest) => NavigationRailDestination(
                              icon: Icon(dest.icon),
                              selectedIcon: Icon(dest.selectedIcon),
                              label: Text(dest.label),
                            ))
                        .toList(),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(child: body),
                ],
              ),
              floatingActionButton: floatingActionButton,
            );
          case ScreenType.desktop:
          case ScreenType.wide:
            return Scaffold(
              body: Row(
                children: [
                  // Sidebar navigation for desktop
                  SizedBox(
                    width: 250,
                    child: Drawer(
                      child: Column(
                        children: [
                          // App header
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.videogame_asset,
                                  size: 32.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'NEXVS',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // Navigation items
                          ...destinations.map((dest) {
                            final isSelected = destinations.indexOf(dest) == currentIndex;
                            return ListTile(
                              selected: isSelected,
                              leading: Icon(isSelected ? dest.selectedIcon : dest.icon),
                              title: Text(dest.label),
                              onTap: () => onDestinationSelected(destinations.indexOf(dest)),
                            );
                          }),
                          const Spacer(),
                          if (trailing != null) trailing!,
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(child: body),
                ],
              ),
              floatingActionButton: floatingActionButton,
            );
        }
      },
    );
  }
}

/// Standard navigation destinations for NEXVS app
class NexvsDestinations {
  NexvsDestinations._();

  static const List<NavDestination> all = [
    NavDestination(
      icon: Icons.event_outlined,
      selectedIcon: Icons.event,
      label: 'Events',
    ),
    NavDestination(
      icon: Icons.emoji_events_outlined,
      selectedIcon: Icons.emoji_events,
      label: 'Tournaments',
    ),
    NavDestination(
      icon: Icons.build_outlined,
      selectedIcon: Icons.build,
      label: 'Builds',
    ),
    NavDestination(
      icon: Icons.person_outlined,
      selectedIcon: Icons.person,
      label: 'Profile',
    ),
  ];
}
