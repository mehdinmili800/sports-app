class Product {
  final String name;
  final double price;
  final String? imageAsset;    // المسار المحلي أو رابط شبكة
  final String? placeholder;   // كتابة placeholder فقط لو لم توجد صورة

  const Product(this.name, this.price, {this.imageAsset, this.placeholder});
}
