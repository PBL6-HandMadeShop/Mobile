class APIConstants {
 static const String BASE_URL = 'https://10.0.2.2:8080 ';
 //  static const String BASE_URL = 'https://fda8-2405-4802-95f3-13b0-25a9-1662-4c3c-d322.ngrok-free.app';
 //---------------------API về User---------------------//
  static const String REGISTER = 'api/register';
  static const String LOGIN = 'api/login';
  static const String LOGOUT = 'api/logout';
  static const String GET_INFO_USER = 'api/getUserInfo';
  static const String DOWNLOAD_IMAGE = 'api/download';
  static const String UPDATE_INFO_USER = 'api/updateUserInfo';
  static const String GENERATE_CODE = 'api/generatePasswordCode';
  //---------------------API về Sản phẩm---------------------//
  static const String GET_ALL_PRODUCTS = 'api/getAllProducts';
  static const String GET_PRODUCT_TYPE = 'api/getProductType';
  static const String GET_LINE_PRODUCT_PAGE = 'api/getProductLinesPage';
  static const String GET_PRODUCT_PAGE = 'api/getProductsPage';
  static const String GET_PRODUCT_TYPE_PAGE = 'api/getProductTypesPage';

  //====================API về Đơn hàng(CUSTOMER)====================//
  static const String GET_CART_ITEMS = 'api/getCartItem';
  static const String ADD_CART_ITEM = 'api/addCartItem';
  static const String REMOVE_CART_ITEM = 'api/removeCartItem';


  //====================API về Review====================//
  static const String GET_REVIEWS_BY_PRODUCT = 'api/getReviewsByProduct';
}