import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessManagerApp extends StatefulWidget {
  const BusinessManagerApp({super.key});

  @override
  State<BusinessManagerApp> createState() => _BusinessManagerAppState();
}

class _BusinessManagerAppState extends State<BusinessManagerApp> {
  String languageCode = 'fa';
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      languageCode = prefs.getString('language_code') ?? 'fa';
      darkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  Future<void> setLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);

    if (!mounted) return;

    setState(() {
      languageCode = code;
    });
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);

    if (!mounted) return;

    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool rtl = languageCode == 'fa';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Manager',
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: Directionality(
        textDirection:
            rtl ? TextDirection.rtl : TextDirection.ltr,
        child: HomeScreen(
          languageCode: languageCode,
          darkMode: darkMode,
          onLanguageChanged: setLanguage,
          onDarkModeChanged: setDarkMode,
        ),
      ),
    );
  }
}

ThemeData createLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: const Color(0xFF6750A4),
    scaffoldBackgroundColor: const Color(0xFFF7F7FA),
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

ThemeData createDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF9A82DB),
    scaffoldBackgroundColor: const Color(0xFF101014),
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

class AppStrings {
  final String code;

  const AppStrings(this.code);

  String get dashboard => tr(
        code,
        'داشبورد',
        'Dashboard',
        'Tableau de bord',
        'Dashboard',
        '仪表板',
      );

  String get orders => tr(
        code,
        'سفارش‌ها',
        'Orders',
        'Commandes',
        'Bestellungen',
        '订单',
      );

  String get appointments => tr(
        code,
        'نوبت‌ها',
        'Appointments',
        'Rendez-vous',
        'Termine',
        '预约',
      );

  String get finance => tr(
        code,
        'مالی',
        'Finance',
        'Finance',
        'Finanzen',
        '财务',
      );

  String get products => tr(
        code,
        'محصولات',
        'Products',
        'Produits',
        'Produkte',
        '产品',
      );

  String get customers => tr(
        code,
        'مشتریان',
        'Customers',
        'Clients',
        'Kunden',
        '客户',
      );

  String get reports => tr(
        code,
        'گزارش‌ها',
        'Reports',
        'Rapports',
        'Berichte',
        '报告',
      );

  String get settings => tr(
        code,
        'تنظیمات',
        'Settings',
        'Paramètres',
        'Einstellungen',
        '设置',
      );

  String get income => tr(
        code,
        'درآمد',
        'Income',
        'Revenus',
        'Einnahmen',
        '收入',
      );

  String get expenses => tr(
        code,
        'هزینه‌ها',
        'Expenses',
        'Dépenses',
        'Ausgaben',
        '支出',
      );

  String get profit => tr(
        code,
        'سود خالص',
        'Net Profit',
        'Bénéfice net',
        'Nettogewinn',
        '净利润',
      );

  String get language => tr(
        code,
        'زبان',
        'Language',
        'Langue',
        'Sprache',
        '语言',
      );

  String get darkMode => tr(
        code,
        'حالت تاریک',
        'Dark Mode',
        'Mode sombre',
        'Dunkelmodus',
        '深色模式',
      );

  String get add => tr(
        code,
        'افزودن',
        'Add',
        'Ajouter',
        'Hinzufügen',
        '添加',
      );

  String get save => tr(
        code,
        'ذخیره',
        'Save',
        'Enregistrer',
        'Speichern',
        '保存',
      );

  String get cancel => tr(
        code,
        'لغو',
        'Cancel',
        'Annuler',
        'Abbrechen',
        '取消',
      );

  String get noData => tr(
        code,
        'اطلاعاتی وجود ندارد',
        'No data available',
        'Aucune donnée',
        'Keine Daten',
        '暂无数据',
      );
}

