import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/transaction.dart';
import '../../repository/authentication_repository.dart';
import '../../repository/firestore_repository.dart';
import 'transactions_states.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit(
    this._firestoreRepository,
    this._authenticationRepository,
  ) : super(TransactionState.loading()) {
    _subscribeToTransactions(); // Start listening to the Firestore stream
  }

  final FirestoreRepository _firestoreRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<List<Transaction>>? _transactionsSubscription;

  void _subscribeToTransactions() {
    final userId = _authenticationRepository.currentUser.id;
    _transactionsSubscription?.cancel(); // Cancel any existing subscription

    _transactionsSubscription = _firestoreRepository.getTransactionsStream(userId).listen((transactions) {
      emit(TransactionState(
        transactions: transactions,
        status: TransactionStatus.loaded,
      ));
    }, onError: (e) {
      print('Error listening to transactions for user ID $userId: $e');
      emit(TransactionState(
        transactions: [],
        status: TransactionStatus.loaded,
      ));
    });
  }

  @override
  Future<void> close() {
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
