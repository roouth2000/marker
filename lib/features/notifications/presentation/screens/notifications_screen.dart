import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_Notification> _notifications = [
    _Notification(
      icon: Icons.receipt_long_outlined,
      iconColor: AppColors.primary,
      iconBg: AppColors.infoLight,
      title: 'Invoice Overdue',
      body: 'INV-1042 from Anand Kirana Stores is overdue by 3 days. ₹12,450 pending.',
      time: '2 min ago',
      isUnread: true,
      tag: 'Invoice',
    ),
    _Notification(
      icon: Icons.file_download_outlined,
      iconColor: AppColors.success,
      iconBg: AppColors.successLight,
      title: 'Payment Received',
      body: 'Bharath Hardware paid ₹5,400 against INV-1041. Balance cleared.',
      time: '1 hr ago',
      isUnread: true,
      tag: 'Receipt',
    ),
    _Notification(
      icon: Icons.warning_amber_rounded,
      iconColor: AppColors.warning,
      iconBg: AppColors.warningLight,
      title: 'Low Stock Alert',
      body: 'Basmati Rice 25kg is running low. Only 3 bags remaining in stock.',
      time: '3 hrs ago',
      isUnread: true,
      tag: 'Inventory',
    ),
    _Notification(
      icon: Icons.person_add_alt_1_rounded,
      iconColor: const Color(0xFF8B5CF6),
      iconBg: const Color(0xFFEDE9FE),
      title: 'New Party Added',
      body: 'Everest Mart was added to your party list. Start billing now.',
      time: '5 hrs ago',
      isUnread: false,
      tag: 'Parties',
    ),
    _Notification(
      icon: Icons.shopping_bag_outlined,
      iconColor: AppColors.warning,
      iconBg: AppColors.warningLight,
      title: 'Purchase Due',
      body: 'PUR-318 from Sunrise Distributors is due tomorrow. ₹28,400 payable.',
      time: 'Yesterday',
      isUnread: false,
      tag: 'Purchase',
    ),
    _Notification(
      icon: Icons.bar_chart_rounded,
      iconColor: const Color(0xFF14B8A6),
      iconBg: const Color(0xFFCCFBF1),
      title: 'Monthly Report Ready',
      body: 'Your April 2026 P&L report is ready. Net profit: ₹40,750.',
      time: 'Yesterday',
      isUnread: false,
      tag: 'Report',
    ),
    _Notification(
      icon: Icons.file_upload_outlined,
      iconColor: AppColors.error,
      iconBg: AppColors.errorLight,
      title: 'Payment Reminder Sent',
      body: 'Automated reminder sent to Citylight Electricals for ₹8,900 due.',
      time: '2 days ago',
      isUnread: false,
      tag: 'Payment',
    ),
  ];

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isUnread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Column(
        children: [
          _buildHeader(context),
          if (_unreadCount > 0) _buildUnreadBanner(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 40),
              physics: const BouncingScrollPhysics(),
              itemCount: _notifications.length,
              itemBuilder: (context, i) => _buildNotificationCard(_notifications[i], i),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 16,
        left: 20,
        right: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                if (_unreadCount > 0)
                  Text(
                    '$_unreadCount unread',
                    style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          if (_unreadCount > 0)
            GestureDetector(
              onTap: _markAllRead,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Mark all read',
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUnreadBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'You have $_unreadCount unread notifications',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(_Notification n, int index) {
    return GestureDetector(
      onTap: () => setState(() => n.isUnread = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: n.isUnread ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: n.isUnread ? AppColors.primary.withOpacity(0.2) : AppColors.border,
            width: n.isUnread ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: n.isUnread
                  ? AppColors.primary.withOpacity(0.06)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: n.iconBg, borderRadius: BorderRadius.circular(14)),
              child: Icon(n.icon, color: n.iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          n.title,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: n.isUnread ? FontWeight.w700 : FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (n.isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n.body,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: n.iconBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          n.tag,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: n.iconColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.access_time_rounded, size: 11, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(
                        n.time,
                        style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Notification {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String body;
  final String time;
  final String tag;
  bool isUnread;

  _Notification({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.body,
    required this.time,
    required this.tag,
    required this.isUnread,
  });
}