String tr(
  String code,
  String fa,
  String en,
  String fr,
  String de,
  String zh,
) {
  switch (code) {
    case 'en':
      return en;
    case 'fr':
      return fr;
    case 'de':
      return de;
    case 'zh':
      return zh;
    case 'fa':
    default:
      return fa;
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
    List<OrderModel>? orders,
    List<AppointmentModel>? appointments,
    List<FinanceModel>? incomes,
    List<FinanceModel>? expenses,
    List<ProductModel>? products,
    List<CustomerModel>? customers,
  })  : orders = orders ?? [],
        appointments = appointments ?? [],
        incomes = incomes ?? [],
        expenses = expenses ?? [],
        products = products ?? [],
        customers = customers ?? [];

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
    return BusinessData(
      orders: parseList<OrderModel>(
        json['orders'],
        OrderModel.fromJson,
      ),
      appointments: parseList<AppointmentModel>(
        json['appointments'],
        AppointmentModel.fromJson,
      ),
      incomes: parseList<FinanceModel>(
        json['incomes'],
        FinanceModel.fromJson,
      ),
      expenses: parseList<FinanceModel>(
        json['expenses'],
        FinanceModel.fromJson,
      ),
      products: parseList<ProductModel>(
        json['products'],
        ProductModel.fromJson,
      ),
      customers: parseList<CustomerModel>(
        json['customers'],
        CustomerModel.fromJson,
      ),
    );
  }
}

