import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import 'widgets/order_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final API_Services _apiServices = API_Services();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Gọi API để lấy danh sách đơn hàng ban đầu
  }

  Future<void> _fetchOrders() async {
    if (isLoading || !hasMore) return; // Nếu đang tải hoặc đã tải hết dữ liệu thì không làm gì nữa

    setState(() {
      isLoading = true; // Hiển thị trạng thái tải
    });

    try {
      // Lấy token từ SecureStorage
      String? token = await _storage.read(key: 'session_token');

      if (token == null) {
        throw Exception("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục.");
      }

      // Gọi API lấy danh sách đơn hàng cho trang hiện tại
      final response = await _apiServices.getOrders(token: token, page: currentPage, size: 10);

      // Kiểm tra kết quả trả về
      if (response['status'] == 'ok' && response['content'] != null) {
        final List<dynamic> data = response['content'];

        // Nếu không còn dữ liệu, đặt flag hasMore = false
        if (data.isEmpty) {
          setState(() {
            hasMore = false;
          });
        } else {
          setState(() {
            currentPage++;
            orders.addAll(data.map((order) => Map<String, dynamic>.from(order)).toList());
          });
        }
      } else {
        throw Exception(response['message'] ?? "Không thể tải danh sách đơn hàng.");
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false; // Ẩn trạng thái tải
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        title: Text('Đơn Hàng', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: isLoading && orders.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Hiển thị khi đang tải dữ liệu ban đầu
          : orders.isEmpty
          ? const Center(child: Text("Bạn chưa có đơn hàng nào"))
          : NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          // Kiểm tra nếu người dùng cuộn đến cuối thì tải thêm dữ liệu
          if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchOrders();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: orders.length + (hasMore ? 1 : 0), // Thêm 1 cho phần "đang tải thêm" nếu còn dữ liệu
          itemBuilder: (context, index) {
            if (index == orders.length) {
              return const Center(child: CircularProgressIndicator()); // Hiển thị vòng quay tải thêm
            }
            return CSOrderListItems(order: orders[index]);
          },
        ),
      ),
    );
  }
}
