import 'package:espress_yo_self/di/di.dart';
import 'package:espress_yo_self/presentation/common/floating_button.dart';
import 'package:espress_yo_self/presentation/history/widget/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/bottom_navigation.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = ref.read(getUserViewModelProvider);
      final userId = userState.asData?.value.id;
      if (userId != null) {
        ref
            .read(transactionsViewModelProvider.notifier)
            .fetchUserTransactions(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final transactionState = ref.watch(transactionsViewModelProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text(
          'Purchase History',
          style: textTheme.headlineMedium,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButton(),
      bottomNavigationBar: BottomNavigation(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          }),
      body: SafeArea(
          minimum: EdgeInsets.only(left: 16.w, right: 16.w),
          child: transactionState.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long,
                            size: 48.sp, color: Colors.grey[500]),
                        Text(
                          'No transaction history.',
                          style: textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Start making purchases to see your history',
                        )
                      ],
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: transactions.length,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.h,
                        ),
                        child: HistoryCard(
                            title: transaction.title,
                            timestamp: transaction.timeStamp,
                            pointsEarned: transaction.pointsEarned,
                            imageUrl: transaction.image250Url!),
                      );
                    });
              },
              error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: colorScheme.error, size: 48.h),
                        Text('Error loading history',
                            style: textTheme.bodyMedium),
                        SizedBox(height: 8.h),
                        Text(
                          'Please try again later.',
                          style: textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                            onPressed: () {
                              final userState =
                                  ref.read(getUserViewModelProvider);
                              final userId = userState.asData?.value.id;
                              if (userId != null) {
                                ref
                                    .read(
                                        transactionsViewModelProvider.notifier)
                                    .fetchUserTransactions(userId);
                              }
                            },
                            child: Text('Retry')),
                      ],
                    ),
                  ),
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }
}
