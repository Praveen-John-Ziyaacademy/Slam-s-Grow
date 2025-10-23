import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/controller/more/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFF4CAF50)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => Get.snackbar(
                              'Profile',
                              'Navigate to profile',
                              snackPosition: SnackPosition.BOTTOM,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.person_outline,
                                      color: Color(0xFF2196F3),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.userName.value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          controller.userEmail.value,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Account Section
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        iconColor: const Color(0xFF2196F3),
                        title: 'Profile',
                        onTap: () => Get.snackbar(
                          'Profile',
                          'Navigate to profile',
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                      ),
                      _buildMenuDivider(),

                      _buildMenuItem(
                        icon: Icons.task_outlined,
                        iconColor: const Color(0xFF4CAF50),
                        title: 'Task Preference',
                        onTap: () => Get.snackbar(
                          'Task Preference',
                          'Navigate to task preference',
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                      ),
                      _buildMenuDivider(),

                      Obx(
                        () => _buildMenuItem(
                          icon: Icons.language_outlined,
                          iconColor: const Color(0xFF2196F3),
                          title: 'Language Selection',
                          subtitle: controller.selectedLanguage.value,
                          onTap: () => Get.snackbar(
                            'Language',
                            'Navigate to language selection',
                            snackPosition: SnackPosition.BOTTOM,
                          ),
                        ),
                      ),
                    ]),

                    const SizedBox(height: 24),

                    const Text(
                      'Application',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _buildMenuItem(
                        icon: Icons.notifications_outlined,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'Notifications',
                        onTap: () => Get.snackbar(
                          'Notifications',
                          'Navigate to notifications',
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                      ),
                      _buildMenuDivider(),

                      _buildMenuItem(
                        icon: Icons.shield_outlined,
                        iconColor: const Color(0xFF4CAF50),
                        title: 'Privacy & Policy',
                        onTap: () => Get.snackbar(
                          'Privacy',
                          'Navigate to privacy & policy',
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                      ),
                      _buildMenuDivider(),

                      _buildMenuItem(
                        icon: Icons.help_outline,
                        iconColor: const Color(0xFFFF5722),
                        title: 'Help & Support',
                        onTap: () => Get.snackbar(
                          'Help',
                          'Navigate to help & support',
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                      ),
                    ]),

                    const SizedBox(height: 24),

                    // Session Section
                    const Text(
                      'Session',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _buildMenuItem(
                        icon: Icons.logout,
                        iconColor: const Color(0xFFF44336),
                        title: 'Log out',
                        titleColor: const Color(0xFFF44336),
                        onTap: () => controller.logout(),
                      ),
                    ]),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: .5),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: titleColor ?? Colors.black87,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
