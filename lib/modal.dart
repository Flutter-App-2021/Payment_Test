class ProductClass {
  late final String title;
  late final String description;
  late final String amount;
  late  int quantity;

  ProductClass({
    required this.title,
    required this.description,
    required this.amount,
    required this.quantity,
  });
}

List<ProductClass> productList = [
  ProductClass(
    title: "Product 1",
    description: "This is product 1",
    amount: "1",
    quantity: 0,
  ),
  ProductClass(
    title: "Product 2",
    description: "This is product 2",
    amount: "1",
    quantity: 0,
  ),
  ProductClass(
    title: "Product 3",
    description: "This is product 3",
    amount: "1",
    quantity: 0,
  ),
  ProductClass(
    title: "Product 4",
    description: "This is product 4",
    amount: "1",
    quantity: 0,
  ),
  ProductClass(
    title: "Product 5",
    description: "This is product 5",
    amount: "1",
    quantity: 0,
  ),
];

