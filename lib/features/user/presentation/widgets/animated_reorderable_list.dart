import 'package:flutter/material.dart';

/// A reusable animated reorderable list widget that provides smooth transitions
/// during reordering operations.
class AnimatedReorderableList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final String Function(T) itemKey;
  final bool Function(T)? isBeingMoved;
  final Duration animationDuration;
  final Duration waitBeforeReorder;
  final Duration waitAfterReorder;
  final double cardHeight;
  final double spacing;
  final void Function(String itemKey, int oldIndex, int newIndex)? onReorder;

  const AnimatedReorderableList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.itemKey,
    this.isBeingMoved,
    this.onReorder,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.waitBeforeReorder = const Duration(milliseconds: 1200),
    this.waitAfterReorder = const Duration(milliseconds: 600),
    this.cardHeight = 120.0,
    this.spacing = 8.0,
  });

  @override
  State<AnimatedReorderableList<T>> createState() =>
      _AnimatedReorderableListState<T>();
}

class _AnimatedReorderableListState<T> extends State<AnimatedReorderableList<T>>
    with TickerProviderStateMixin {
  final Map<String, AnimationController> _animationControllers = {};
  final Map<String, Animation<double>> _slideAnimations = {};
  final Map<String, Animation<double>> _fadeAnimations = {};

  @override
  void dispose() {
    for (final controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeAnimations(List<T> items) {
    final currentItemKeys = items.map((item) => widget.itemKey(item)).toSet();
    final existingItemKeys = _animationControllers.keys.toSet();

    for (final itemKey in existingItemKeys) {
      if (!currentItemKeys.contains(itemKey)) {
        _animationControllers[itemKey]?.dispose();
        _animationControllers.remove(itemKey);
        _slideAnimations.remove(itemKey);
        _fadeAnimations.remove(itemKey);
      }
    }

    for (final item in items) {
      final itemKey = widget.itemKey(item);
      if (!_animationControllers.containsKey(itemKey)) {
        final controller = AnimationController(
          duration: widget.animationDuration,
          vsync: this,
        );

        final slideAnimation = Tween<double>(
          begin: 0.0,
          end: 0.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOutCubic,
        ));

        final fadeAnimation = Tween<double>(
          begin: 1.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOutCubic,
        ));

        _animationControllers[itemKey] = controller;
        _slideAnimations[itemKey] = slideAnimation;
        _fadeAnimations[itemKey] = fadeAnimation;
      }
    }
  }

  Future<void> _animateReorder(
      String itemKey, int oldIndex, int newIndex) async {
    if (oldIndex == newIndex || !_animationControllers.containsKey(itemKey)) {
      return;
    }

    final controller = _animationControllers[itemKey]!;

    await Future.delayed(widget.waitBeforeReorder);

    final slideDistance =
        (newIndex - oldIndex) * (widget.cardHeight + widget.spacing);

    final fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.3),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: 0.3),
        weight: 60.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: 1.0),
        weight: 20.0,
      ),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    ));

    final slideAnimation = Tween<double>(
      begin: 0.0,
      end: slideDistance,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeInOutCubic),
    ));

    _slideAnimations[itemKey] = slideAnimation;
    _fadeAnimations[itemKey] = fadeAnimation;

    await controller.forward();

    await Future.delayed(widget.waitAfterReorder);

    controller.reset();
    _slideAnimations[itemKey] = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    ));

    _fadeAnimations[itemKey] = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _initializeAnimations(widget.items);

    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      final itemKey = widget.itemKey(item);

      if (widget.isBeingMoved?.call(item) == true) {
        final oldIndex = i;
        final newIndex = 0;

        if (oldIndex != newIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _animateReorder(itemKey, oldIndex, newIndex);
          });
        }
        break;
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final itemKey = widget.itemKey(item);

        final isBeingMoved = widget.isBeingMoved?.call(item) ?? false;

        if (isBeingMoved) {
          return AnimatedBuilder(
            animation: _animationControllers[itemKey] ??
                const AlwaysStoppedAnimation(0.0),
            builder: (context, child) {
              final slideOffset = _slideAnimations[itemKey]?.value ?? 0.0;
              final fadeOpacity = _fadeAnimations[itemKey]?.value ?? 1.0;

              return Transform.translate(
                offset: Offset(0, slideOffset),
                child: Opacity(
                  opacity: fadeOpacity,
                  child: widget.itemBuilder(context, item, index),
                ),
              );
            },
          );
        } else {
          return widget.itemBuilder(context, item, index);
        }
      },
    );
  }

  Future<void> triggerReorder(
      String itemKey, int oldIndex, int newIndex) async {
    await _animateReorder(itemKey, oldIndex, newIndex);
  }
}
