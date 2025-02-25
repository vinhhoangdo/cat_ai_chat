import 'package:cat_ai_gen/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatefulWidget {
  const AppView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
    _colorScheme.primary.withValues(alpha: 0.08),
    _colorScheme.surface,
  );
  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      value: 0,
      vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);
  bool controllerInitialized = false;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;

    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              leading: DrawerTransition(
                animation: _railAnimation,
                backgroundColor: Colors.transparent,
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ),
            ),
            body: widget.navigationShell,
            drawerScrimColor: Colors.transparent,
            drawer: Drawer(
              child: ListView.builder(
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(destinations[index].icon),
                    title: Text(destinations[index].label),
                    onTap: () {
                      _goBranch(index);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            bottomNavigationBar: NavigationBarTransition(
              animation: _barAnimation,
              backgroundColor: _backgroundColor,
              child: NavigationBar(
                selectedIndex: widget.navigationShell.currentIndex,
                indicatorColor: Colors.transparent,
                onDestinationSelected: _goBranch,
                destinations: destinations
                    .map<NavigationDestination>(
                      (d) => NavigationDestination(
                        icon: Icon(d.icon),
                        label: d.label,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        });
  }
}
