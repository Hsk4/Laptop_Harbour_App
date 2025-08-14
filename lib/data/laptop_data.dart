import '../models/Laptop_model.dart';

final List<Laptop> laptops = [
  //GAMING LAPTOPS
  Laptop(
    id: 'l1',
    name: 'Acer Predator Helios 300',
    imageUrl: '',
    description:
        'Powerful gaming laptop with Intel Core i7, NVIDIA RTX 4060, 16GB RAM, and 512GB SSD. Perfect for high-performance gaming.',
    price: 1400,
    category: 'Gaming',
    brand: 'Acer',
  ),
  Laptop(
    id: 'l2',
    name: 'MSI Katana 15',
    imageUrl: '',
    description:
        'Affordable gaming powerhouse featuring Intel Core i7, NVIDIA RTX 4050, 16GB DDR4 RAM, and 1TB SSD with advanced cooling.',
    price: 1099,
    category: 'Gaming',
    brand: 'MSI',
  ),
  Laptop(
    id: 'l3',
    name: 'ASUS ROG Strix G15',
    imageUrl: '',
    description:
        'High-performance gaming laptop with AMD Ryzen 7, NVIDIA RTX 4060, 16GB RAM, 512GB SSD, and RGB keyboard lighting.',
    price: 1299,
    category: 'Gaming',
    brand: 'ASUS',
  ),
  Laptop(
    id: 'l4',
    name: 'HP OMEN 16',
    imageUrl: '',
    description:
        'Versatile gaming laptop powered by Intel Core i7, NVIDIA RTX 4060, 16GB RAM, 512GB SSD with customizable RGB lighting.',
    price: 1399,
    category: 'Gaming',
    brand: 'HP',
  ),
  Laptop(
    id: 'l5',
    name: 'Lenovo Legion 5',
    imageUrl: '',
    description:
        'Gaming laptop with AMD Ryzen 7, NVIDIA RTX 4060, 16GB RAM, 1TB SSD, and Legion Coldfront cooling system.',
    price: 1350,
    category: 'Gaming',
    brand: 'Lenovo',
  ),
  Laptop(
    id: 'l6',
    name: 'Razer Blade 15',
    imageUrl: '',
    description:
        'Premium gaming laptop with Intel Core i7-13800H, NVIDIA RTX 4070, 32GB RAM, 1TB SSD, and 15.6" QHD 240Hz display.',
    price: 2199,
    category: 'Gaming',
    brand: 'Razer',
  ),

  //MACBOOKS
  Laptop(
    id: 'l7',
    name: 'MacBook Air M2 (13-inch)',
    imageUrl: '',
    description:
        'Revolutionary laptop powered by Apple M2 chip, 8GB unified memory, 256GB SSD with stunning Liquid Retina display.',
    price: 1199,
    category: 'MacBooks',
    brand: 'Apple',
  ),
  Laptop(
    id: 'l8',
    name: 'MacBook Air M2 (15-inch)',
    imageUrl: '',
    description:
        'Larger MacBook Air with Apple M2 chip, 8GB unified memory, 256GB SSD, and spacious 15.3" Liquid Retina display.',
    price: 1299,
    category: 'MacBooks',
    brand: 'Apple',
  ),
  Laptop(
    id: 'l9',
    name: 'MacBook Pro M2 (13-inch)',
    imageUrl: '',
    description:
        'Compact professional laptop with Apple M2 chip, 8GB unified memory, 256GB SSD, Touch Bar, and active cooling.',
    price: 1299,
    category: 'MacBooks',
    brand: 'Apple',
  ),
  Laptop(
    id: 'l10',
    name: 'MacBook Pro M3 (14-inch)',
    imageUrl: '',
    description:
        'Professional laptop featuring Apple M3 Pro chip, 18GB unified memory, 512GB SSD with Liquid Retina XDR display.',
    price: 1599,
    category: 'MacBooks',
    brand: 'Apple',
  ),
  Laptop(
    id: 'l11',
    name: 'MacBook Pro M3 (16-inch)',
    imageUrl: '',
    description:
        'Large screen MacBook Pro with Apple M3 Pro chip, 18GB unified memory, 512GB SSD, and 16.2" Liquid Retina XDR display.',
    price: 2499,
    category: 'MacBooks',
    brand: 'Apple',
  ),
  Laptop(
    id: 'l12',
    name: 'MacBook Pro M3 Max (16-inch)',
    imageUrl: '',
    description:
        'Ultimate creative powerhouse with Apple M3 Max chip, 36GB unified memory, 1TB SSD for intensive professional work.',
    price: 3499,
    category: 'MacBooks',
    brand: 'Apple',
  ),

  //CHROMEBOOKS
  Laptop(
    id: 'l13',
    name: 'Google Pixelbook Go',
    imageUrl: '',
    description:
        'Premium Chromebook with Intel Core m3, 8GB RAM, 64GB storage, ultra-portable design with exceptional battery life.',
    price: 649,
    category: 'Chromebooks',
    brand: 'Google',
  ),
  Laptop(
    id: 'l14',
    name: 'ASUS Chromebook Flip C434',
    imageUrl: '',
    description:
        'Versatile 2-in-1 Chromebook featuring Intel Core m3, 4GB RAM, 64GB eMMC storage with 360-degree hinge.',
    price: 569,
    category: 'Chromebooks',
    brand: 'ASUS',
  ),
  Laptop(
    id: 'l15',
    name: 'HP Chromebook x360 14',
    imageUrl: '',
    description:
        'Affordable 2-in-1 Chromebook with Intel Pentium processor, 4GB RAM, 64GB storage, and durable design.',
    price: 499,
    category: 'Chromebooks',
    brand: 'HP',
  ),
  Laptop(
    id: 'l16',
    name: 'Lenovo Chromebook Duet 5',
    imageUrl: '',
    description:
        'Detachable Chromebook tablet with Snapdragon 7c processor, 4GB RAM, 64GB storage, includes keyboard and USI pen.',
    price: 429,
    category: 'Chromebooks',
    brand: 'Lenovo',
  ),
  Laptop(
    id: 'l17',
    name: 'Acer Chromebook Spin 713',
    imageUrl: '',
    description:
        'High-performance Chromebook featuring Intel Core i5, 8GB RAM, 256GB SSD with premium aluminum build.',
    price: 729,
    category: 'Chromebooks',
    brand: 'Acer',
  ),

  //OFFICE LAPTOPS
  Laptop(
    id: 'l18',
    name: 'Lenovo ThinkPad E14',
    imageUrl: '',
    description:
        'Reliable business laptop with Intel Core i5, 8GB RAM, 256GB SSD, durable ThinkPad design with excellent keyboard.',
    price: 749,
    category: 'Office',
    brand: 'Lenovo',
  ),
  Laptop(
    id: 'l19',
    name: 'Dell Inspiron 15 3000',
    imageUrl: '',
    description:
        'Budget-friendly office laptop featuring Intel Core i3, 8GB RAM, 256GB SSD with compact design and long battery life.',
    price: 549,
    category: 'Office',
    brand: 'Dell',
  ),
  Laptop(
    id: 'l20',
    name: 'HP Pavilion 14',
    imageUrl: '',
    description:
        'Stylish productivity laptop with Intel Core i5, 12GB RAM, 512GB SSD, ultra-slim profile with vibrant 14" display.',
    price: 699,
    category: 'Office',
    brand: 'HP',
  ),
  Laptop(
    id: 'l21',
    name: 'ASUS VivoBook 15',
    imageUrl: '',
    description:
        'Modern office laptop featuring AMD Ryzen 5, 8GB RAM, 512GB SSD with lightweight design and fingerprint sensor.',
    price: 629,
    category: 'Office',
    brand: 'ASUS',
  ),
  Laptop(
    id: 'l22',
    name: 'Acer Aspire 5',
    imageUrl: '',
    description:
        'Versatile office laptop with Intel Core i5, 8GB RAM, 256GB SSD, backlit keyboard, HD webcam, and multiple ports.',
    price: 579,
    category: 'Office',
    brand: 'Acer',
  ),

  //WORKSTATION LAPTOPS
  Laptop(
    id: 'l23',
    name: 'Dell Precision 5570',
    imageUrl: '',
    description:
        'Professional workstation with Intel Xeon processor, NVIDIA RTX A2000, 32GB ECC RAM, 1TB SSD for CAD and engineering.',
    price: 2899,
    category: 'Workstation',
    brand: 'Dell',
  ),
  Laptop(
    id: 'l24',
    name: 'HP ZBook Fury 15 G9',
    imageUrl: '',
    description:
        'Mobile workstation powerhouse featuring Intel Core i9, NVIDIA RTX A5500, 64GB RAM, 2TB SSD for video editing.',
    price: 3199,
    category: 'Workstation',
    brand: 'HP',
  ),
  Laptop(
    id: 'l25',
    name: 'Lenovo ThinkPad P1 Gen 5',
    imageUrl: '',
    description:
        'Premium mobile workstation with Intel Core i7, NVIDIA RTX A3000, 32GB RAM, 1TB SSD in ultra-portable design.',
    price: 2749,
    category: 'Workstation',
    brand: 'Lenovo',
  ),
  Laptop(
    id: 'l26',
    name: 'MSI WS66 11UMT',
    imageUrl: '',
    description:
        'Creator-focused workstation laptop with Intel Core i7, NVIDIA RTX A3000, 32GB RAM, 1TB NVMe SSD, color-accurate display.',
    price: 2599,
    category: 'Workstation',
    brand: 'MSI',
  ),
  Laptop(
    id: 'l27',
    name: 'ASUS ProArt StudioBook 16',
    imageUrl: '',
    description:
        'Creative workstation featuring AMD Ryzen 9, NVIDIA RTX 4070, 32GB RAM, 1TB SSD with PANTONE validated display.',
    price: 2399,
    category: 'Workstation',
    brand: 'ASUS',
  ),

  // more laptops...
];
