import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  persian,
  english,
  french,
  german,
  chinese,
}

class BusinessManagerApp extends StatefulWidget {
  const BusinessManagerApp({super.key});

  @override
  State<BusinessManagerApp> createState() =>
      _BusinessManagerAppState();
}

class _BusinessManagerAppState extends State<BusinessManagerApp> {
  AppLanguage language = AppLanguage.persian;
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final savedLanguage = prefs.getString('language');
    final dark = prefs.getBool('dark_mode') ?? false;

    if (!mounted) return;

    setState(() {
      language = _languageFromString(savedLanguage);
      themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> changeLanguage(AppLanguage value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('language', value.name);

    if (!mounted) return;

    setState(() {
      language = value;
    });
  }

  Future<void> changeTheme(bool dark) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('dark_mode', dark);

    if (!mounted) return;

    setState(() {
      themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rtl = language == AppLanguage.persian;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Manager',
      themeMode: themeMode,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      home: Directionality(
        textDirection:
            rtl ? TextDirection.rtl : TextDirection.ltr,
        child: HomeScreen(
          language: language,
          onLanguageChanged: changeLanguage,
          onThemeChanged: changeTheme,
        ),
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF6750A4),
      scaffoldBackgroundColor: const Color(0xFFF7F7FA),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFF9A82DB),
      scaffoldBackgroundColor: const Color(0xFF101014),
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

AppLanguage _languageFromString(String? value) {
  for (final item in AppLanguage.values) {
    if (item.name == value) {
      return item;
    }
  }

  return AppLanguage.persian;
}

class AppText {
  final AppLanguage language;

  const AppText(this.language);

  String get dashboard => _text(
        'داشبورد',
        'Dashboard',
        'Tableau de bord',
        'Dashboard',
        '仪表板',
      );

  String get orders => _text(
        'سفارش‌ها',
        'Orders',
        'Commandes',
        'Bestellungen',
        '订单',
      );

  String get appointments => _text(
        'نوبت‌ها',
        'Appointments',
        'Rendez-vous',
        'Termine',
        '预约',
      );

  String get finance => _text(
        'مالی',
        'Finance',
        'Finance',
        'Finanzen',
        '财务',
      );

  String get products => _text(
        'محصولات',
        'Products',
        'Produits',
        'Produkte',
        '产品',
      );

  String get customers => _text(
        'مشتریان',
        'Customers',
        'Clients',
        'Kunden',
        '客户',
      );

  String get reports => _text(
        'گزارش‌ها',
        'Reports',
        'Rapports',
        'Berichte',
        '报告',
      );

  String get settings => _text(
        'تنظیمات',
        'Settings',
        'Paramètres',
        'Einstellungen',
        '设置',
      );

  String get income => _text(
        'درآمد',
        'Income',
        'Revenus',
        'Einnahmen',
        '收入',
      );

  String get expenses => _text(
        'هزینه',
        'Expenses',
        'Dépenses',
        'Ausgaben',
        '支出',
      );

  String get profit => _text(
        'سود خالص',
        'Net Profit',
        'Bénéfice net',
        'Nettogewinn',
        '净利润',
      );

  String get quickActions => _text(
        'دسترسی سریع',
        'Quick Actions',
        'Actions rapides',
        'Schnellaktionen',
        '快速操作',
      );

  String get businessSummary => _text(
        'خلاصه کسب‌وکار',
        'Business Summary',
        'Résumé de l’entreprise',
        'Geschäftsübersicht',
        '业务概览',
      );

  String get add => _text(
        'افزودن',
        'Add',
        'Ajouter',
        'Hinzufügen',
        '添加',
      );

  String get save => _text(
        'ذخیره',
        'Save',
        'Enregistrer',
        'Speichern',
        '保存',
      );

  String get cancel => _text(
        'لغو',
        'Cancel',
        'Annuler',
        'Abbrechen',
        '取消',
      );

  String get language => _text(
        'زبان',
        'Language',
        'Langue',
        'Sprache',
        '语言',
      );

  String get darkMode => _text(
        'حالت تاریک',
        'Dark Mode',
        'Mode sombre',
        'Dunkelmodus',
        '深色模式',
      );

  String get noData => _text(
        'اطلاعاتی وجود ندارد',
        'No data available',
        'Aucune donnée',
        'Keine Daten',
        '暂无数据',
      );

  String _text(
    String fa,
    String en,
    String fr,
    String de,
    String zh,
  ) {
    switch (language) {
      case AppLanguage.persian:
        return fa;
      case AppLanguage.english:
        return en;
      case AppLanguage.french:
        return fr;
      case AppLanguage.german:
        return de;
      case AppLanguage.chinese:
        return zh;
    }
  }
}

class BusinessData {
  List<OrderModel> orders;
  List<AppointmentModel> appointments;
  List<FinanceModel> incomes;
  List<FinanceModel> expenses;
  List<ProductModel> products;
  List<CustomerModel> customers;

  BusinessData({
    this.orders = const [],
    this.appointments = const [],
    this.incomes = const [],
    this.expenses = const [],
    this.products = const [],
    this.customers = const [],
  });

  double get totalIncome {
    return incomes.fold(
      0,
      (sum, item) => sum + item.amount,
    );
  }

  double get totalExpenses {
    return expenses.fold(
      0,
      (sum, item) => sum + item.amount,
    );
  }

  double get profit {
    return totalIncome - totalExpenses;
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((e) => e.toJson()).toList(),
      'appointments':
          appointments.map((e) => e.toJson()).toList(),
      'incomes': incomes.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'products': products.map((e) => e.toJson()).toList(),
      'customers':
          customers.map((e) => e.toJson()).toList(),
    };
  }

  factory BusinessData.fromJson(
    Map<String, dynamic> json,
  ) {
    return BusinessData(
      orders: _parseList(
        json['orders'],
        OrderModel.fromJson,
      ),
      appointments: _parseList(
        json['appointments'],
        AppointmentModel.fromJson,
      ),
      incomes: _parseList(
        json['incomes'],
        FinanceModel.fromJson,
      ),
      expenses: _parseList(
        json['expenses'],
        FinanceModel.fromJson,
      ),
      products: _parseList(
        json['products'],
        ProductModel.fromJson,
      ),
      customers: _parseList(
        json['customers'],
        CustomerModel.fromJson,
      ),
    );
  }
}

List<T> _parseList<T>(
  dynamic value,
  T Function(Map<String, dynamic>) parser,
) {
  if (value is! List) return [];

  return value
      .whereType<Map>()
      .map(
        (item) => parser(
          Map<String, dynamic>.from(item),
        ),
      )
      .toList();
}

class OrderModel {
  String id;
  String customer;
  String description;
  double amount;
  DateTime date;

  OrderModel({
    required this.id,
    required this.customer,
    required this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory OrderModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrderModel(
      id: json['id'] ?? '',
      customer: json['customer'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(
            json['date'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}

class AppointmentModel {
  String id;
  String customer;
  String description;
  DateTime date;

  AppointmentModel({
    required this.id,
    required this.customer,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory AppointmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AppointmentModel(
      id: json['id'] ?? '',
      customer: json['customer'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.tryParse(
            json['date'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}

class FinanceModel {
  String id;
  String title;
  double amount;
  DateTime date;

  FinanceModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory FinanceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinanceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(
            json['date'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}

class ProductModel {
  String id;
  String name;
  double price;
  int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }
}

class CustomerModel {
  String id;
  String name;
  String phone;
  String note;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'note': note,
    };
  }

  factory CustomerModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CustomerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      note: json['note'] ?? '',
    );
  }
}

class HomeScreen extends StatefulWidget {
  final AppLanguage language;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BusinessData data = BusinessData();

  int selectedIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString('business_data');

    if (raw != null) {
      try {
        final decoded =
            jsonDecode(raw) as Map<String, dynamic>;

        final loaded = BusinessData.fromJson(decoded);

        data.orders = loaded.orders;
        data.appointments = loaded.appointments;
        data.incomes = loaded.incomes;
        data.expenses = loaded.expenses;
        data.products = loaded.products;
        data.customers = loaded.customers;
      } catch (_) {}
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'business_data',
      jsonEncode(data.toJson()),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppText(widget.language);

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final pages = <Widget>[
      DashboardPage(data: data),
      OrdersPage(
        data: data,
        onSave: saveData,
      ),
      AppointmentsPage(
        data: data,
        onSave: saveData,
      ),
      FinancePage(
        data: data,
        onSave: saveData,
      ),
      ProductsPage(
        data: data,
        onSave: saveData,
      ),
      CustomersPage(
        data: data,
        onSave: saveData,
      ),
      ReportsPage(data: data),
      SettingsPage(
        language: widget.language,
        onLanguageChanged: widget.onLanguageChanged,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    final labels = [
      text.dashboard,
      text.orders,
      text.appointments,
      text.finance,
      text.products,
      text.customers,
      text.reports,
      text.settings,
    ];

    final icons = [
      Icons.dashboard_outlined,
      Icons.receipt_long_outlined,
      Icons.calendar_month_outlined,
      Icons.account_balance_wallet_outlined,
      Icons.inventory_2_outlined,
      Icons.people_outline,
      Icons.bar_chart_outlined,
      Icons.settings_outlined,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels[selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });

          Navigator.pop(context);
        },
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Text(
              'Business Manager',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < labels.length; i++)
            NavigationDrawerDestination(
              icon: Icon(icons[i]),
              label: Text(labels[i]),
            ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex > 3 ? 0 : selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(icons[0]),
            label: labels[0],
          ),
          NavigationDestination(
            icon: Icon(icons[1]),
            label: labels[1],
          ),
          NavigationDestination(
            icon: Icon(icons[2]),
            label: labels[2],
          ),
          NavigationDestination(
            icon: Icon(icons[3]),
            label: labels[3],
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final BusinessData data;

  const DashboardPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'خلاصه کسب‌وکار',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'مدیریت کسب‌وکار به صورت آفلاین',
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount:
              MediaQuery.of(context).size.width >= 700
                  ? 4
                  : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            StatCard(
              title: 'درآمد',
              value: money(data.totalIncome),
              icon: Icons.trending_up,
            ),
            StatCard(
              title: 'هزینه',
              value: money(data.totalExpenses),
              icon: Icons.trending_down,
            ),
            StatCard(
              title: 'سود خالص',
              value: money(data.profit),
              icon: Icons.account_balance,
            ),
            StatCard(
              title: 'سفارش‌ها',
              value: data.orders.length.toString(),
              icon: Icons.receipt_long,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'آمار کلی',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                InfoRow(
                  icon: Icons.calendar_month,
                  title: 'نوبت‌ها',
                  value:
                      data.appointments.length.toString(),
                ),
                InfoRow(
                  icon: Icons.people,
                  title: 'مشتریان',
                  value:
                      data.customers.length.toString(),
                ),
                InfoRow(
                  icon: Icons.inventory_2,
                  title: 'محصولات',
                  value:
                      data.products.length.toString(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrdersPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;

  const OrdersPage({
    super.key,
    required this.data,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: 'سفارش‌ها',
      emptyText: 'هنوز سفارشی ثبت نشده است.',
      icon: Icons.receipt_long,
      items: [
        for (final order in data.orders)
          ListItemData(
            title: order.customer,
            subtitle: order.description,
            trailing: money(order.amount),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          'ثبت سفارش',
          [
            'نام مشتری',
            'توضیحات',
            'مبلغ',
          ],
        );

        if (result == null) return;

        data.orders.add(
          OrderModel(
            id: generateId(),
            customer: result[0],
            description: result[1],
            amount: double.tryParse(result[2]) ?? 0,
            date: DateTime.now(),
          ),
        );

        await onSave();
      },
    );
  }
}

class AppointmentsPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;

  const AppointmentsPage({
    super.key,
    required this.data,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: 'نوبت‌ها',
      emptyText: 'هنوز نوبتی ثبت نشده است.',
      icon: Icons.calendar_month,
      items: [
        for (final appointment in data.appointments)
          ListItemData(
            title: appointment.customer,
            subtitle: appointment.description,
            trailing: formatDate(appointment.date),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          'ثبت نوبت',
          [
            'نام مشتری',
            'توضیحات',
          ],
        );

        if (result == null) return;

        data.appointments.add(
          AppointmentModel(
            id: generateId(),
            customer: result[0],
            description: result[1],
            date: DateTime.now(),
          ),
        );

        await onSave();
      },
    );
  }
}

class FinancePage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;

  const FinancePage({
    super.key,
    required this.data,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        StatCard(
          title: 'درآمد کل',
          value: money(data.totalIncome),
          icon: Icons.arrow_upward,
        ),
        StatCard(
          title: 'هزینه کل',
          value: money(data.totalExpenses),
          icon: Icons.arrow_downward,
        ),
        StatCard(
          title: 'سود خالص',
          value: money(data.profit),
          icon: Icons.account_balance_wallet,
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: () => addFinance(
            context,
            true,
          ),
          icon: const Icon(Icons.add),
          label: const Text('ثبت درآمد'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => addFinance(
            context,
            false,
          ),
          icon: const Icon(Icons.remove),
          label: const Text('ثبت هزینه'),
        ),
      ],
    );
  }

  Future<void> addFinance(
    BuildContext context,
    bool income,
  ) async {
    final result = await formDialog(
      context,
      income ? 'ثبت درآمد' : 'ثبت هزینه',
      [
        'عنوان',
        'مبلغ',
      ],
    );

    if (result == null) return;

    final finance = FinanceModel(
      id: generateId(),
      title: result[0],
      amount: double.tryParse(result[1]) ?? 0,
      date: DateTime.now(),
    );

    if (income) {
      data.incomes.add(finance);
    } else {
      data.expenses.add(finance);
    }

    await onSave();
  }
}

class ProductsPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;

  const ProductsPage({
    super.key,
    required this.data,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: 'محصولات',
      emptyText: 'محصولی ثبت نشده است.',
      icon: Icons.inventory_2,
      items: [
        for (final product in data.products)
          ListItemData(
            title: product.name,
            subtitle:
                'موجودی: ${product.stock}',
            trailing: money(product.price),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          'افزودن محصول',
          [
            'نام محصول',
            'قیمت',
            'موجودی',
          ],
        );

        if (result == null) return;

        data.products.add(
          ProductModel(
            id: generateId(),
            name: result[0],
            price: double.tryParse(result[1]) ?? 0,
            stock: int.tryParse(result[2]) ?? 0,
          ),
        );

        await onSave();
      },
    );
  }
}

class CustomersPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;

  const CustomersPage({
    super.key,
    required this.data,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: 'مشتریان',
      emptyText: 'هنوز مشتری ثبت نشده است.',
      icon: Icons.people,
      items: [
        for (final customer in data.customers)
          ListItemData(
            title: customer.name,
            subtitle: customer.phone,
            trailing: '',
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          'افزودن مشتری',
          [
            'نام',
            'شماره تماس',
            'یادداشت',
          ],
        );

        if (result == null) return;

        data.customers.add(
          CustomerModel(
            id: generateId(),
            name: result[0],
            phone: result[1],
            note: result[2],
          ),
        );

        await onSave();
      },
    );
  }
}

class ReportsPage extends StatelessWidget {
  final BusinessData data;

  const ReportsPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final todayIncome =
        periodTotal(data.incomes, now, 0);
    final todayExpense =
        periodTotal(data.expenses, now, 0);

    final monthIncome =
        periodTotal(data.incomes, now, 1);
    final monthExpense =
        periodTotal(data.expenses, now, 1);

    final yearIncome =
        periodTotal(data.incomes, now, 2);
    final yearExpense =
        periodTotal(data.expenses, now, 2);

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        ReportCard(
          title: 'امروز',
          income: todayIncome,
          expenses: todayExpense,
        ),
        ReportCard(
          title: 'این ماه',
          income: monthIncome,
          expenses: monthExpense,
        ),
        ReportCard(
          title: 'امسال',
          income: yearIncome,
          expenses: yearExpense,
        ),
        ReportCard(
          title: 'کل',
          income: data.totalIncome,
          expenses: data.totalExpenses,
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  final AppLanguage language;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.language),
            title: const Text('زبان برنامه'),
            subtitle: Text(languageName(language)),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  return SimpleDialog(
                    title: const Text('انتخاب زبان'),
                    children: [
                      for (final item in AppLanguage.values)
                        SimpleDialogOption(
                          onPressed: () {
                            onLanguageChanged(item);
                            Navigator.pop(dialogContext);
                          },
                          child: Text(
                            languageName(item),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Card(
          child: SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('حالت تاریک'),
            value:
                Theme.of(context).brightness ==
                    Brightness.dark,
            onChanged: onThemeChanged,
          ),
        ),
      ],
    );
  }
}

class DataListPage extends StatelessWidget {
  final String title;
  final String emptyText;
  final IconData icon;
  final List<ListItemData> items;
  final Future<void> Function() onAdd;

  const DataListPage({
    super.key,
    required this.title,
    required this.emptyText,
    required this.icon,
    required this.items,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 70,
              ),
              const SizedBox(height: 18),
              Text(
                emptyText,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('افزودن'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text('افزودن $title'),
          ),
        ),
        const SizedBox(height: 16),
        for (final item in items)
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(icon),
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: item.trailing.isEmpty
                  ? null
                  : Text(
                      item.trailing,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
      ],
    );
  }
}

class ListItemData {
  final String title;
  final String subtitle;
  final String trailing;

  const ListItemData({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 28),
            Text(title),
            Text(
              value,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final double income;
  final double expenses;

  const ReportCard({
    super.key,
    required this.title,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final profitValue = income - expenses;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            InfoRow(
              icon: Icons.arrow_upward,
              title: 'درآمد',
              value: money(income),
            ),
            InfoRow(
              icon: Icons.arrow_downward,
              title: 'هزینه',
              value: money(expenses),
            ),
            const Divider(),
            InfoRow(
              icon: Icons.account_balance,
              title: 'سود خالص',
              value: money(profitValue),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<String>?> formDialog(
  BuildContext context,
  String title,
  List<String> fields,
) async {
  final controllers = <TextEditingController>[
    for (int i = 0; i < fields.length; i++)
      TextEditingController(),
  ];

  final result = await showDialog<List<String>>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < fields.length; i++)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: controllers[i],
                    decoration: InputDecoration(
                      labelText: fields[i],
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(
                dialogContext,
                [
                  for (final controller in controllers)
                    controller.text.trim(),
                ],
              );
            },
            child: const Text('ذخیره'),
          ),
        ],
      );
    },
  );

  for (final controller in controllers) {
    controller.dispose();
  }

  return result;
}

double periodTotal(
  List<FinanceModel> list,
  DateTime now,
  int type,
) {
  double total = 0;

  for (final item in list) {
    bool match;

    if (type == 0) {
      match =
          item.date.year == now.year &&
          item.date.month == now.month &&
          item.date.day == now.day;
    } else if (type == 1) {
      match =
          item.date.year == now.year &&
          item.date.month == now.month;
    } else {
      match = item.date.year == now.year;
    }

    if (match) {
      total += item.amount;
    }
  }

  return total;
}

String money(double value) {
  return value.toStringAsFixed(0);
}

String generateId() {
  return DateTime.now()
      .microsecondsSinceEpoch
      .toString();
}

String formatDate(DateTime date) {
  final day =
      date.day.toString().padLeft(2, '0');
  final month =
      date.month.toString().padLeft(2, '0');
  final hour =
      date.hour.toString().padLeft(2, '0');
  final minute =
      date.minute.toString().padLeft(2, '0');

  return '$day/$month $hour:$minute';
}

String languageName(AppLanguage language) {
  switch (language) {
    case AppLanguage.persian:
      return 'فارسی';
    case AppLanguage.english:
      return 'English';
    case AppLanguage.french:
      return 'Français';
    case AppLanguage.german:
      return 'Deutsch';
    case AppLanguage.chinese:
      return '中文';
  }
}
