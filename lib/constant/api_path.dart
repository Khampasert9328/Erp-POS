class APIPath {
  static const String BASE_URL = 'https://api.erpstack.la/api/v1/';
  static const String CONNECT_VALIDATE_USER = BASE_URL + 'Connect/validateuser';
  static const String CONNECT_TOKEN = BASE_URL + 'Connect/token';
  static const String CONNECT_ATHORIZE = BASE_URL + 'Connect/authorize';
  static const String CONNECT_CREATE_TENANT =
      BASE_URL + 'TenantService/CreateTenant';
  static const String GET_AREA = BASE_URL + 'TableService/GetArea';
  static const String GET_TABLE_BY_AREAID =
      BASE_URL + 'TableService/GetTable_byArea';

  static const String INSERT_AREA = BASE_URL + 'TableService/CreateArea';
  static const String GET_FOOD_MENU = BASE_URL + 'ProductService/GetProduct';
  static const String GET_FOOD_MENU_POSTTYE = BASE_URL + 'ProductService/GetProductPostype';
  static const String CHECK_EXPIRED_PACKAGE = BASE_URL + 'PaymentService/checkSubscribeAccount';
  static const String GET_PACKAGE = BASE_URL + 'PaymentService/getPackage';
  static const String CREATE_ORDER = BASE_URL + 'OrderService/CreateOrder';
}
