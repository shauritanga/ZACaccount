// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderInvoice {
  OrderInvoice({
    required this.paymentMethod,
    required this.shippingMethod,
    required this.customerNote,
    required this.memo,
    this.lateFees,
  });
  final String paymentMethod;
  final String shippingMethod;
  final String customerNote;
  final String memo;
  final int? lateFees;
}
