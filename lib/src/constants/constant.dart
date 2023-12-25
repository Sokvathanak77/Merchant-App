
class AppConstant{
  static const String APP_NAME = 'FLUTTER API';
  static const int APP_VERSION = 1;

  static const String BASE_URL = 'https://merchant.spsolutiongroup.com/api/';
  static const String BASE_IMAGE_URL = 'https://merchant.spsolutiongroup.com/';
  //api
  static const String PRODUCT_LIST_API= 'user_scheme_price_list';
  static const String ADD_PRODUCT_API= 'add_list';
  static const String ADD_TO_CART='add_to_cart';
  static const String LIST_CART='list_cart';
  static String TOKEN = '';
  static String USER_ID = '';
  static const String DECREASE_CART = 'sub_to_cart';
  static const String DELETE_CART = 'delete_cart';
  static const String ORDER = 'order';
  static const String ORDER_DETAIL = 'order_detail';
  static const String LIST_ORDERED = 'list_ordered';
  static const String LIST_SLIDE= 'list_slide';
  static const String LIST_CATEGORY= 'list_category';
  static const String CATEGORY_ITEMS= 'user_scheme_price_list_by_category';

  //auth endpoint
  static const String SIGN_UP= 'register';
  static const String LOGIN= 'login';
  static const String OTP= 'verify_email_otp';
  static const String RESEND_OTP= 'resend_otp';
  static const String LOG_WITH_PHONE= 'log_with_phone';
  static const String CREATE_NEW_USER= 'create_user_with_phone';
  static const String CHECK_TOKEN= 'user';
  static const String SIGNOUT= 'logout';


  //local storage
  static const String CART_LIST='cart-list';
  static const String CART_HISTORY_LIST='cart-history-list';

}