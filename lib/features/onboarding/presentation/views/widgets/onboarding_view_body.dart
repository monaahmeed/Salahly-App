import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/onboarding/data/models/onboarding_model.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  int _currentIndex = 0;

  void _onNextPressed() {
    if (_currentIndex < onboardingPages.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
    }
  }

  void _onPreviousSwipe() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = onboardingPages[_currentIndex];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                },
                style: ButtonStyle(
                 
                  foregroundColor: WidgetStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(WidgetState.hovered)) {
                      return AppTheme.primaryNavy; 
                    }
                    return Colors.blueGrey; 
                  }),
                ),
                child: Text(
                  'skip'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    _onNextPressed();
                  } else if (details.primaryVelocity! > 0) {
                    _onPreviousSwipe();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/onboarding-handyman.png',
                      height: MediaQuery.of(context).size.height * 0.35,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        key: ValueKey<int>(_currentIndex),
                        children: [
                          Text(
                            currentItem.titleKey.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryNavy,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentItem.descriptionKey.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 6),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? AppTheme.accentAmber
                            : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _currentIndex == onboardingPages.length - 1
                            ? 'get_started'.tr()
                            : 'next'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

List<OnboardingModel> onboardingPages = const [
  OnboardingModel(
    titleKey: 'onboarding_title_1',
    descriptionKey: 'onboarding_desc_1',
  ),
  OnboardingModel(
    titleKey: 'onboarding_title_2',
    descriptionKey: 'onboarding_desc_2',
  ),
  OnboardingModel(
    titleKey: 'onboarding_title_3',
    descriptionKey: 'onboarding_desc_3',
  ),
];
