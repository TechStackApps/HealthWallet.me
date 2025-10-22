import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class ScanPreviewCard extends StatelessWidget {
  final List<String> imagePaths;
  final int currentPageIndex;
  final PageController pageController;
  final Function(int) onPageChanged;

  const ScanPreviewCard({
    super.key,
    required this.imagePaths,
    required this.currentPageIndex,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePaths.length > 1)
            _PageIndicator(
              currentPage: currentPageIndex,
              totalPages: imagePaths.length,
              pageController: pageController,
            ),
          _ImagePageView(
            imagePaths: imagePaths,
            pageController: pageController,
            onPageChanged: onPageChanged,
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final PageController pageController;

  const _PageIndicator({
    required this.currentPage,
    required this.totalPages,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: currentPage > 0
                ? IconButton(
                    icon: const Icon(Icons.chevron_left, size: 16),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 24,
                    ),
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                : null,
          ),
          Expanded(
            child: Center(
              child: Text(
                'Page ${currentPage + 1} of $totalPages',
                style: AppTextStyle.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 32,
            child: currentPage < totalPages - 1
                ? IconButton(
                    icon: const Icon(Icons.chevron_right, size: 16),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 24,
                    ),
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _ImagePageView extends StatelessWidget {
  final List<String> imagePaths;
  final PageController pageController;
  final Function(int) onPageChanged;

  const _ImagePageView({
    required this.imagePaths,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(Insets.normal),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(imagePaths[index]),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 40, color: Colors.red),
                          SizedBox(height: 8),
                          Text('Failed to load image'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
