import 'package:fstoreapp/features/authentication/screens/login/login.dart';
import 'package:fstoreapp/features/authentication/screens/onboarding/onboarding.dart';
import 'package:fstoreapp/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:fstoreapp/features/authentication/screens/register/register.dart';
import 'package:fstoreapp/features/authentication/screens/register/widgets/verify_email.dart';
import 'package:fstoreapp/features/personalization/screens/addresses/addresses.dart';
import 'package:fstoreapp/features/personalization/screens/profile/profile.dart';
import 'package:fstoreapp/features/personalization/screens/settings/settings.dart';
import 'package:fstoreapp/features/shop/screens/cart/cart.dart';
import 'package:fstoreapp/features/shop/screens/checkout/checkout.dart';
import 'package:fstoreapp/features/shop/screens/home/home.dart';
import 'package:fstoreapp/features/shop/screens/orders/orders.dart';
import 'package:fstoreapp/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:fstoreapp/features/shop/screens/store/store_screen.dart';
import 'package:fstoreapp/features/shop/screens/wishlist/wishlist.dart';
import 'package:fstoreapp/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: FRoutes.home, page: () => const HomeScreen()),
    GetPage(name: FRoutes.store, page: () => const StoreScreen()),
    GetPage(name: FRoutes.favorites, page: () => const WishlistScreen()),
    GetPage(name: FRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: FRoutes.productReviews, page: () => const ProductReviews()),
    GetPage(name: FRoutes.order, page: () => const OrdersScreen()),
    GetPage(name: FRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: FRoutes.cart, page: () => const CartScreen()),
    GetPage(name: FRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: FRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: FRoutes.signup, page: () => const RegisterScreen()),
    GetPage(name: FRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: FRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: FRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: FRoutes.onBoarding, page: () => const OnboardingScreen()),
  ];
}
