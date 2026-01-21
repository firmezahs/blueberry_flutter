import 'package:blueberry/view/alerts/store/notification_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationStore store = NotificationStore();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.fetchNotifications();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && store.canLoadMore) {
      store.fetchNotifications();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () => store.fetchNotifications(refresh: true),
        child: Observer(
          builder: (_) {
            if (store.isLoading && store.notifications.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.notifications.isEmpty) {
              return const Center(child: Text('No notifications'));
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: store.notifications.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == store.notifications.length) {
                  /// 🔹 Bottom pagination loader
                  return Observer(
                    builder: (_) {
                      if (!store.hasMore) {
                        return const SizedBox(height: 24);
                      }
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  );
                }

                final item = store.notifications[index];
                final response = item.responseData;
                final bool isUnread = item.isRead == 0;
                final bool isUrgent = response?.isUrgent == true;

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    log('Open Order: ${response?.orderNumber}');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUnread ? context.cardColor.withOpacity(0.95) : context.cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: isUnread ? Colors.blue.shade200 : context.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 🔔 Title
                        Row(
                          children: [
                            if (isUnread)
                              Container(
                                height: 8,
                                width: 8,
                                margin: const EdgeInsets.only(top: 4),
                                decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                              ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(item.title.validate(), style: boldTextStyle(size: 14))),
                          ],
                        ),

                        const SizedBox(height: 6),

                        /// 📄 Message
                        Text(item.message.validate(), style: secondaryTextStyle(size: 13)),

                        const SizedBox(height: 10),

                        /// 🏷 Footer
                        Row(
                          children: [
                            if (response?.orderNumber.validate() != null) _chip(response!.orderNumber.validate()),

                            if (isUrgent) ...[const SizedBox(width: 8), _urgentChip()],

                            const Spacer(),
                            Text(_timeAgo(item.createdAt.toString()), style: secondaryTextStyle(size: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _urgentChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(6)),
      child: const Text(
        'URGENT',
        style: TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _timeAgo(String date) {
    final dt = DateTime.parse(date);
    final diff = DateTime.now().difference(dt);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hrs ago';
    return '${diff.inDays} days ago';
  }
}
