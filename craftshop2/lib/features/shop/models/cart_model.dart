import 'package:dio/dio.dart';

class Cart {
  int productId; // ID sản phẩm
  int quantity;  // Số lượng sản phẩm trong giỏ

  Cart({
    required this.productId,
    required this.quantity,
  });

  // Phương thức chuyển đổi Cart thành FormData để gửi lên API
  FormData toFormData() {
    return FormData.fromMap({
      'productId': productId,
      'quantity': quantity,
    });
  }

  // Phương thức để xử lý phản hồi từ API khi thêm hàng vào giỏ
  static CartResponse fromResponse(Map<String, dynamic> response) {
    return CartResponse(
      status: response['status'],
      message: response['message'],
    );
  }
}

// Phản hồi từ API khi thêm hàng vào giỏ
class CartResponse {
  String status;  // Trạng thái trả về từ API ("ok" hoặc "error")
  String message; // Thông báo từ API về kết quả

  CartResponse({
    required this.status,
    required this.message,
  });
}
