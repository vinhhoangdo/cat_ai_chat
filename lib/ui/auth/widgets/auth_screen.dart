import 'package:cat_ai_gen/config/assets.dart';
import 'package:cat_ai_gen/core/core.dart';
import 'package:cat_ai_gen/ui/auth/auth.dart';
import 'package:cat_ai_gen/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.signInViewModel,
  });

  final AuthViewModel signInViewModel;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: Duration(seconds: 2),
        reverse: true,
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppAssets.onboards.map((asset) {
      return precacheImage(AssetImage(asset), context);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CarouselView.weighted(
            scrollDirection: kIsWeb ? Axis.horizontal : Axis.vertical,
            controller: controller,
            itemSnapping: true,
            consumeMaxWeight: false,
            flexWeights: [2, 7, 2],
            children: AppAssets.onboards.map<Widget>((asset) {
              return Image.asset(
                asset,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
          Positioned(
            bottom: 10,
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1.0,
                        transform: _SlideGradientTransform(
                          percent: _animationController.value,
                        ),
                        colors: <Color>[
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.surface,
                          Theme.of(context).colorScheme.inversePrimary,
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: CatButton(
                      onPressed: () async {
                        await _showSignInDialog(
                          content:
                              AuthDialogContent(viewModel: widget.signInViewModel),
                        );
                      },
                      type: ButtonType.outlined,
                      child: Text(
                        context.locale.signIn,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  Future<void> _showSignInDialog({required Widget content}) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: AlertDialog.adaptive(
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            contentPadding: EdgeInsets.all(24.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              adaptiveAction(
                context: context,
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
            ],
            content: content,
          ),
        );
      },
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double percent;

  const _SlideGradientTransform({required this.percent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.height * percent, 0, 0);
  }
}
