import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/firestore_repository.dart';
import 'transfer_states.dart';

class TransferCubit extends Cubit<TransferStates> {
  // Add a reference to your FirestoreRepository

  TransferCubit(this.firestoreRepository) : super(const TransferStates());
  final FirestoreRepository firestoreRepository;

  void updateSenderCardId(String senderCardId) {
    emit(state.copyWith(
      senderCardId: senderCardId,
      status: TransferStatus.inProgress,
    ));
  }

  void updateReceiverCardId(String receiverCardId) {
    emit(state.copyWith(
      receiverCardId: receiverCardId,
      status: TransferStatus.inProgress,
    ));
  }

  void updateAmount(int amount) {
    emit(state.copyWith(
      amount: amount,
      status: TransferStatus.inProgress,
    ));
  }

  Future<void> sendMoney() async {
    try {
      emit(state.copyWith(status: TransferStatus.loading));

      final senderCardId = state.senderCardId;
      final receiverCardId = state.receiverCardId;
      final amount = state.amount;

      //TODO: seperate this exception handlings and underline field which is not filled
      if (senderCardId.isEmpty || receiverCardId.isEmpty || amount == 0) {
        emit(state.copyWith(
          status: TransferStatus.failure,
          errorMessage: 'All fields are required',
        ));
        emit(state.copyWith(
          status: TransferStatus.inProgress,
        ));
        return;
      }

      await firestoreRepository.sendMoney(
        senderCardId: senderCardId,
        receiverCardId: receiverCardId,
        amount: amount,
      );

      emit(state.copyWith(
        status: TransferStatus.success,
      ));
      emit(const TransferStates());

      // } on SendMoneyFailure catch (e) {
      //   emit(state.copyWith(
      //     status: TransferStatus.failure,
      //     errorMessage: e.message,
      //   ));
    } catch (e) {
      emit(state.copyWith(
        status: TransferStatus.failure,
        errorMessage: e.toString(),
      ));
      emit(const TransferStates());
    }
  }
}