List<T> parseList<T>(
  dynamic value,
  T Function(Map<String, dynamic>) parser,
) {
  if (value is! List) {
    return <T>[];
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
  final String languageCode;
  final bool darkMode;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<bool> onDarkModeChanged;

  const HomeScreen({
    super.key,
    required this.languageCode,
    required this.darkMode,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
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
    loadBusinessData();
  }

  Future<void> loadBusinessData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('business_data');

    if (raw != null) {
      try {
        final decoded =
            jsonDecode(raw) as Map<String, dynamic>;

        final loaded =
            BusinessData.fromJson(decoded);

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

  Future<void> saveBusinessData() async {
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
    final strings = AppStrings(widget.languageCode);

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final pages = [
      DashboardPage(
        data: data,
        strings: strings,
      ),
      OrdersPage(
        data: data,
        onSave: saveBusinessData,
        strings: strings,
      ),
      AppointmentsPage(
        data: data,
        onSave: saveBusinessData,
        strings: strings,
      ),
      FinancePage(
        data: data,
        onSave: saveBusinessData,
        strings: strings,
      ),
      ProductsPage(
        data: data,
        onSave: saveBusinessData,
        strings: strings,
      ),
      CustomersPage(
        data: data,
        onSave: saveBusinessData,
        strings: strings,
      ),
      ReportsPage(
        data: data,
        strings: strings,
      ),
      SettingsPage(
        languageCode: widget.languageCode,
        darkMode: widget.darkMode,
        onLanguageChanged:
            widget.onLanguageChanged,
        onDarkModeChanged:
            widget.onDarkModeChanged,
        strings: strings,
      ),
    ];

    final labels = [
      strings.dashboard,
      strings.orders,
      strings.appointments,
      strings.finance,
      strings.products,
      strings.customers,
      strings.reports,
      strings.settings,
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
            padding:
                EdgeInsets.symmetric(horizontal: 28),
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
        selectedIndex:
            selectedIndex > 3 ? 0 : selectedIndex,
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
  final AppStrings strings;

  const DashboardPage({
    super.key,
    required this.data,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          strings.dashboard,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount:
              MediaQuery.of(context).size.width >= 700
                  ? 4
                  : 2,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            StatCard(
              title: strings.income,
              value: money(data.totalIncome),
              icon: Icons.trending_up,
            ),
            StatCard(
              title: strings.expenses,
              value: money(data.totalExpenses),
              icon: Icons.trending_down,
            ),
            StatCard(
              title: strings.profit,
              value: money(data.profit),
              icon: Icons.account_balance,
            ),
            StatCard(
              title: strings.orders,
              value: data.orders.length.toString(),
              icon: Icons.receipt_long,
            ),
          ],
        ),
      ],
    );
  }
}

class OrdersPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const OrdersPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.orders,
      emptyText: strings.noData,
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
          strings.add,
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
            amount:
                double.tryParse(result[2]) ?? 0,
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
  final AppStrings strings;

  const AppointmentsPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.appointments,
      emptyText: strings.noData,
      icon: Icons.calendar_month,
      items: [
        for (final appointment in data.appointments)
          ListItemData(
            title: appointment.customer,
            subtitle: appointment.description,
            trailing:
                formatDate(appointment.date),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          strings.add,
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
  final AppStrings strings;

  const FinancePage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        StatCard(
          title: strings.income,
          value: money(data.totalIncome),
          icon: Icons.trending_up,
        ),
        StatCard(
          title: strings.expenses,
          value: money(data.totalExpenses),
          icon: Icons.trending_down,
        ),
        StatCard(
          title: strings.profit,
          value: money(data.profit),
          icon: Icons.account_balance,
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () =>
              addFinance(context, true),
          icon: const Icon(Icons.add),
          label: Text(strings.income),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () =>
              addFinance(context, false),
          icon: const Icon(Icons.remove),
          label: Text(strings.expenses),
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
      income ? strings.income : strings.expenses,
      [
        'عنوان',
        'مبلغ',
      ],
    );

    if (result == null) return;

    final item = FinanceModel(
      id: generateId(),
      title: result[0],
      amount:
          double.tryParse(result[1]) ?? 0,
      date: DateTime.now(),
    );

    if (income) {
      data.incomes.add(item);
    } else {
      data.expenses.add(item);
    }

    await onSave();
  }
}

class ProductsPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const ProductsPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.products,
      emptyText: strings.noData,
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
          strings.add,
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
            price:
                double.tryParse(result[1]) ?? 0,
            stock:
                int.tryParse(result[2]) ?? 0,
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
  final AppStrings strings;

  const CustomersPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.customers,
      emptyText: strings.noData,
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
          strings.add,
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
  final AppStrings strings;

  const ReportsPage({
    super.key,
    required this.data,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        ReportCard(
          title: 'امروز',
          income:
              periodTotal(data.incomes, now, 0),
          expenses:
              periodTotal(data.expenses, now, 0),
        ),
        ReportCard(
          title: 'این ماه',
          income:
              periodTotal(data.incomes, now, 1),
          expenses:
              periodTotal(data.expenses, now, 1),
        ),
        ReportCard(
          title: 'امسال',
          income:
              periodTotal(data.incomes, now, 2),
          expenses:
              periodTotal(data.expenses, now, 2),
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
  final String languageCode;
  final bool darkMode;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<bool> onDarkModeChanged;
  final AppStrings strings;

  const SettingsPage({
    super.key,
    required this.languageCode,
    required this.darkMode,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Card(
          child: ListTile(
            leading:
                const Icon(Icons.language),
            title: Text(strings.language),
            subtitle:
                Text(languageName(languageCode)),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title:
                        Text(strings.language),
                    children: [
                      for (final code in [
                        'fa',
                        'en',
                        'fr',
                        'de',
                        'zh',
                      ])
                        SimpleDialogOption(
                          onPressed: () {
                            onLanguageChanged(code);
                            Navigator.pop(context);
                          },
                          child:
                              Text(languageName(code)),
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
            secondary:
                const Icon(Icons.dark_mode),
            title: Text(strings.darkMode),
            value: darkMode,
            onChanged: onDarkModeChanged,
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
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70),
            const SizedBox(height: 15),
            Text(emptyText),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('افزودن'),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Align(
          alignment:
              AlignmentDirectional.centerStart,
          child: FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text(title),
          ),
        ),
        const SizedBox(height: 15),
        for (final item in items)
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(icon),
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing:
                  item.trailing.isEmpty
                      ? null
                      : Text(
                          item.trailing,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
            const SizedBox(height: 14),
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
              value:
                  money(income - expenses),
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
      padding:
          const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
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

Future<List<String>?> formDialog(
  BuildContext context,
  String title,
  List<String> fields,
) async {
  final controllers =
      <TextEditingController>[];

  for (int i = 0; i < fields.length; i++) {
    controllers.add(
      TextEditingController(),
    );
  }

  final result =
      await showDialog<List<String>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0;
                  i < fields.length;
                  i++)
                Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: TextField(
                    controller:
                        controllers[i],
                    decoration:
                        InputDecoration(
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
              Navigator.pop(context);
            },
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(
                context,
                controllers
                    .map(
                      (controller) =>
                          controller.text
                              .trim(),
                    )
                    .toList(),
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
    bool matches = false;

    if (type == 0) {
      matches =
          item.date.year == now.year &&
          item.date.month == now.month &&
          item.date.day == now.day;
    } else if (type == 1) {
      matches =
          item.date.year == now.year &&
          item.date.month == now.month;
    } else if (type == 2) {
      matches =
          item.date.year == now.year;
    }

    if (matches) {
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

String languageName(String code) {
  switch (code) {
    case 'en':
      return 'English';
    case 'fr':
      return 'Français';
    case 'de':
      return 'Deutsch';
    case 'zh':
      return '中文';
    case 'fa':
    default:
      return 'فارسی';
  }
}
