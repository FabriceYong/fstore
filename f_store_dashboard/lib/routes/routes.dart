class FRoutes {
  FRoutes._();
  static const login = '/login';
  static const forgotPassword = '/forgot_password/';
  static const resetPassword = '/reset_password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const createOrder = 'createOrder';
  static const editOrder = 'editOrder';

  static const firstScreen = '/firstScreen';
  static const secondScreen = '/secondScreen';
  static const secondScreenWithId = '/secondScreenWithId/:userId';
  static const responsiveScreen = '/responsiveScreen';

  static List sidebarMenuItems = [
   dashboard,
   media,
   banners,
   products,
   categories,
   brands,
   customers,
   orders,
  ];    
}


