import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/order.dart';
import 'package:zaccount/models/product_item.dart';

final orderStreamProvider = StreamProvider<List<Orders>>((ref) {
  return FirebaseFirestore.instance.collection('orders').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Orders.fromDocument(doc)).toList(),
      );
});

class OrderListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  OrderListNotifier() : super([]) {
    // Automatically fetch products when the notifier is created
    _fetchInvoices();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _fetchInvoices() async {
    try {
      final querySnapshot = await _firestore
          .collection('orders')
          .orderBy('createdAt', descending: false)
          .get();
      List<Map<String, dynamic>> orders = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
      state = orders;
    } catch (e) {
      // Handle errors as needed
      print('Error fetching products: $e');
    }
  }
}

final orderFurureProvider =
    StateNotifierProvider<OrderListNotifier, List<Map<String, dynamic>>>(
  (ref) => OrderListNotifier(),
);

final orderProvider = StateNotifierProvider<OrdersNotifier, Orders>((ref) {
  return OrdersNotifier();
});

class OrdersNotifier extends StateNotifier<Orders> {
  OrdersNotifier() : super(Orders());

  final FirebaseFirestore _firesore = FirebaseFirestore.instance;

  void updateOderCustomerDetails({
    required String idOfCustomer,
    required String firstName,
    required String lastName,
  }) {
    state = state.copyWith(
      customerId: idOfCustomer,
      customerFirstName: firstName,
      customerLastName: lastName,
    );
  }

  void updateproductItem(ProductItem productItem) {
    state = state.copyWith(
      items: [...state.items, productItem],
      totalAmount: state.totalAmount + productItem.amount,
    );
  }

  void updateShippingMethod(String shipping) {
    state = state.copyWith(shippingMethod: shipping);
  }

  Future<DocumentReference> addOrder() async {
    DocumentReference reference =
        await _firesore.collection("orders").add(state.toJson());
    state = Orders();
    return reference;
  }
}
