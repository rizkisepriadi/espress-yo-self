import 'package:espress_yo_self/domain/entities/stamp_progress_entity.dart';
import 'package:espress_yo_self/domain/usecases/stamp_progress_usecase.dart'; // ✅ Hanya import yang diperlukan
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StampProgressViewModel extends StateNotifier<AsyncValue<StampProgressEntity>> {
  final GetStampProgressUsecase getStampProgressUsecase;
  final UpdateStampProgressRepoUsecase updateStampProgressRepoUsecase;

  StampProgressViewModel({
    required this.getStampProgressUsecase,
    required this.updateStampProgressRepoUsecase,
  }) : super(const AsyncValue.loading());

  Future<void> fetchStampProgress(String userId) async {
    try {
      state = const AsyncValue.loading();
      final stamp = await getStampProgressUsecase.call(userId);
      if (!mounted) return;
      state = AsyncValue.data(stamp);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStampProgress(String userId, int stamps) async {
    try {
      await updateStampProgressRepoUsecase.call(userId, stamps);
      if (!mounted) return;
      
      await fetchStampProgress(userId);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addStamp(String userId) async {
    try {
      final currentData = state.value;
      if (currentData == null) return;

      final newStamps = currentData.stampsCollected + 1;
      await updateStampProgress(userId, newStamps);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> resetStamps(String userId) async {
    try {
      await updateStampProgress(userId, 0);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }
}
