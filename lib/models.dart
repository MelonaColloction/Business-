class TransactionItem {
  final int? id;
  final String type;
  final double amount;
  final String category;
  final String note;
  final String date;
  final String contact;
  final String paymentMethod;

  const TransactionItem({
    this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
    required this.contact,
    required this.paymentMethod,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'type': type,
    'amount': amount,
    'category': category,
    'note': note,
    'date': date,
    'contact': contact,
    'payment_method': paymentMethod,
  };

  factory TransactionItem.fromMap(Map<String, Object?> m) => TransactionItem(
    id: m['id'] as int?,
    type: m['type'] as String,
    amount: (m['amount'] as num).toDouble(),
    category: m['category'] as String,
    note: (m['note'] ?? '') as String,
    date: m['date'] as String,
    contact: (m['contact'] ?? '') as String,
    paymentMethod: (m['payment_method'] ?? '') as String,
  );
}

class ContactItem {
  final int? id;
  final String name;
  final String phone;
  final String role;
  final String note;

  const ContactItem({
    this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.note,
  });

  Map<String, Object?> toMap() => {
    'id': id, 'name': name, 'phone': phone, 'role': role, 'note': note,
  };

  factory ContactItem.fromMap(Map<String, Object?> m) => ContactItem(
    id: m['id'] as int?,
    name: m['name'] as String,
    phone: (m['phone'] ?? '') as String,
    role: (m['role'] ?? 'customer') as String,
    note: (m['note'] ?? '') as String,
  );
}

class AppointmentItem {
  final int? id;
  final String title;
  final String contact;
  final String date;
  final String time;
  final double amount;
  final String status;
  final String note;

  const AppointmentItem({
    this.id,
    required this.title,
    required this.contact,
    required this.date,
    required this.time,
    required this.amount,
    required this.status,
    required this.note,
  });

  Map<String, Object?> toMap() => {
    'id': id, 'title': title, 'contact': contact, 'date': date,
    'time': time, 'amount': amount, 'status': status, 'note': note,
  };

  factory AppointmentItem.fromMap(Map<String, Object?> m) => AppointmentItem(
    id: m['id'] as int?,
    title: m['title'] as String,
    contact: (m['contact'] ?? '') as String,
    date: m['date'] as String,
    time: m['time'] as String,
    amount: (m['amount'] as num).toDouble(),
    status: (m['status'] ?? 'scheduled') as String,
    note: (m['note'] ?? '') as String,
  );
}

class ProductItem {
  final int? id;
  final String name;
  final String kind;
  final double buyPrice;
  final double sellPrice;
  final double stock;

  const ProductItem({
    this.id,
    required this.name,
    required this.kind,
    required this.buyPrice,
    required this.sellPrice,
    required this.stock,
  });

  Map<String, Object?> toMap() => {
    'id': id, 'name': name, 'kind': kind, 'buy_price': buyPrice,
    'sell_price': sellPrice, 'stock': stock,
  };

  factory ProductItem.fromMap(Map<String, Object?> m) => ProductItem(
    id: m['id'] as int?,
    name: m['name'] as String,
    kind: (m['kind'] ?? 'product') as String,
    buyPrice: (m['buy_price'] as num).toDouble(),
    sellPrice: (m['sell_price'] as num).toDouble(),
    stock: (m['stock'] as num).toDouble(),
  );
}
