import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/firestore_repository.dart';
import 'transfer_states.dart';

class TransferCubit extends Cubit<TransferStates> {
  // Add a reference to your FirestoreRepository

  TransferCubit(this.firestoreRepository) : super(const TransferStates());
  final FirestoreRepository firestoreRepository;

  void updateSenderCardId(String senderCardId) {
    emit(state.copyWith(senderCardId: senderCardId));
    print('Selected Sender Card: ${state.senderCardId}');
  }

  void updateReceiverCardId(String receiverCardId) {
    emit(state.copyWith(receiverCardId: receiverCardId));
    print('Selected Reciever Card: ${state.receiverCardId}');
  }

  void updateAmount(int amount) {
    emit(state.copyWith(amount: amount));
    print('Amount: ${state.amount}');
  }

  void resetError() {
    emit(state.copyWith(error: TransferError.none));
  }

  void resetFields() {
    emit(const TransferStates()); // Reset the state to its initial values
  }

  Future<void> sendMoney() async {
    try {
      emit(state.copyWith(loading: true, error: TransferError.none));

      final senderCardId = state.senderCardId;
      final receiverCardId = state.receiverCardId;
      final amount = state.amount;

      final result = await firestoreRepository.sendMoney(
        senderCardId: senderCardId,
        receiverCardId: receiverCardId,
        amount: amount,
      );

      if (result == 'success') {
        emit(state.copyWith(loading: false));
        // Handle success, e.g., show a success message
      } else {
        emit(state.copyWith(loading: false, error: TransferError.other));
        // Handle other error cases
      }
    } catch (e) {
      emit(
          state.copyWith(loading: false, error: TransferError.connectionError));
      // Handle the error
    }
  }
}
