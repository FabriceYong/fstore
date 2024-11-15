import 'package:fstoreapp/features/shop/models/banner_model.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/features/shop/models/product_attributes_model.dart';
import 'package:fstoreapp/features/shop/models/product_variations_model.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/routes/routes.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';

class FDummyData {
  /// -- Banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: FImages.banner1, targetScreen: FRoutes.order, active: false),
    BannerModel(
        imageUrl: FImages.banner2, targetScreen: FRoutes.cart, active: true),
    BannerModel(
        imageUrl: FImages.banner3,
        targetScreen: FRoutes.favorites,
        active: true),
    BannerModel(
        imageUrl: FImages.banner4, targetScreen: FRoutes.search, active: true),
    BannerModel(
        imageUrl: FImages.banner5,
        targetScreen: FRoutes.settings,
        active: true),
    BannerModel(
        imageUrl: FImages.banner6,
        targetScreen: FRoutes.userAddress,
        active: true),
    BannerModel(
        imageUrl: FImages.banner7,
        targetScreen: FRoutes.checkout,
        active: false),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: 'Sports', image: FImages.sportIcon, isFeatured: true),
    CategoryModel(
        id: '2',
        name: 'Furniture',
        image: FImages.furnitureIcon,
        isFeatured: true),
    CategoryModel(
      id: '3',
      name: 'Electronics',
      image: FImages.electronicsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '4',
      name: 'Clothes',
      image: FImages.clothIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '5',
      name: 'Animals',
      image: FImages.animalIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '6',
      name: 'Shoes',
      image: FImages.shoeIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '7',
      name: 'Cosmetics',
      image: FImages.cosmeticsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '8',
      name: 'Jewelry',
      image: FImages.jewelryIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '1',
      name: 'Toys',
      image: FImages.toyIcon,
      isFeatured: true,
    ),
  ];

  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        title: 'Green Nike Sports shoe',
        stock: 15,
        price: 135,
        isFeatured: true,
        thumbnail: FImages.productImage1,
        description: 'Green Nike Sports shoe',
        brand: BrandModel(
            id: '1',
            image: FImages.nikeLogo,
            name: 'Nike',
            productsCount: 256,
            isFeatured: true),
        images: [
          FImages.productImage1,
          FImages.productImage23,
          FImages.productImage21,
          FImages.productImage9
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '1',
        productAttributes: [
          ProductAttributesModel(
              name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributesModel(name: 'Size', values: [
            'EU 30',
            'EU 32',
            'EU 34',
            'EU 36',
          ]),
        ],
        productVariations: [
          ProductVariationsModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: FImages.productImage1,
              description:
                  'This is a Product Description for Green Nike sports shoes',
              attributes: {'Color': 'Green', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '2',
              stock: 15,
              price: 132,
              image: FImages.productImage23,
              attributes: {'Color': 'Black', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '3',
              stock: 0,
              price: 234,
              image: FImages.productImage23,
              attributes: {'Color': 'Black', 'Size': 'EU 36'}),
          ProductVariationsModel(
              id: '4',
              stock: 222,
              price: 244,
              image: FImages.productImage1,
              attributes: {'Color': 'Green', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '5',
              stock: 0,
              price: 234,
              image: FImages.productImage21,
              attributes: {'Color': 'Black', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '6',
              stock: 11,
              price: 332,
              image: FImages.productImage21,
              attributes: {'Color': 'Red', 'Size': 'EU 36'}),
        ],
        productType: 'ProductType.variable'),
    ProductModel(
      id: '002',
      title: 'Blue T-Shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbnail: FImages.productImage69,
      description:
          'This is a product description for Blue Nike Sleeveless Vest. There are more things that can be added but i am just practicing and nothing else',
      brand: BrandModel(id: '6', image: FImages.zaraLogo, name: 'ZARA'),
      images: [
        FImages.productImage68,
        FImages.productImage69,
        FImages.productImage5
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributesModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
        ProductAttributesModel(name: 'Size', values: ['EU34', 'EU32']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 38000,
      isFeatured: false,
      thumbnail: FImages.productImage64,
      description:
          'This is a product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else',
      brand: BrandModel(id: '6', image: FImages.zaraLogo, name: 'ZARA'),
      images: [
        FImages.productImage64,
        FImages.productImage65,
        FImages.productImage67
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributesModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributesModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
        id: '004',
        title: '4 Color collar t-shirt dry fit',
        stock: 15,
        price: 159,
        isFeatured: true,
        thumbnail: FImages.productImage60,
        description:
            'This is a product description for 4 Color collar t-shirt dry fit. There are more things that can be added but its just a demo and nothing else',
        brand: BrandModel(id: '6', image: FImages.zaraLogo, name: 'ZARA'),
        images: [
          FImages.productImage60,
          FImages.productImage62,
          FImages.productImage63
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '16',
        productAttributes: [
          ProductAttributesModel(
              name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
          ProductAttributesModel(
              name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
        ],
        productVariations: [
          ProductVariationsModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: FImages.productImage60,
              description:
                  'This is a Product description for 4 Color collar t-shirt dry fit',
              attributes: {'Color': 'Red', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '2',
              stock: 15,
              price: 132,
              image: FImages.productImage60,
              attributes: {'Color': 'Yellow', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '3',
              stock: 0,
              price: 234,
              image: FImages.productImage61,
              attributes: {'Color': 'Green', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '4',
              stock: 23,
              price: 244,
              image: FImages.productImage62,
              attributes: {'Color': 'Blue', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '5',
              stock: 0,
              price: 334,
              image: FImages.productImage62,
              attributes: {'Color': 'Green', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '6',
              stock: 11,
              price: 332,
              image: FImages.productImage62,
              attributes: {'Color': 'Green', 'Size': 'EU 30'}),
          ProductVariationsModel(
              id: '7',
              stock: 0,
              price: 334,
              image: FImages.productImage63,
              attributes: {'Color': 'Blue', 'Size': 'EU 30'}),
          ProductVariationsModel(
              id: '8',
              stock: 11,
              price: 332,
              image: FImages.productImage63,
              attributes: {'Color': 'Blue', 'Size': 'EU 34'}),
        ],
        productType: 'ProductType.variable'),
    ProductModel(
        id: '005',
        title: 'Nike Air Jordan Shoes',
        stock: 15,
        price: 135,
        isFeatured: false,
        thumbnail: FImages.productImage10,
        description:
            'Nike Air Jordan Shoes for running. Quality product, Long lasting.',
        brand: BrandModel(
            id: '1', image: FImages.nikeLogo, name: 'Nike', isFeatured: true),
        images: [
          FImages.productImage7,
          FImages.productImage8,
          FImages.productImage9,
          FImages.productImage10
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '8',
        productAttributes: [
          ProductAttributesModel(
              name: 'Color', values: ['Orange', 'Black', 'Brown']),
          ProductAttributesModel(
              name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
        ],
        productVariations: [
          ProductVariationsModel(
              id: '1',
              stock: 16,
              price: 36,
              salePrice: 12.6,
              image: FImages.productImage8,
              description:
                  'Flutter is Google\'s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
              attributes: {'Color': 'Orange', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '2',
              stock: 15,
              price: 35,
              image: FImages.productImage7,
              attributes: {'Color': 'Black', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '3',
              stock: 14,
              price: 34,
              image: FImages.productImage9,
              attributes: {'Color': 'Brown', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '4',
              stock: 13,
              price: 33,
              image: FImages.productImage7,
              attributes: {'Color': 'Black', 'Size': 'EU 34'}),
          ProductVariationsModel(
              id: '5',
              stock: 12,
              price: 32,
              image: FImages.productImage9,
              attributes: {'Color': 'Brown', 'Size': 'EU 32'}),
          ProductVariationsModel(
              id: '6',
              stock: 11,
              price: 31,
              image: FImages.productImage8,
              attributes: {'Color': 'Orange', 'Size': 'EU 32'}),
        ],
        productType: 'ProductType.variable'),
    ProductModel(
        id: '006',
        title: 'SAMSUNG Galaxy S9 (Pink, 64 GB) (4 GB RAM)',
        stock: 15,
        price: 740,
        isFeatured: false,
        thumbnail: FImages.productImage11,
        description:
            'SAMSUNG Galaxy S9 (Pink, 64 GB) (4 GB RAM), Long Battery timing',
        brand: BrandModel(id: '2', image: FImages.samsungLogo, name: 'SAMSUNG'),
        images: [
          FImages.productImage11,
          FImages.productImage13,
          FImages.productImage12
        ],
        salePrice: 650,
        sku: 'ABR4568',
        categoryId: '2',
        productAttributes: [
          ProductAttributesModel(name: 'Size', values: ['EU34', 'EU32']),
          ProductAttributesModel(
              name: 'Color', values: ['Green', 'Red', 'Blue'])
        ],
        productType: 'ProductType.single'),
    ProductModel(
      id: '007',
      title: 'TOMI Dog food',
      stock: 15,
      price: 20,
      isFeatured: false,
      thumbnail: FImages.productImage18,
      description:
          'This is a product description for TOMI Dog food, there are more things that can be added but i am just practicing and nothing else',
      brand: BrandModel(id: '14', image: FImages.tomiLogo, name: 'TOMi'),
      salePrice: 10,
      sku: 'ABR4568',
      categoryId: '4',
      productAttributes: [
        ProductAttributesModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributesModel(name: 'Color', values: ['Green', 'Red', 'Blue'])
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
        id: '009',
        title: 'Nike Air Jordan Blue',
        stock: 15,
        price: 400,
        isFeatured: false,
        thumbnail: FImages.productImage19,
        description:
            'This is a product description for Nike Air Jordan. There are more things that can be added but i am just practicing and nothing else',
        brand: BrandModel(id: '1', image: FImages.nikeLogo, name: 'Nike'),
        images: [
          FImages.productImage19,
          FImages.productImage20,
          FImages.productImage21,
          FImages.productImage22
        ],
        salePrice: 200,
        sku: 'ABR4568',
        categoryId: '8',
        productAttributes: [
          ProductAttributesModel(name: 'Size', values: ['EU34', 'EU32']),
          ProductAttributesModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
        ],
        productType: 'ProductType.single'),
    ProductModel(
      id: '010',
      title: 'Nike Air Jordan 6 Orange',
      stock: 15,
      price: 450,
      isFeatured: false,
      thumbnail: FImages.productImage19,
      description:
          'This is a product description for Nike Air Jordan 6 Orange. There are more things that can be added but i am just practicing and nothing else',
      brand: BrandModel(id: '1', image: FImages.nikeLogo, name: 'Nike'),
      images: [
        FImages.productImage19,
        FImages.productImage20,
        FImages.productImage21,
        FImages.productImage22
      ],
      salePrice: 120,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributesModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributesModel(
            name: 'Color', values: ['Green', 'Red', 'Blue', 'Orange']),
      ],
      productType: 'ProductType.single',
    ),
  ];

  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        image: FImages.nikeLogo,
        name: 'Nike',
        isFeatured: true,
        productsCount: 100),
    BrandModel(id: '2', image: FImages.samsungLogo, name: 'SAMSUNG', isFeatured: true, productsCount: 3234),
    BrandModel(
        id: '10',
        image: FImages.ikeaLogo,
        name: 'Ikea',
        isFeatured: true,
        productsCount: 1020),
    BrandModel(
        id: '3',
        image: FImages.pumaLogo,
        name: 'Puma',
        isFeatured: true,
        productsCount: 39),
    BrandModel(
        id: '6',
        image: FImages.zaraLogo,
        name: 'ZARA',
        isFeatured: true,
        productsCount: 20),
    BrandModel(
        id: '7',
        image: FImages.appleLogo,
        name: 'Apple',
        isFeatured: true,
        productsCount: 3008),
    BrandModel(
        id: '4',
        image: FImages.adidasLogo,
        name: 'Adidas',
        isFeatured: true,
        productsCount: 1923),
    BrandModel(
        id: '5',
        image: FImages.jordanLogo,
        name: 'Jordans',
        isFeatured: true,
        productsCount: 122),
    BrandModel(
        id: '8',
        image: FImages.kenwoodLogo,
        name: 'Kenwood',
        isFeatured: true,
        productsCount: 345),
    BrandModel(
        id: '9',
        image: FImages.hermanMillerLogo,
        name: 'Herman Miller',
        isFeatured: true,
        productsCount: 432),
    BrandModel(id: '11', image: FImages.acerlogo, name: 'ACER', isFeatured: true, productsCount: 342),
    BrandModel(id: '12', image: FImages.lgLogo, name: 'LG', isFeatured: true, productsCount: 3234),
    BrandModel(id: '13', image: FImages.sonyLogo, name: 'SONY', isFeatured: true, productsCount: 3234),
    BrandModel(id: '14', image: FImages.tomiLogo, name: 'TOMi', isFeatured: true, productsCount: 235),
  ];
}
