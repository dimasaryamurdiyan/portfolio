// Section describing the user's expertise.
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';

class WhatIDoSection extends StatelessWidget {
  const WhatIDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surface.withValues(alpha: .8),
            theme.colorScheme.primaryContainer.withValues(alpha: .1),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isLargeScreen ? 100 : 60,
          horizontal: isLargeScreen ? 120 : 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Title
            Text(
              "About Me?",
              style: TextStyle(
                fontFamily: 'Black Han Sans',
                fontSize: isLargeScreen ? 40 : 28,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),

            // Subtitle
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.onSurface,
                    theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Content Card
            Container(
              constraints: BoxConstraints(
                maxWidth: isLargeScreen ? 1200 : double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: .1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: .1),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(isLargeScreen ? 48 : 32),
                child: isLargeScreen
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Enhanced Image with decorative elements
                          Stack(
                            children: [
                              // Decorative background
                              Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      theme.colorScheme.primary.withValues(alpha: .1),
                                      theme.colorScheme.secondary.withValues(alpha: .1),
                                    ],
                                  ),
                                ),
                              ),
                              // Main image
                              Positioned(
                                top: 20,
                                left: 20,
                                child: Container(
                                  width: 240,
                                  height: 240,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.surface,
                                      width: 6,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.shadow.withValues(alpha: .2),
                                        blurRadius: 25,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/my.jpeg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                theme.colorScheme.primary.withValues(alpha: .3),
                                                theme.colorScheme.secondary.withValues(alpha: .3),
                                              ],
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            size: 80,
                                            color: theme.colorScheme.onSurface.withValues(alpha: .5),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 60),

                          // Enhanced Text Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  PortfolioData.aboutMe,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.7,
                                    color: theme.colorScheme.onSurface.withValues(alpha: .8),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Call to action or highlight
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: theme.colorScheme.primaryContainer.withValues(alpha: .3),
                                    border: Border.all(
                                      color: theme.colorScheme.primary.withValues(alpha: .2),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lightbulb_outline,
                                        color: theme.colorScheme.primary,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          "Passionate about creating innovative solutions that make a difference",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          // Mobile Image
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.primary.withValues(alpha: .1),
                                      theme.colorScheme.secondary.withValues(alpha: .1),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.colorScheme.surface,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.shadow.withValues(alpha: .2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/my.jpeg',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              theme.colorScheme.primary.withValues(alpha: .3),
                                              theme.colorScheme.secondary.withValues(alpha: .3),
                                            ],
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          size: 60,
                                          color: theme.colorScheme.onSurface.withValues(alpha: .5),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Mobile Text Content
                          Text(
                            PortfolioData.aboutMe,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.7,
                              color: theme.colorScheme.onSurface.withValues(alpha: .8),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // Mobile highlight
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: theme.colorScheme.primaryContainer.withValues(alpha: .3),
                              border: Border.all(
                                color: theme.colorScheme.primary.withValues(alpha: .2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: theme.colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Passionate about creating innovative solutions",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}