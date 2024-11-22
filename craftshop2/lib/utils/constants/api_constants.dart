class APIConstants {

 static const String BASE_URL = 'https://10.0.2.2:8080'; // URL base của hệ thống

 // API Người dùng
 static const String REGISTER = 'api/register';
 static const String LOGIN = 'api/login';
 static const String LOGOUT = 'api/logout';
 static const String GET_INFO_USER = 'api/getUserInfo';
 static const String UPDATE_INFO_USER = 'api/updateUserInfo';
 static const String GENERATE_CODE = 'api/generatePasswordCode';
 static const String CHANGE_PASSWORD = 'api/changePassword';

 // API Quản lý File
 static const String DOWNLOAD_IMAGE = 'api/download';
 static const String UPLOAD_FILE = 'api/upload';
 static const String DELETE_FILE = 'api/delete';

 // API Sản phẩm
 static const String GET_PRODUCTS_PAGE = 'api/getProductsPage';
 static const String GET_PRODUCT = 'api/getProduct';
 static const String GET_PRODUCT_TYPE = 'api/getProductType';
 static const String GET_PRODUCT_LINES_PAGE = 'api/getProductLinesPage';
 static const String GET_PRODUCT_LINE = 'api/getProductLine';
 static const String CREATE_PRODUCT = 'api/createProduct';
 static const String UPDATE_PRODUCT = 'api/updateProduct';
 static const String DELETE_PRODUCT = 'api/deleteProduct';

 // API Dòng sản phẩm
 static const String CREATE_PRODUCT_LINE = 'api/createProductLine';
 static const String UPDATE_PRODUCT_LINE = 'api/updateProductLine';
 static const String DELETE_PRODUCT_LINE = 'api/deleteProductLine';

 // API Voucher
 static const String GET_VOUCHERS_PAGE = 'api/getVouchersPage';
 static const String GET_VOUCHER = 'api/getVoucher';
 static const String CREATE_VOUCHER = 'api/createVoucher';
 static const String UPDATE_VOUCHER = 'api/updateVoucher';
 static const String DELETE_VOUCHER = 'api/deleteVoucher';

 // API Đơn hàng
 static const String GET_CART_ITEMS = 'api/getCartItem';
 static const String ADD_CART_ITEM = 'api/addCartItem';
 static const String REMOVE_CART_ITEM = 'api/removeCartItem';
 static const String GET_ORDERS = 'api/getOrder';
 static const String CREATE_ORDER = 'api/createOrder';
 static const String UPDATE_ORDER = 'api/updateOrder';
 static const String SUBMIT_ORDER = 'api/submitOrder';
 static const String CANCEL_ORDER = 'api/cancelOrder';
 static const String CONFIRM_PAYMENT_VNPAY = 'api/confirmPaymentUsingVNPAY';
}
