import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/common/adaptive_navigation.dart';
import '../../widgets/common/empty_state_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _EventsTab(),
    const _TournamentsTab(),
    const _BuildsTab(),
    const _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigation(
      currentIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      destinations: NexvsDestinations.all,
      body: _pages[_currentIndex],
    );
  }
}

class _EventsTab extends StatelessWidget {
  const _EventsTab();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final useSliverAppBar = screenType.isDesktop;

        final body = MaxWidthContainer(
          padding: Responsive.paddingForScreen(screenType),
          child: Column(
            children: [
              // Search and filter bar
              if (screenType.isDesktop) _DesktopSearchBar(),
              // Content
              Expanded(
                child: Center(
                  child: EmptyStateWidget(
                    icon: Icons.event_outlined,
                    title: 'No Events Yet',
                    subtitle: 'Events will be displayed here',
                    actionLabel: screenType.isMobile ? null : 'Create Event',
                  ),
                ),
              ),
            ],
          ),
        );

        if (useSliverAppBar) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Events'),
                floating: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // TODO: Open search
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // TODO: Open filter
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(child: body),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Events'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Open search
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // TODO: Open filter
                },
              ),
            ],
          ),
          body: body,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // TODO: Create event
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Event'),
          ),
        );
      },
    );
  }
}

class _TournamentsTab extends StatelessWidget {
  const _TournamentsTab();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final body = MaxWidthContainer(
          padding: Responsive.paddingForScreen(screenType),
          child: Center(
            child: EmptyStateWidget(
              icon: Icons.emoji_events_outlined,
              title: 'No Tournaments Yet',
              subtitle: 'Tournaments will be displayed here',
            ),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tournaments'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Open search
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // TODO: Open filter
                },
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }
}

class _BuildsTab extends StatelessWidget {
  const _BuildsTab();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final columns = Responsive.gridColumns(screenType);
        final body = MaxWidthContainer(
          padding: Responsive.paddingForScreen(screenType),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: screenType.isMobile ? 0.8 : 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 0,
            itemBuilder: (context, index) => const SizedBox.shrink(),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Builds'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Open search
                },
              ),
            ],
          ),
          body: body,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: Create build
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final body = MaxWidthContainer(
          padding: Responsive.paddingForScreen(screenType),
          child: Center(
            child: EmptyStateWidget(
              icon: Icons.person_outlined,
              title: 'Profile',
              subtitle: 'User profile will be displayed here',
            ),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // TODO: Open settings
                },
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }
}

/// Desktop search bar for top of content areas
class _DesktopSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              hintText: 'Search...',
              leading: const Icon(Icons.search),
            ),
          ),
          SizedBox(width: 16.w),
          FilledButton.tonalIcon(
            onPressed: () {
              // TODO: Open filter
            },
            icon: const Icon(Icons.filter_list),
            label: const Text('Filter'),
          ),
        ],
      ),
    );
  }
}
