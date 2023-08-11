import 'package:equatable/equatable.dart';

enum TransferStatus {
  initial,
  inProgress,
  loading,
  success,
  failure,
}

extension TransferStatusX on TransferStatus {
  //TODO: write description for every state
  /// Indicates whether the form has not yet been submitted.
  bool get isInitial => this == TransferStatus.initial;

  /// Indicates whether the form is in the process of being submitted.
  bool get isInProgress => this == TransferStatus.inProgress;

  /// Indicates whether the form is in loading status
  bool get isLoading => this == TransferStatus.loading;

  /// Indicates whether the form has been submitted successfully.
  bool get isSuccess => this == TransferStatus.success;

  /// Indicates whether the form submission failed.
  bool get isFailure => this == TransferStatus.failure;

  /// Indicates whether the form is either in progress or has been submitted
  /// successfully.
  ///
  /// This is useful for showing a loading indicator or disabling the submit
  /// button to prevent duplicate submissions.
  bool get isInProgressOrSuccess => isInProgress || isSuccess;
}

class TransferStates extends Equatable {
  const TransferStates({
    this.senderCardId = '',
    this.receiverCardId = '',
    this.amount = 0,
    this.status = TransferStatus.initial,
    this.errorMessage,
  });

  final String senderCardId;
  final String receiverCardId;
  final int amount;
  final TransferStatus status;
  final String? errorMessage;

  bool get hasError => errorMessage != null;

  @override
  List<Object?> get props => [
        senderCardId,
        receiverCardId,
        amount,
        status,
        errorMessage,
      ];

  TransferStates copyWith({
    String? senderCardId,
    String? receiverCardId,
    int? amount,
    TransferStatus? status,
    String? errorMessage,
  }) {
    return TransferStates(
      senderCardId: senderCardId ?? this.senderCardId,
      receiverCardId: receiverCardId ?? this.receiverCardId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
