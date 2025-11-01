import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/components/bottom_bar.dart';
import 'package:social_media/controller/home_screen_controller.dart';
import 'package:social_media/l10n/app_localizations.dart';
import 'package:social_media/models/home_screen_models.dart';
import 'package:social_media/screens/quick_task/add_sharing_screen.dart';
import 'package:social_media/screens/quick_task/post_screen.dart';
import 'package:social_media/screens/quick_task/survey_screen.dart';

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
              _buidTopContainor(context),
              Positioned(
                top: 264,
                left: 0,
                right: 0,
                child: _buildStatsCards(context),
              ),
            ],
          ),
          const SizedBox(height: 120),
          _buildManageNow(context),
          const SizedBox(height: 20),
          _buildQuickTask(context),
          const SizedBox(height: 20),
          _buildTodaysTasks(context),
          const SizedBox(height: 20),
          _buildRecentActivity(context),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buidTopContainor(BuildContext context) {
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
                          AppLocalizations.of(context)!.onboard_welcome_back,
                          style: AppFonts.primaryFont(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.onboard_home_title,
                          style: AppFonts.primaryFont(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
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
              const SizedBox(height: 23),
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
                            AppLocalizations.of(context)!.onboard_available_bal,
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
                            AppLocalizations.of(context)!.onboard_view_details,
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

  Widget _buildStatsCards(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth - 60) / 3; // 20px padding + spacing between 3 cards

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(
              context,
              Icons.task_alt,
              '${controller.tasksCount.value}',
              AppLocalizations.of(context)!.onboard_tasks_h1,
              Colors.blue,
              cardWidth,
            ),
            _buildStatCard(
              context,
              Icons.emoji_events,
              '#${controller.rank.value}',
              AppLocalizations.of(context)!.onboard_rank_h1,
              Colors.blue,
              cardWidth,
            ),
            _buildStatCard(
              context,
              Icons.bolt,
              '${controller.daysStreak.value}',
              AppLocalizations.of(context)!.onboard_days_h1,
              Colors.blue,
              cardWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
    double width,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: AppFonts.primaryFont(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppFonts.primaryFont(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildManageNow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.onboard_manage_now,
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
                  child: _buildManageCard(
                    context,
                    AppLocalizations.of(context)!.onboard_my_wallet,
                    AppLocalizations.of(context)!.onboard_view_transactions,
                    [const Color(0xFF2070FF), const Color(0xFF134399)],
                    Icons.account_balance_wallet,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.viewLeaderboard(),
                  child: _buildManageCard(
                    context,
                    AppLocalizations.of(context)!.onboard_leaderboard,
                    AppLocalizations.of(context)!.onboard_check_your_rank,
                    [const Color(0xFF00BD4A), const Color(0xFF005722)],
                    Icons.leaderboard,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTask(BuildContext context) {
    final quickTasks = [
      {
        'icon': 'assets/advertisiment-stroke-rounded 1.svg',
        'label': AppLocalizations.of(context)!.onboard_ad_sharing,
        'route': AdSharingTasksPage(),
      },
      {
        'icon': 'assets/aids-stroke-rounded 1.svg',
        'label': AppLocalizations.of(context)!.onboard_social,
        'route': PostScreen(),
      },
      {
        'icon': 'assets/add-to-list-stroke-rounded 1.svg',
        'label': AppLocalizations.of(context)!.onboard_survey,
        'route': SurveyHomePage(),
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 100) / 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Title text with ellipsis
          Text(
            AppLocalizations.of(context)!.onboard_quick_task,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.primaryFont(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FFFD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
                width: .4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 12,
                  spacing: 12,
                  children: quickTasks.map((task) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => task['route'] as Widget,
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Container(
                        width: cardWidth,
                        height: 110,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xFF00BD4A), Color(0xFF2070FF)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              task['icon'] as String,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(height: 8),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  task['label'] as String,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.primaryFont(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageCard(
    BuildContext context,
    String title,
    String subtitle,
    List<Color> gradientColors,
    IconData icon,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      height: isSmallScreen ? 90 : 100,
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
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.primaryFont(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.primaryFont(color: Colors.white70, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysTasks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.onboard_todays_task,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.primaryFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar('View All', 'Opening all tasks');
                },
                child: Text(
                  AppLocalizations.of(context)!.onboard_view_all,
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
                  child: _buildTaskCard(
                    context,
                    controller.tasks[index],
                    index,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.23;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.primaryFont(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${AppLocalizations.of(context)!.onboard_earn} ${task.points} ${AppLocalizations.of(context)!.onboard_points}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.primaryFont(
                    fontSize: isSmallScreen ? 11 : 12,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 6),

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
                    Expanded(
                      child: Text(
                        task.status,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.primaryFont(
                          fontSize: isSmallScreen ? 9 : 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    if (task.timeLeft.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          task.timeLeft,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.primaryFont(
                            fontSize: isSmallScreen ? 9 : 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                if (index != 0) ...[
                  const SizedBox(height: 4),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double lineWidth = (task.status.length * 7)
                          .toDouble()
                          .clamp(40, constraints.maxWidth);
                      return Stack(
                        children: [
                          Container(
                            width: lineWidth,
                            height: 1,
                            color: Colors.grey[400],
                          ),

                          Container(
                            width: lineWidth * 0.4,
                            height: 1,
                            color: Colors.blue,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ),
          ),

          SizedBox(width: isSmallScreen ? 8 : 12),

          GestureDetector(
            onTap: () => controller.doTask(index),
            child: Container(
              width: buttonWidth.clamp(60, 90),
              height: isSmallScreen ? 33 : 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF2F88FF),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.onboard_do_task,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppFonts.primaryFont(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.onboard_recent_activity,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: AppFonts.primaryFont(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 20),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.onboard_view_all,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: AppFonts.primaryFont(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 10 : 15,
              horizontal: isSmallScreen ? 10 : 15,
            ),
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
