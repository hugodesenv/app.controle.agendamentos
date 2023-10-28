import '../../../../enum/form_submission_status.dart';
import '../../../../models/customer.dart';


class CustomerInfoState {
  final Customer customer;
  final FormSubmissionStatus status;
  final String? message;

  CustomerInfoState({
    required Customer? customer,
    this.status = FormSubmissionStatus.initial,
    this.message = '',
  }) : customer = customer ?? Customer.empty();

  CustomerInfoState copyWith({
    Customer? customer,
    FormSubmissionStatus? status,
    String? message,
  }) {
    return CustomerInfoState(
      customer: customer ?? this.customer,
      status: status ?? this.status,
      message: message ?? '',
    );
  }
}
