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

class _BusinessManagerAppState
    extends State<BusinessManagerApp> {
  AppLanguage language = AppLanguage.persian;
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final savedLanguage =
        prefs.getString('language') ?? 'persian';

    setState(() {
      language = AppLanguage.values.firstWhere(
        (item) => item.name == savedLanguage,
        orElse: () => AppLanguage.persian,
      );

      themeMode = prefs.getBool('dark_mode') == true
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  Future<void> _setLanguage(AppLanguage value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'language',
      value.name,
    );

    setState(() {
      language = value;
    });
  }

  Future<void> _setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('dark_mode', value);

    setState(() {
      themeMode =
          value ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPersian =
        language == AppLanguage.persian;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Manager',
      themeMode: themeMode,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      locale: _locale(language),
      home: Directionality(
        textDirection: isPersian
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: HomeScreen(
          language: language,
          onLanguageChanged: _setLanguage,
          onThemeChanged: _setDarkMode,
        ),
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF6750A4),
      scaffoldBackgroundColor:
          const Color(0xFFF7F5FA),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme:
          InputDecorationTheme(
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
      scaffoldBackgroundColor:
          const Color(0xFF101014),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme:
          InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Locale _locale(AppLanguage language) {
    switch (language) {
      case AppLanguage.persian:
        return const Locale('fa');
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.french:
        return const Locale('fr');
      case AppLanguage.german:
        return const Locale('de');
      case AppLanguage.chinese:
        return const Locale('zh');
    }
  }
}

class AppText {
  final AppLanguage language;

  const AppText(this.language);

  String get dashboard => _t(
        'داشبورد',
        'Dashboard',
        'Tableau de bord',
        'Dashboard',
        '仪表板',
      );

  String get orders => _t(
        'سفارش‌ها',
        'Orders',
        'Commandes',
        'Bestellungen',
        '订单',
      );

  String get appointments => _t(
        'نوبت‌ها',
        'Appointments',
        'Rendez-vous',
        'Termine',
        '预约',
      );

  String get finance => _t(
        'مالی',
        'Finance',
        'Finance',
        'Finanzen',
        '财务',
      );

  String get products => _t(
        'محصولات',
        'Products',
        'Produits',
        'Produkte',
        '产品',
      );

  String get customers => _t(
        'مشتریان',
        'Customers',
        'Clients',
        'Kunden',
        '客户',
      );

  String get reports => _t(
        'گزارش‌ها',
        'Reports',
        'Rapports',
        'Berichte',
        '报告',
      );

  String get settings => _t(
        'تنظیمات',
        'Settings',
        'Paramètres',
        'Einstellungen',
        '设置',
      );

  String get income => _t(
        'درآمد',
        'Income',
        'Revenus',
        'Einnahmen',
        '收入',
      );

  String get expenses => _t(
        'هزینه',
        'Expenses',
        'Dépenses',
        'Ausgaben',
        '支出',
      );

  String get profit => _t(
        'سود خالص',
        'Net Profit',
        'Bénéfice net',
        'Nettogewinn',
        '净利润',
      );

  String get today => _t(
        'امروز',
        'Today',
        "Aujourd'hui",
        'Heute',
        '今天',
      );

  String get month => _t(
        'این ماه',
        'This Month',
        'Ce mois',
        'Dieser Monat',
        '本月',
      );

  String get year => _t(
        'امسال',
        'This Year',
        'Cette année',
        'Dieses Jahr',
        '今年',
      );

  String get all => _t(
        'کل',
        'All Time',
        'Total',
        'Gesamt',
        '全部',
      );

  String get add => _t(
        'افزودن',
        'Add',
        'Ajouter',
        'Hinzufügen',
        '添加',
      );

  String get save => _t(
        'ذخیره',
        'Save',
        'Enregistrer',
        'Speichern',
        '保存',
      );

  String get cancel => _t(
        'لغو',
        'Cancel',
        'Annuler',
        'Abbrechen',
        '取消',
      );

  String get language => _t(
        'زبان',
        'Language',
        'Langue',
        'Sprache',
        '语言',
      );

  String get darkMode => _t(
        'حالت تاریک',
        'Dark Mode',
        'Mode sombre',
        'Dunkelmodus',
        '深色模式',
      );

  String get quickActions => _t(
        'دسترسی سریع',
        'Quick Actions',
        'Actions rapides',
        'Schnellaktionen',
        '快速操作',
      );

  String get businessSummary => _t(
        'خلاصه کسب‌وکار',
        'Business Summary',
        'Résumé de l’entreprise',
        'Geschäftsübersicht',
        '业务概览',
      );

  String _t(
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
  List<OrderModel> orders = [];
  List<AppointmentModel> appointments = [];
  List<FinanceModel> incomes = [];
  List<FinanceModel> expenses = [];
  List<ProductModel> products = [];
  List<CustomerModel> customers = [];

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
      'orders':
          orders.map((e) => e.toJson()).toList(),
      'appointments':
          appointments.map((e) => e.toJson()).toList(),
      'incomes':
          incomes.map((e) => e.toJson()).toList(),
      'expenses':
          expenses.map((e) => e.toJson()).toList(),
      'products':
          products.map((e) => e.toJson()).toList(),
      'customers':
          customers.map((e) => e.toJson()).toList(),
    };
  }

  factory BusinessData.fromJson(
    Map<String, dynamic> json,
  ) {
    final result = BusinessData();

    result.orders =
        _parseList<OrderModel>(
      json['orders'],
      OrderModel.fromJson,
    );

    result.appointments =
        _parseList<AppointmentModel>(
      json['appointments'],
      AppointmentModel.fromJson,
    );

    result.incomes =
        _parseList<FinanceModel>(
      json['incomes'],
      FinanceModel.fromJson,
    );

    result.expenses =
        _parseList<FinanceModel>(
      json['expenses'],
      FinanceModel.fromJson,
    );

    result.products =
        _parseList<ProductModel>(
      json['products'],
      ProductModel.fromJson,
    );

    result.customers =
        _parseList<CustomerModel>(
      json['customers'],
      CustomerModel.fromJson,
    );

    return result;
  }
}

List<T> _parseList<T>(
  dynamic value,
  T Function(Map<String, dynamic>) parser,
) {
  if (value is! List) {
    return [];
  }

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer': customer,
        'description': description,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  factory OrderModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrderModel(
      id: json['id'] ?? '',
      customer: json['customer'] ?? '',
      description: json['description'] ?? '',
      amount:
          (json['amount'] as num?)?.toDouble() ?? 0,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer': customer,
        'description': description,
        'date': date.toIso8601String(),
      };

  factory AppointmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AppointmentModel(
      id: json['id'] ?? '',
      customer: json['customer'] ?? '',
      description:
          json['description'] ?? '',
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  factory FinanceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinanceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      amount:
          (json['amount'] as num?)?.toDouble() ?? 0,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'stock': stock,
      };

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price:
          (json['price'] as num?)?.toDouble() ?? 0,
      stock:
          (json['stock'] as num?)?.toInt() ?? 0,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'note': note,
      };

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
  final ValueChanged<AppLanguage>
      onLanguageChanged;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  final BusinessData data = BusinessData();

  int page = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs =
        await SharedPreferences.getInstance();

    final raw = prefs.getString('business_data');

    if (raw != null) {
      try {
        final decoded =
            jsonDecode(raw)
                as Map<String, dynamic>;

        final saved =
            BusinessData.fromJson(decoded);

        data.orders = saved.orders;
        data.appointments =
            saved.appointments;
        data.incomes = saved.incomes;
        data.expenses = saved.expenses;
        data.products = saved.products;
        data.customers = saved.customers;
      } catch (_) {}
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _saveData() async {
    final prefs =
        await SharedPreferences.getInstance();

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

    final pages = [
      DashboardPage(data: data),
      OrdersPage(
        data: data,
        onSave: _saveData,
      ),
      AppointmentsPage(
        data: data,
        onSave: _saveData,
      ),
      FinancePage(
        data: data,
        onSave: _saveData,
      ),
      ProductsPage(
        data: data,
        onSave: _saveData,
      ),
      CustomersPage(
        data: data,
        onSave: _saveData,
      ),
      ReportsPage(data: data),
      SettingsPage(
        language: widget.language,
        onLanguageChanged:
            widget.onLanguageChanged,
        onThemeChanged:
            widget.onThemeChanged,
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
          labels[page],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: NavigationDrawer(
        selectedIndex: page,
        onDestinationSelected: (index) {
          setState(() {
            page = index;
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
          ...List.generate(
            labels.length,
            (index) =>
                NavigationDrawerDestination(
              icon: Icon(icons[index]),
              label: Text(labels[index]),
            ),
          ),
        ],
      ),
      body: pages[page],
      bottomNavigationBar:
          NavigationBar(
        selectedIndex:
            page > 3 ? 0 : page,
        onDestinationSelected: (index) {
          setState(() {
            page = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon:
                Icon(icons[0]),
            label:
                labels[0],
          ),
          NavigationDestination(
            icon:
                Icon(icons[1]),
            label:
                labels[1],
          ),
          NavigationDestination(
            icon:
                Icon(icons[2]),
            label:
                labels[2],
          ),
          NavigationDestination(
            icon:
                Icon(icons[3]),
            label:
                labels[3],
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
        Text(
          'خلاصه کسب‌وکار',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        const Text(
          'مدیریت ساده و حرفه‌ای کسب‌وکار، کاملاً آفلاین.',
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount:
              MediaQuery.of(context)
                          .size
                          .width >=
                      700
                  ? 4
                  : 2,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _StatCard(
              title: 'درآمد کل',
              value:
                  _money(data.totalIncome),
              icon: Icons.trending_up,
            ),
            _StatCard(
              title: 'هزینه کل',
              value:
                  _money(data.totalExpenses),
              icon: Icons.trending_down,
            ),
            _StatCard(
              title: 'سود خالص',
              value:
                  _money(data.profit),
              icon: Icons.account_balance,
            ),
            _StatCard(
              title: 'سفارش‌ها',
              value:
                  data.orders.length.toString(),
              icon:
                  Icons.receipt_long,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding:
                const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'وضعیت امروز',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _ProgressRow(
                  label: 'نوبت‌ها',
                  value: data
                      .appointments.length
                      .toDouble(),
                ),
                _ProgressRow(
                  label: 'سفارش‌ها',
                  value: data.orders.length
                      .toDouble(),
                ),
                _ProgressRow(
                  label: 'مشتریان',
                  value: data.customers.length
                      .toDouble(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(18),
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
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final double value;

  const _ProgressRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        (value / 10).clamp(0.0, 1.0);

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(
                value.toInt().toString(),
              ),
            ],
          ),
          const SizedBox(height: 7),
          LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            borderRadius:
                BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

class
