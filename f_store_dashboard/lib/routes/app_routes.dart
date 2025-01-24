import 'package:f_store_dashboard/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:f_store_dashboard/features/authentication/screens/login/login.dart';
import 'package:f_store_dashboard/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:f_store_dashboard/features/media/screens/media.dart';
import 'package:f_store_dashboard/features/personalization/profile/profile.dart';
import 'package:f_store_dashboard/features/personalization/settings/settings.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/all_banners/banners.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/create_banner/create_banner.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/edit_banner/edit_banner.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/brands.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/create_brand/create_brand.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/edit_brand/edit_brand.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/categories.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/create_category/create_category.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/edit_category/edit_category.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/customers.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/customer_details.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/all_orders/orders.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/order_details.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/products.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/create_product.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/edit_product.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/routes/routes_middleware.dart';
import 'package:get/get.dart';

class FAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: FRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: FRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(
        name: FRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
        name: FRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.media,
        page: () => const MediaScreen(),
        middlewares: [FRoutesMiddleware()]),

    /// Categories
    GetPage(
        name: FRoutes.categories,
        page: () => const CategoriesScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.createCategory,
        page: () => const CreateCategoryScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.editCategory,
        page: () => const EditCategoryScreen(),
        middlewares: [FRoutesMiddleware()]),

    /// Brands
    GetPage(
        name: FRoutes.brands,
        page: () => const BrandsScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.createBrand,
        page: () => const CreateBrandScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.editBrand,
        page: () => const EditBrandScreen(),
        middlewares: [FRoutesMiddleware()]),

    /// Banners
    GetPage(
        name: FRoutes.banners,
        page: () => const BannersScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.createBanner,
        page: () => const CreateBannerScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.editBanner,
        page: () => const EditBannerScreen(),
        middlewares: [FRoutesMiddleware()]),

    /// Products
    GetPage(
        name: FRoutes.products,
        page: () => const ProductsScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.createProduct,
        page: () => const CreateProductScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.editProduct,
        page: () => const EditProductScreen(),
        middlewares: [FRoutesMiddleware()]),

    /// Customers
    GetPage(
        name: FRoutes.customers,
        page: () => const CustomersScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.customerDetails,
        page: () => const CustomerDetailsScreen(),
        middlewares: [FRoutesMiddleware()]),

    /// Orders
    GetPage(
        name: FRoutes.orders,
        page: () => const OrdersScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.orderDetails,
        page: () => const OrderDetailsScreen(),
        middlewares: [FRoutesMiddleware()]),

    // Add more routes here...
    GetPage(
        name: FRoutes.profile,
        page: () => const ProfileScreen(),
        middlewares: [FRoutesMiddleware()]),
    GetPage(
        name: FRoutes.settings,
        page: () => const SettingsScreen(),
        middlewares: [FRoutesMiddleware()]),
  ];
}
