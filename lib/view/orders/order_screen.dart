import 'package:blueberry/main.dart';
import 'package:blueberry/view/orders/add_order_view.dart';
import 'package:blueberry/view/orders/components/filter_component.dart';
import 'package:blueberry/view/orders/components/order_card_component.dart';
import 'package:blueberry/view/orders/components/search_component.dart';
import 'package:blueberry/view/orders/controller/add_order_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && orderListingStore.canLoadMore) {
      orderListingStore.fetchOrders();
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    orderListingStore.fetchOrders();
    _scrollController.addListener(_onScroll);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addOrderStore = AddOrderStore();
          await AddOrderScreen().launch(context);
          orderListingStore.fetchOrders(refresh: true);
        },
        child: const Icon(Icons.add),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.pixels == n.metrics.maxScrollExtent) {
            orderListingStore.fetchOrders();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () => orderListingStore.fetchOrders(refresh: true),

          child: CustomScrollView(
            controller: _scrollController,

            slivers: [
              // ---------------- Search (Always Visible) ----------------
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: context.scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                titleSpacing: 16,
                title: AnimatedSearchBar(onChanged: orderListingStore.updateSearch),
              ),

              // ---------------- Filters (Hide on Scroll) ----------------
              SliverToBoxAdapter(
                child: Observer(
                  builder: (_) => AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: FilterComponent(
                        urgentOnly: orderListingStore.urgentOnly,
                        status: orderListingStore.selectedStatus,
                        onUrgentChanged: orderListingStore.toggleUrgent,
                        onStatusChanged: orderListingStore.changeStatus,
                      ),
                    ),
                  ),
                ),
              ),

              // ---------------- Orders List ----------------
              Observer(
                builder: (_) {
                  if (orderListingStore.isLoading && orderListingStore.orders.isEmpty) {
                    return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                  }

                  if (orderListingStore.filteredOrders.isEmpty && !orderListingStore.isLoading) {
                    return SliverFillRemaining(child: Center(child: Text('No orders found')));
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 300 + (index * 40)),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
                          );
                        },
                        child: OrderCardComponent(order: orderListingStore.filteredOrders[index]),
                      );
                    }, childCount: orderListingStore.filteredOrders.length),
                  );
                },
              ),

              Observer(
                builder: (_) {
                  if (!orderListingStore.isLoading || orderListingStore.orders.isEmpty) {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }

                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator.adaptive()),
                    ),
                  );
                },
              ),
              // ---------------- Bottom Padding for FAB ----------------
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
