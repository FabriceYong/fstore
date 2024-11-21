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
        id: '1',
        name: 'Sports',
        image: FImages.sportIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '2',
        name: 'Electronics',
        image: FImages.furnitureIcon,
        isFeatured: true,
        parentId: '2'),
    CategoryModel(
        id: '3',
        name: 'Furniture',
        image: FImages.electronicsIcon,
        isFeatured: true,
        parentId: '3'),
    CategoryModel(
      id: '16',
      name: 'Clothes',
      image: FImages.clothIcon,
      isFeatured: true,
      parentId: '16',
    ),
    CategoryModel(
        id: '7',
        name: 'Animals',
        image: FImages.animalIcon,
        isFeatured: true,
        parentId: '7'),
    CategoryModel(
      id: '8',
      name: 'Shoes',
      image: FImages.shoeIcon,
      isFeatured: true,
      parentId: '8',
    ),
    CategoryModel(
      id: '5',
      name: 'Cosmetics',
      image: FImages.cosmeticsIcon,
      isFeatured: true,
      parentId: '5',
    ),
    CategoryModel(
      id: '10',
      name: 'Jewelry',
      image: FImages.jewelryIcon,
      isFeatured: true,
      parentId: '10',
    ),
    CategoryModel(
      id: '11',
      name: 'Toys',
      image: FImages.toyIcon,
      isFeatured: true,
      parentId: '11',
    ),
  ];

  static final List<ProductModel> products = [
    ProductModel(
        id: '015',
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
      id: '012',
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
      id: '013',
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
        id: '014',
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
    ProductModel(
      id: '002',
      title: 'LG gram Superslim 15.6-inch Ultra Thin and Lightweight Laptop',
      stock: 394,
      isFeatured: true,
      thumbnail: FImages.productImage84,
      description:
          '15” FHD (1920 x 1080) Anti-Glare OLED Display with DCI-P3 100% - Work, play, and watch like never before. A 15" OLED anti-glare screen with up to a 100% DCI-P3 color gamut expression and VESA DisplayHDR 500 True Black, delivers exceptional image resolution with true-to-life detail and stunning, deep black levels. And a 1,000,000:1 contrast ratio means that colors and images can be presented exactly as they were intended, for an unrivaled viewing experience. Windows 11 - Windows 11 brings you closer to what you love. Pursue your passions and maximize your productivity with the new Windows 11. Built with tools to help you multitask, think, create, and connect—all designed with simplicity and intuition in mind.',
      brand: BrandModel(id: '12', image: FImages.lgLogo, name: 'LG'),
      images: [
        FImages.productImage84,
        FImages.productImage85,
        FImages.productImage86,
        FImages.productImage87,
        FImages.productImage88,
        FImages.productImage89
      ],
      price: 1999.9,
      salePrice: 1399.9,
      sku: 'ABR4568',
      categoryId: '2',
      productAttributes: [
        ProductAttributesModel(name: 'Size', values: ['32GB', '16GB']),
        ProductAttributesModel(
          name: 'Color',
          values: ['Blue', 'Black'],
        )
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
        id: '011',
        title:
            'SAMSUNG 16" Galaxy Book4 Pro Laptop PC Computer, Intel Core 7 Ultra Processor 1TB',
        stock: 343,
        isFeatured: true,
        thumbnail: FImages.productImage78,
        description:
            'POWER FOR YOUR MOST PRODUCTIVE DAYS: Breeze through every task with a powerful Intel processor; Intel Core Ultra 7 processor 155H; Enhanced with AI Intel ARC Graphics POWERFUL. LIGHT. AMAZINGLY SLIM: Take premium power on the go with an ultralight and amazingly slim laptop. 16” Thickness: 12.5mm, Weight: 3.44 lbs; 14" Thickness: 11.6mm, Weight: 2.71 lbs. BRACE YOURSELF FOR THE ULTIMATE SCREEN EXPERIENCE: Tackle what you need to do then kick back with what you love to do on a spacious 14" or 16" Dynamic AMOLED 2X touchscreen that’s bright, crisp and vivid',
        brand: BrandModel(id: '2', image: FImages.samsungLogo, name: 'SAMSUNG'),
        images: [
          FImages.productImage78,
          FImages.productImage79,
          FImages.productImage80,
          FImages.productImage81,
          FImages.productImage82,
          FImages.productImage83
        ],
        price: 1749.99,
        salePrice: 1249.55,
        sku: 'ABR4568',
        categoryId: '2',
        productAttributes: [
          ProductAttributesModel(name: 'Size', values: ['32GB', '16GB']),
          ProductAttributesModel(name: 'Color', values: ['Blue', 'Black']),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '003',
        title: 'Apple 2023 MacBook Pro Laptop M3 chip with 8‑core CPU',
        stock: 154,
        isFeatured: true,
        price: 1890.99,
        salePrice: 1650,
        description:
            'UPERCHARGED BY M3 — With an 8-core CPU and 10-core GPU, the Apple M3 chip can help you blaze through everyday multitasking and take on pro projects like editing thousands of photos or 4K video. BUILT FOR APPLE INTELLIGENCE — Apple Intelligence helps you write, express yourself, and get things done effortlessly. It draws on your personal context while setting a brand-new standard for privacy in AI. Coming in beta this fall.',
        brand: BrandModel(id: '7', image: FImages.appleLogo, name: 'Apple'),
        sku: 'ABR4568',
        categoryId: '2',
        thumbnail: FImages.productImage90,
        images: [
          FImages.productImage90,
          FImages.productImage91,
          FImages.productImage92,
          FImages.productImage93,
          FImages.productImage94,
        ],
        productAttributes: [
          ProductAttributesModel(name: 'Size', values: ['8GB', '16GB']),
          ProductAttributesModel(
              name: 'Color', values: ['Grey', 'White', 'Black'])
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '004',
        title:
            'LG gram 17” Lightweight Laptop, Intel 13th Gen Core i7 Evo Platform',
        stock: 865,
        price: 1456,
        salePrice: 1240,
        isFeatured: true,
        description:
            '13th Gen Intel Core i7 Processor - Powered by Intel’s Evo 13th Gen processor and Intel Iris Xe graphics, this LG gram is engineered to keep users multitasking with ease. You can accomplish those intensive daily demands from crunching numbers, to editing a masterpiece with processor power that won\'t slow you down.16GB LPDDR5 RAM - 16GB of memory to a substantial clock speed of 6000 MHz, we’re making it simple to do work and play with minimal buffering Intel Iris Xe Graphics - A remarkable 16GB LPDDR5 RAM, 16GB of memory to a substantial clock speed of 6000 MHz, we’re making it simple to do work and play with minimal buffering.16GB LPDDR5 RAM - 16GB of memory to a substantial clock speed of 6000 MHz, we’re making it simple to do work and play with',
        brand: BrandModel(id: '12', image: FImages.lgLogo, name: 'LG'),
        sku: 'ABR4568',
        categoryId: '2',
        images: [
          FImages.productImage95,
          FImages.productImage96,
          FImages.productImage97,
          FImages.productImage98,
          FImages.productImage99,
          FImages.productImage100,
          FImages.productImage101,
          FImages.productImage102,
          FImages.productImage103,
          FImages.productImage104,
        ],
        productAttributes: [
          ProductAttributesModel(name: 'Size', values: ['32GB', '16GB']),
          ProductAttributesModel(
              name: 'Color', values: ['Black', 'White', 'Grey'])
        ],
        thumbnail: FImages.productImage95,
        productType: 'ProductType.single'),
    ProductModel(
        id: '005',
        title: 'Men\'s Basketball Shoe High-Top Athletic Running Sneakers',
        stock: 265,
        price: 120,
        salePrice: 115,
        description:
            '【Shock-absorbing & Cushioning sole】Mens basketball shoes with rubber sole, providing a stable shock absorption effect of the heel landing, which can support long hours of exercise, and the powerful cushioning function protection for your feet and knees.',
        isFeatured: true,
        brand: BrandModel(id: '5', image: FImages.jordanLogo, name: 'Jordans'),
        sku: 'ABR4568',
        categoryId: '8',
        images: [
          FImages.productImage105,
          FImages.productImage106,
          FImages.productImage107,
          FImages.productImage108,
          FImages.productImage109,
          FImages.productImage110,
        ],
        thumbnail: FImages.productImage105,
        productAttributes: [
          ProductAttributesModel(
              name: 'Size', values: ['EU34', 'EU32', 'EU30', 'EU36']),
          ProductAttributesModel(
              name: 'Color',
              values: ['Yellow', 'Red', 'white', 'Blue', 'Black']),
        ],
        productVariations: [
          ProductVariationsModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: FImages.productImage105,
              description:
                  '【Traction & Stability】Non-Slip rubber outsole with the deep forefoot tread provides extra traction, helps control ankle roll-over to prevent injury.',
              attributes: {'Color': 'Yellow', 'Size': 'EU34'}),
          ProductVariationsModel(
              id: '2',
              stock: 12,
              price: 120,
              salePrice: 115,
              image: FImages.productImage106,
              attributes: {'Color': 'Red', 'Size': 'EU30'}),
          ProductVariationsModel(
              id: '3',
              stock: 5,
              price: 118,
              salePrice: 109.4,
              image: FImages.productImage107,
              attributes: {'Color': 'Black', 'Size': 'EU32'}),
          ProductVariationsModel(
              id: '4',
              stock: 7,
              price: 114,
              salePrice: 104.8,
              image: FImages.productImage109,
              attributes: {'Color': 'Blue', 'Size': 'EU36'}),
          ProductVariationsModel(
              id: '5',
              stock: 10,
              price: 125,
              salePrice: 113.5,
              image: FImages.productImage110,
              attributes: {'Color': 'Red', 'Size': 'EU34'}),
          ProductVariationsModel(
              id: '6',
              stock: 15,
              price: 125,
              salePrice: 113.5,
              image: FImages.productImage112,
              attributes: {'Color': 'white', 'Size': 'EU32'}),
        ],
        productType: 'ProductType.variable'),
    ProductModel(
      id: '116',
      stock: 198,
      title: 'PUMA Men\'s Caven 2.0 Sneaker',
      salePrice: 480,
      price: 584,
      description:
          'EYE-CATCHING: Combining feel-good SoftFoam+ comfort with a cool retro aesthetic, these sneakers are the essence of sports-infused style. Features a sleek PUMA Formstrip on the sides, with iconic PUMA branding throughout the upper, tongue and heel.',
      isFeatured: true,
      brand: BrandModel(id: '3', image: FImages.pumaLogo, name: 'Puma'),
      sku: 'ABR4568',
      categoryId: '8',
      images: [
        FImages.productImage113,
        FImages.productImage114,
        FImages.productImage115,
        FImages.productImage116,
        FImages.productImage117,
        FImages.productImage118,
      ],
      thumbnail: FImages.productImage113,
      productAttributes: [
        ProductAttributesModel(
            name: 'Size', values: ['EU34', 'EU32', 'EU30', 'EU36']),
        ProductAttributesModel(
            name: 'Color', values: ['White', 'Black', 'Grey', 'Yellow', 'Red']),
      ],
      productVariations: [
        ProductVariationsModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: FImages.productImage113,
            description:
                'TIMELESS DESIGN: The Caven 2.0 is a subtle spin on a classic 1980s basketball silhouette for a look that\'s a bona fide classic - courtside and beyond.',
            attributes: {'Color': 'White', 'Size': 'EU34'}),
        ProductVariationsModel(
            id: '2',
            stock: 12,
            price: 120,
            salePrice: 115,
            image: FImages.productImage115,
            attributes: {'Color': 'Black', 'Grey': 'EU30'}),
        ProductVariationsModel(
            id: '3',
            stock: 5,
            price: 118,
            salePrice: 109.4,
            image: FImages.productImage116,
            attributes: {'Color': 'Red', 'Size': 'EU32'}),
        ProductVariationsModel(
            id: '4',
            stock: 7,
            price: 114,
            salePrice: 104.8,
            image: FImages.productImage118,
            attributes: {'Color': 'Yellow', 'Size': 'EU36'}),
        ProductVariationsModel(
            id: '5',
            stock: 10,
            price: 125,
            salePrice: 113.5,
            image: FImages.productImage119,
            attributes: {'Color': 'Black', 'Size': 'EU34'}),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '017',
      title:
          'Sony Alpha 7 IV Full-frame Mirrorless Interchangeable Lens Camera with 28-70mm Zoom Lens Kit',
      stock: 66,
      price: 2689.99,
      salePrice: 2258.56,
      description:
          '33MP full-frame Exmor R back-illuminated CMOS sensor, 8x more powerful, next generation BIONZ XR image processing engine, Up to 4K 60p 10-bit 4:2:2 w/ full pixel readout in all recording formats, 7K oversampling full-frame 4K 30p 10-bit 4:2:2 w/ no pixel binning, Beautiful color expression made simple with S-Cinetone color profile',
      isFeatured: true,
      brand: BrandModel(id: '13', image: FImages.sonyLogo, name: 'SONY'),
      thumbnail: FImages.productImage120,
      sku: 'ABR4568',
      categoryId: '2',
      images: [
        FImages.productImage120,
        FImages.productImage121,
        FImages.productImage122,
        FImages.productImage123,
        FImages.productImage124,
        FImages.productImage125,
        FImages.productImage126,
        FImages.productImage127,
      ],
      productAttributes: [
        ProductAttributesModel(name: 'Size', values: ['EU32', 'EU30']),
        ProductAttributesModel(name: 'Color', values: ['Black', 'White']),
      ],
      productType: 'ProductType.single',
    )
  ];

  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        image: FImages.nikeLogo,
        name: 'Nike',
        isFeatured: true,
        productsCount: 100),
    BrandModel(
        id: '2',
        image: FImages.samsungLogo,
        name: 'SAMSUNG',
        isFeatured: true,
        productsCount: 3234),
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
    BrandModel(
        id: '11',
        image: FImages.acerlogo,
        name: 'ACER',
        isFeatured: true,
        productsCount: 342),
    BrandModel(
        id: '12',
        image: FImages.lgLogo,
        name: 'LG',
        isFeatured: true,
        productsCount: 3234),
    BrandModel(
        id: '13',
        image: FImages.sonyLogo,
        name: 'SONY',
        isFeatured: true,
        productsCount: 3234),
    BrandModel(
        id: '14',
        image: FImages.tomiLogo,
        name: 'TOMi',
        isFeatured: true,
        productsCount: 235),
  ];
}
