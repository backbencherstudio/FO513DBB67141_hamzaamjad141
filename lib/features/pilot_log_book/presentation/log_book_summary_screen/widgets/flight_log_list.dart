import 'package:aviation_app/features/pilot_log_book/riverpod/log_book_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../log_entry_screen/widgets/flight_log_card.dart';

class FlightLogList extends ConsumerStatefulWidget {
  const FlightLogList({super.key});

  @override
  ConsumerState<FlightLogList> createState() => _FlightLogListState();
}

class _FlightLogListState extends ConsumerState<FlightLogList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      // Load more when user scrolls to 80% of the list
      ref.read(logBookProvider.notifier).loadMoreLogs();
    }
  }

  @override
  Widget build(BuildContext context) {
    final logBookState = ref.watch(logBookProvider);
    final flightLogRequestList = logBookState.logRequestList;
    
    if (logBookState.isLoading && (flightLogRequestList == null || flightLogRequestList.isEmpty)) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (flightLogRequestList == null || flightLogRequestList.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: flightLogRequestList.length + (logBookState.isLoadingMore ? 1 : 0),
      itemBuilder: (_, index) {
        // Show loading indicator at the end when loading more
        if (index == flightLogRequestList.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        final flightLogRequest = flightLogRequestList[index];
        final isLoading = logBookState.deleteButtonLoadingButtonIndex == index;
        
        return FlightLogCard(
          logRequestModel: flightLogRequest,
          isLoading: isLoading,
          onDelete: () async {
            await ref.read(logBookProvider.notifier).deleteLogRequest(
              id: flightLogRequest.id, 
              index: index
            );
          },
        );
      }
    );
  }
}