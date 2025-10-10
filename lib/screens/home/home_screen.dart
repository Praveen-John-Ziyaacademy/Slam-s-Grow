import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/controller/home_screen_controller.dart';
import 'package:social_media/models/home_screen_models.dart';
import 'package:social_media/screens/home/profile_screen.dart';
import 'package:social_media/screens/home/referral_screen.dart';
import 'package:social_media/screens/home/task_screen.dart';
import 'package:social_media/screens/home/wallet_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  final List<Widget> _pages = [
    HomeTabContent(),
    TaskPage(),
    ReferralPage(),
    WalletPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(color: Colors.white),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF2070FF),
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_outlined),
                activeIcon: Icon(Icons.task),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                activeIcon: Icon(Icons.people),
                label: 'Referral',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                activeIcon: Icon(Icons.account_balance_wallet),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Home Tab Content (your existing home page content)
class HomeTabContent extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buidTopContainor(),
              Positioned(
                top: 264,
                left: 0,
                right: 0,
                child: _buildStatsCards(),
              ),
            ],
          ),
          const SizedBox(height: 120),
          _buildManageNow(),
          const SizedBox(height: 20),
          _buildPlans(),
          const SizedBox(height: 20),
          _buildTodaysTasks(),
          const SizedBox(height: 20),
          _buildRecentActivity(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buidTopContainor() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Container(
        height: 274,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF00BD4A), Color(0xFF2070FF)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 64),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: AppFonts.primaryFont(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'John Samual',
                          style: AppFonts.primaryFont(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Obx(
                      () => Stack(
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                          if (controller.notificationCount.value > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${controller.notificationCount.value}',
                                  style: AppFonts.primaryFont(
                                    color: Colors.white,
                                    fontSize: 8,
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
              const SizedBox(height: 30),
              Obx(
                () => Container(
                  height: 100,
                  width: 335,
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 6,
                    right: 19,
                    top: 13,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Balance',
                            style: AppFonts.primaryFont(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${controller.balance.value.toStringAsFixed(2)}',
                            style: AppFonts.primaryFont(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'This week',
                            style: AppFonts.primaryFont(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.trending_up,
                                color: Colors.greenAccent,
                                size: 20,
                              ),
                              Text(
                                '+\$${controller.weeklyIncrease.value.toStringAsFixed(0)}',
                                style: AppFonts.primaryFont(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'View Details >',
                            style: AppFonts.primaryFont(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard(
              Icons.task_alt,
              '${controller.tasksCount.value}',
              'Tasks',
              Colors.blue,
            ),
            _buildStatCard(
              Icons.emoji_events,
              '#${controller.rank.value}',
              'Rank',
              Colors.blue,
            ),
            _buildStatCard(
              Icons.bolt,
              '${controller.daysStreak.value}',
              'Days',
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppFonts.primaryFont(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: AppFonts.primaryFont(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildManageNow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage Now',
            style: AppFonts.primaryFont(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.viewTransactions(),
                  child: _buildManageCard('My Wallet', 'View Transactions', [
                    const Color(0xFF2070FF),
                    const Color(0xFF134399),
                  ], Icons.account_balance_wallet),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.viewLeaderboard(),
                  child: _buildManageCard('Leaderboard', 'Check your Rank', [
                    const Color(0xFF00BD4A),
                    const Color(0xFF005722),
                  ], Icons.leaderboard),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildManageCard(
    String title,
    String subtitle,
    List<Color> gradientColors,
    IconData icon,
  ) {
    return Container(
      width: 160,
      height: 100,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 19, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: 15),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 12,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: AppFonts.primaryFont(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppFonts.primaryFont(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Plans',
            style: AppFonts.primaryFont(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildPlanCard(
                'Starter Plan',
                'For beginners',
                const Color(0xFFB4D4FF),
              ),
              _buildPlanCard(
                'Pro Plan',
                'For active users',
                const Color(0xFFB4D4FF),
              ),
              _buildPlanCard(
                'Elite Plan',
                'For professionals',
                const Color(0xFFB4D4FF),
              ),
              _buildPlanCard(
                'Infinity Plan',
                'For Unlimited Access',
                const Color(0xFFB4D4FF),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard(String title, String subtitle, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.workspace_premium, color: Colors.white, size: 20),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppFonts.primaryFont(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: AppFonts.primaryFont(
                fontSize: 11,
                color: Colors.grey[700],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTodaysTasks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Todays Task\'s',
                style: AppFonts.primaryFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar('View All', 'Opening all tasks');
                },
                child: Text(
                  'View All >',
                  style: AppFonts.primaryFont(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(
            () => Column(
              children: List.generate(
                controller.tasks.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: _buildTaskCard(controller.tasks[index], index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    return Container(
      width: double.infinity,
      height: 79,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: AppFonts.primaryFont(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Earn ${task.points} Points',
                  style: AppFonts.primaryFont(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: task.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      task.status,
                      style: AppFonts.primaryFont(
                        fontSize: 8,
                        color: Colors.grey[700],
                      ),
                    ),
                    if (task.timeLeft.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      Text(
                        task.timeLeft,
                        style: AppFonts.primaryFont(
                          fontSize: 8,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.doTask(index),
            child: Container(
              width: 65,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF2F88FF),
              ),
              child: Center(
                child: Text(
                  'Do Task',
                  style: AppFonts.primaryFont(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: AppFonts.primaryFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar('View All', 'Opening all activities');
                },
                child: Text(
                  'View All >',
                  style: AppFonts.primaryFont(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 161,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF7FA),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActivityRow(
                  icon: Icons.check_circle_outline,
                  iconColor: Colors.green,
                  title: 'Task Completed',
                  subtitle: 'Morning workout challenge',
                  timeAgo: '15 hr ago',
                ),
                const SizedBox(height: 10),
                _buildActivityRow(
                  icon: Icons.emoji_events_outlined,
                  iconColor: Colors.blue,
                  title: 'Rank Updated',
                  subtitle: 'Rank moved up to #4',
                  timeAgo: '20 hr ago',
                ),
                const SizedBox(height: 10),
                _buildActivityRow(
                  icon: Icons.person_add_alt_1_outlined,
                  iconColor: Colors.green,
                  title: 'New follower',
                  subtitle: 'David joined your Network',
                  timeAgo: '22 hr ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String timeAgo,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFonts.primaryFont(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: AppFonts.primaryFont(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          timeAgo,
          style: AppFonts.primaryFont(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
