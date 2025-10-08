import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media/auth_screen/login_screen.dart';
import 'package:social_media/colors/colors.dart';
import 'package:social_media/models/onboarding_models.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      heading: "Welcome !",
      title: "Complete simple tasks",
      description: "Complete small tasks and activities to start earnings ",
      svgPath: "assets/WELCOME.svg",
    ),
    OnboardingData(
      heading: "Earn !",
      title: " Real rewards and cash.",
      description:
          "Get paid in cash for the tasks you complete and offers you engage with.",
      svgPath: "assets/EARN.svg",
    ),
    OnboardingData(
      heading: "Join !",
      title: "Our community and grow.",
      description: "Connect with other users and elevate your user level",
      svgPath: "assets/JOIN.svg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (_currentIndex != onboardingData.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () => _navigateToLogin(),
                    child: Text(
                      'Skip>>',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  _animationController.reset();
                  _animationController.forward();
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildOnboardingPage(onboardingData[index]),
                    ),
                  );
                },
              ),
            ),

            // Bottom Section
            Padding(
              padding: EdgeInsets.all(30),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  children: [
                    // Page Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingData.length,
                        (index) => _buildDot(index),
                      ),
                    ),

                    SizedBox(height: 40),

                    SizedBox(
                      width: 233,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _currentIndex == onboardingData.length - 1
                              ? _navigateToLogin
                              : _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _currentIndex == onboardingData.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
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

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 350,
            height: 260,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(data.svgPath),
            ),
          ),

          SizedBox(height: 40),

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
              height: 1.2,
            ),
          ),

          SizedBox(height: 20),

          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: _currentIndex == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? AppColors.primaryDark
            : AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
