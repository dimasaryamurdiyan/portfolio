import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final BorderRadius? borderRadius;
  final bool showArrows;
  final bool showIndicators;
  final Color? placeholderColor;
  final BoxFit imageFit;

  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 200,
    this.borderRadius,
    this.showArrows = true,
    this.showIndicators = true,
    this.placeholderColor,
    this.imageFit = BoxFit.cover,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isHoveringLeft = false;
  bool _isHoveringRight = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _goToPage(_currentIndex - 1);
    }
  }

  void _nextPage() {
    if (_currentIndex < widget.images.length - 1) {
      _goToPage(_currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImages = widget.images.isNotEmpty;
    final hasMultipleImages = widget.images.length > 1;

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            // Image PageView or Placeholder
            if (hasImages)
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return _buildImage(widget.images[index], theme);
                },
              )
            else
              _buildPlaceholder(theme),

            // Navigation Arrows
            if (hasMultipleImages && widget.showArrows) ...[
              // Left Arrow
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringLeft = true),
                  onExit: (_) => setState(() => _isHoveringLeft = false),
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _currentIndex > 0 ? 1.0 : 0.3,
                      child: Semantics(
                        button: true,
                        enabled: _currentIndex > 0,
                        label: 'Previous image',
                        child: GestureDetector(
                          onTap: _previousPage,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isHoveringLeft
                                  ? theme.colorScheme.surface.withValues(alpha: 0.95)
                                  : theme.colorScheme.surface.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 24,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Right Arrow
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringRight = true),
                  onExit: (_) => setState(() => _isHoveringRight = false),
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _currentIndex < widget.images.length - 1 ? 1.0 : 0.3,
                      child: Semantics(
                        button: true,
                        enabled: _currentIndex < widget.images.length - 1,
                        label: 'Next image',
                        child: GestureDetector(
                          onTap: _nextPage,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isHoveringRight
                                  ? theme.colorScheme.surface.withValues(alpha: 0.95)
                                  : theme.colorScheme.surface.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            // Page Indicators
            if (hasMultipleImages && widget.showIndicators)
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => Semantics(
                      button: true,
                      label: 'Go to image ${index + 1}',
                      child: GestureDetector(
                        onTap: () => _goToPage(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? theme.colorScheme.primary
                                : theme.colorScheme.surface.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Image Counter Badge
            if (hasMultipleImages)
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.15),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    "${_currentIndex + 1}/${widget.images.length}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath, ThemeData theme) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: widget.placeholderColor ?? theme.colorScheme.surfaceContainerHighest,
      child: Image.asset(
        imagePath,
        fit: widget.imageFit,
        width: double.infinity,
        height: double.infinity,
        // Limit decoded image size for better memory performance
        cacheWidth: 800,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(theme);
        },
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      width: double.infinity,
      color: widget.placeholderColor ?? theme.colorScheme.surfaceContainerHighest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 8),
          Text(
            "No preview available",
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
