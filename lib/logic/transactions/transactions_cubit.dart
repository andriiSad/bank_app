import 'package:bloc/bloc.dart';

import '../../repository/authentication_repository.dart';
import '../../repository/firestore_repository.dart';
import 'transactions_states.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit(
    this._firestoreRepository,
    this._authenticationRepository,
  ) : super(TransactionState.loading()) {
    fetchTransactions();
  }
  final FirestoreRepository _firestoreRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> fetchTransactions() async {
    final userId = _authenticationRepository.currentUser.id;
    try {
      final transactions = await _firestoreRepository.getTransactions(userId);
      emit(TransactionState(transactions: transactions, status: TransactionStatus.loaded));
    } catch (e) {
      print('Error fetching transactions for user ID $userId: $e');
      emit(TransactionState(transactions: [], status: TransactionStatus.loaded));
    }
  }
}
