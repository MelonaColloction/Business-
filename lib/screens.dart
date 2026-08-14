import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database.dart';
import 'localization.dart';
import 'models.dart';

class HomeScreen extends StatefulWidget {
  final Locale locale;
  final ValueChanged<String> onLocaleChanged;
  final VoidCallback onThemeChanged;

  const HomeScreen({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  AppLocalizations get l => AppLocalizations(widget.locale);

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(l: l),
      OrdersPage(l: l),
      AppointmentsPage(l: l),
      FinancePage(l: l),
      MorePage(l: l, onLocaleChanged: widget.onLocaleChanged, onThemeChanged: widget.onThemeChanged),
    ];
    final labels = [l.t('home'), l.t('orders'), l.t('appointments'), l.t('finance'), l.t('more')];
    final icons = [Icons.dashboard_rounded, Icons.receipt_long_rounded, Icons.event_rounded,
      Icons.account_balance_wallet_rounded, Icons.menu_rounded];

    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: List.generate(5, (i) =>
          NavigationDestination(icon: Icon(icons[i]), label: labels[i])),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final AppLocalizations l;
  const DashboardPage({super.key, required this.l});
  @override State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<TransactionItem> data = [];
  List<AppointmentItem> appointments = [];

  @override
  void initState() { super.initState(); load(); }

  Future<void> load() async {
    data = await AppDatabase.instance.transactions();
    appointments = await AppDatabase.instance.appointments();
    if (mounted) setState(() {});
  }

  double sum(String type) => data.where((x) => x.type == type).fold(0, (a, b) => a + b.amount);

  @override
  Widget build(BuildContext context) {
    final revenue = sum('income');
    final expenses = sum('expense');
    final profit = revenue - expenses;
    return RefreshIndicator(
      onRefresh: load,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(children: [
            Expanded(child: Text(widget.l.t('dashboard'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold))),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
          ]),
          Text(DateFormat.yMMMMd(widget.l.locale.languageCode).format(DateTime.now()),
            style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            children: [
              StatCard(title: widget.l.t('revenue'), value: money(revenue), icon: Icons.trending_up_rounded),
              StatCard(title: widget.l.t('expenses'), value: money(expenses), icon: Icons.trending_down_rounded),
              StatCard(title: widget.l.t('profit'), value: money(profit), icon: Icons.savings_rounded),
              StatCard(title: widget.l.t('appointments'), value: '${appointments.length}', icon: Icons.event_available_rounded),
            ],
          ),
          const SizedBox(height: 18),
          Text(widget.l.t('quick_add'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: QuickButton(icon: Icons.add_card_rounded, label: widget.l.t('income'),
              onTap: () async { await showTransactionDialog(context, widget.l, 'income'); load(); })),
            Expanded(child: QuickButton(icon: Icons.remove_circle_outline_rounded, label: widget.l.t('expense'),
              onTap: () async { await showTransactionDialog(context, widget.l, 'expense'); load(); })),
          ]),
          const SizedBox(height: 20),
          Text(widget.l.t('appointments'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...appointments.take(5).map((a) => ListTile(
            leading: const CircleAvatar(child: Icon(Icons.event)),
            title: Text(a.title),
            subtitle: Text('${a.date} • ${a.time} • ${a.contact}'),
            trailing: Text(money(a.amount)),
          )),
        ],
      ),
    );
  }
}

class OrdersPage extends StatefulWidget {
  final AppLocalizations l;
  const OrdersPage({super.key, required this.l});
  @override State<OrdersPage> createState() => _OrdersPageState();
}
class _OrdersPageState extends State<OrdersPage> {
  List<TransactionItem> orders = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    orders = (await AppDatabase.instance.transactions()).where((x) => x.category == 'order').toList();
    if (mounted) setState(() {});
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.l.t('orders'))),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () async { await showTransactionDialog(context, widget.l, 'income', category: 'order'); load(); },
      icon: const Icon(Icons.add), label: Text(widget.l.t('add'))),
    body: orders.isEmpty
      ? Center(child: Text(widget.l.t('no_data')))
      : ListView.builder(itemCount: orders.length, itemBuilder: (_, i) {
          final x = orders[i];
          return Dismissible(
            key: ValueKey(x.id), background: Container(color: Colors.red),
            onDismissed: (_) async { await AppDatabase.instance.deleteTransaction(x.id!); },
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.receipt_long)),
              title: Text(x.contact.isEmpty ? widget.l.t('orders') : x.contact),
              subtitle: Text('${x.date} • ${x.note}'),
              trailing: Text(money(x.amount)),
            ),
          );
        }),
  );
}

class AppointmentsPage extends StatefulWidget {
  final AppLocalizations l;
  const AppointmentsPage({super.key, required this.l});
  @override State<AppointmentsPage> createState() => _AppointmentsPageState();
}
class _AppointmentsPageState extends State<AppointmentsPage> {
  List<AppointmentItem> data = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { data = await AppDatabase.instance.appointments(); if (mounted) setState(() {}); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.l.t('appointments'))),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () async { await showAppointmentDialog(context, widget.l); load(); },
      icon: const Icon(Icons.add), label: Text(widget.l.t('add'))),
    body: data.isEmpty ? Center(child: Text(widget.l.t('no_data'))) :
      ListView.builder(itemCount: data.length, itemBuilder: (_, i) {
        final a = data[i];
        return Dismissible(
          key: ValueKey(a.id), background: Container(color: Colors.red),
          onDismissed: (_) => AppDatabase.instance.deleteAppointment(a.id!),
          child: Card(child: ListTile(
            leading: CircleAvatar(child: Text(a.time.split(':').first)),
            title: Text(a.title),
            subtitle: Text('${a.date} • ${a.time} • ${a.contact}'),
            trailing: Text(money(a.amount)),
          )),
        );
      }),
  );
}

class FinancePage extends StatefulWidget {
  final AppLocalizations l;
  const FinancePage({super.key, required this.l});
  @override State<FinancePage> createState() => _FinancePageState();
}
class _FinancePageState extends State<FinancePage> {
  List<TransactionItem> data = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { data = await AppDatabase.instance.transactions(); if (mounted) setState(() {}); }
  double total(String type) => data.where((x) => x.type == type).fold(0, (a, b) => a + b.amount);

  @override Widget build(BuildContext context) {
    final income = total('income'), expense = total('expense');
    return Scaffold(
      appBar: AppBar(title: Text(widget.l.t('finance'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(context: context, builder: (_) => SafeArea(child: Wrap(children: [
            ListTile(leading: const Icon(Icons.add), title: Text(widget.l.t('income')),
              onTap: () async { Navigator.pop(context); await showTransactionDialog(context, widget.l, 'income'); load(); }),
            ListTile(leading: const Icon(Icons.remove), title: Text(widget.l.t('expense')),
              onTap: () async { Navigator.pop(context); await showTransactionDialog(context, widget.l, 'expense'); load(); }),
          ])));
        }, child: const Icon(Icons.add)),
      body: ListView(padding: const EdgeInsets.all(14), children: [
        Row(children: [
          Expanded(child: StatCard(title: widget.l.t('revenue'), value: money(income), icon: Icons.arrow_upward)),
          Expanded(child: StatCard(title: widget.l.t('expenses'), value: money(expense), icon: Icons.arrow_downward)),
        ]),
        StatCard(title: widget.l.t('profit_loss'), value: money(income - expense), icon: Icons.calculate_rounded),
        const SizedBox(height: 12),
        ...data.map((x) => ListTile(
          leading: Icon(x.type == 'income' ? Icons.add_circle : Icons.remove_circle,
            color: x.type == 'income' ? Colors.green : Colors.red),
          title: Text(x.category),
          subtitle: Text('${x.date} • ${x.note}'),
          trailing: Text(money(x.amount)),
        )),
      ]),
    );
  }
}

class MorePage extends StatefulWidget {
  final AppLocalizations l;
  final ValueChanged<String> onLocaleChanged;
  final VoidCallback onThemeChanged;
  const MorePage({super.key, required this.l, required this.onLocaleChanged, required this.onThemeChanged});
  @override State<MorePage> createState() => _MorePageState();
}
class _MorePageState extends State<MorePage> {
  @override Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Text(widget.l.t('more'), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      _tile(Icons.people_alt_rounded, widget.l.t('contacts'), () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactsPage(l: widget.l)))),
      _tile(Icons.inventory_2_rounded, widget.l.t('products'), () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductsPage(l: widget.l)))),
      _tile(Icons.bar_chart_rounded, widget.l.t('reports'), () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportsPage(l: widget.l)))),
      const Divider(height: 32),
      Text(widget.l.t('settings'), style: Theme.of(context).textTheme.titleLarge),
      ListTile(
        leading: const Icon(Icons.language), title: Text(widget.l.t('language')),
        trailing: DropdownButton<String>(
          value: widget.l.locale.languageCode,
          items: const [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'fa', child: Text('فارسی')),
            DropdownMenuItem(value: 'fr', child: Text('Français')),
            DropdownMenuItem(value: 'de', child: Text('Deutsch')),
            DropdownMenuItem(value: 'zh', child: Text('中文')),
          ],
          onChanged: (v) { if (v != null) widget.onLocaleChanged(v); },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.dark_mode_rounded), title: Text(widget.l.t('theme')),
        trailing: FilledButton.tonal(onPressed: widget.onThemeChanged, child: Text(widget.l.t('dark'))),
      ),
    ],
  );

  Widget _tile(IconData icon, String title, VoidCallback onTap) => Card(
    child: ListTile(leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: onTap),
  );
}

class ContactsPage extends StatefulWidget {
  final AppLocalizations l;
  const ContactsPage({super.key, required this.l});
  @override State<ContactsPage> createState() => _ContactsPageState();
}
class _ContactsPageState extends State<ContactsPage> {
  List<ContactItem> data = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { data = await AppDatabase.instance.contacts(); if (mounted) setState(() {}); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.l.t('contacts'))),
    floatingActionButton: FloatingActionButton(onPressed: () async { await showContactDialog(context, widget.l); load(); }, child: const Icon(Icons.add)),
    body: data.isEmpty ? Center(child: Text(widget.l.t('no_data'))) :
      ListView.builder(itemCount: data.length, itemBuilder: (_, i) {
        final x = data[i];
        return Dismissible(key: ValueKey(x.id), background: Container(color: Colors.red),
          onDismissed: (_) => AppDatabase.instance.deleteContact(x.id!),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(x.name), subtitle: Text('${x.phone} • ${x.role}'),
          ));
      }),
  );
}

class ProductsPage extends StatefulWidget {
  final AppLocalizations l;
  const ProductsPage({super.key, required this.l});
  @override State<ProductsPage> createState() => _ProductsPageState();
}
class _ProductsPageState extends State<ProductsPage> {
  List<ProductItem> data = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { data = await AppDatabase.instance.products(); if (mounted) setState(() {}); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.l.t('products'))),
    floatingActionButton: FloatingActionButton(onPressed: () async { await showProductDialog(context, widget.l); load(); }, child: const Icon(Icons.add)),
    body: data.isEmpty ? Center(child: Text(widget.l.t('no_data'))) :
      ListView.builder(itemCount: data.length, itemBuilder: (_, i) {
        final x = data[i];
        return Dismissible(key: ValueKey(x.id), background: Container(color: Colors.red),
          onDismissed: (_) => AppDatabase.instance.deleteProduct(x.id!),
          child: Card(child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.inventory)),
            title: Text(x.name),
            subtitle: Text('${widget.l.t('stock')}: ${x.stock}'),
            trailing: Text(money(x.sellPrice)),
          )));
      }),
  );
}

class ReportsPage extends StatefulWidget {
  final AppLocalizations l;
  const ReportsPage({super.key, required this.l});
  @override State<ReportsPage> createState() => _ReportsPageState();
}
class _ReportsPageState extends State<ReportsPage> {
  List<TransactionItem> data = [];
  String period = 'all';
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { data = await AppDatabase.instance.transactions(); if (mounted) setState(() {}); }

  bool inPeriod(TransactionItem x) {
    if (period == 'all') return true;
    final d = DateTime.tryParse(x.date) ?? DateTime.now();
    final now = DateTime.now();
    if (period == 'today') return d.year == now.year && d.month == now.month && d.day == now.day;
    if (period == 'month') return d.year == now.year && d.month == now.month;
    return d.year == now.year;
  }

  @override Widget build(BuildContext context) {
    final filtered = data.where(inPeriod).toList();
    final inc = filtered.where((x) => x.type == 'income').fold(0.0, (a,b)=>a+b.amount);
    final exp = filtered.where((x) => x.type == 'expense').fold(0.0, (a,b)=>a+b.amount);
    return Scaffold(
      appBar: AppBar(title: Text(widget.l.t('reports'))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        SegmentedButton<String>(
          segments: [
            ButtonSegment(value: 'today', label: Text(widget.l.t('today'))),
            ButtonSegment(value: 'month', label: Text(widget.l.t('month'))),
            ButtonSegment(value: 'year', label: Text(widget.l.t('year'))),
            ButtonSegment(value: 'all', label: Text(widget.l.t('all_time'))),
          ],
          selected: {period}, onSelectionChanged: (v) => setState(() => period = v.first),
        ),
        const SizedBox(height: 18),
        StatCard(title: widget.l.t('revenue'), value: money(inc), icon: Icons.trending_up),
        StatCard(title: widget.l.t('expenses'), value: money(exp), icon: Icons.trending_down),
        StatCard(title: widget.l.t('profit'), value: money(inc-exp), icon: Icons.savings),
      ]),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value; final IconData icon;
  const StatCard({super.key, required this.title, required this.value, required this.icon});
  @override Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(16), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(icon, size: 28), const SizedBox(height: 8),
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        FittedBox(child: Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
      ],
    )),
  );
}

class QuickButton extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap;
  const QuickButton({super.key, required this.icon, required this.label, required this.onTap});
  @override Widget build(BuildContext context) => Card(
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(20),
      child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [Icon(icon, size: 30), const SizedBox(height: 8), Text(label)]))),
  );
}

String money(double value) => NumberFormat('#,##0.##').format(value);

Future<void> showTransactionDialog(BuildContext context, AppLocalizations l, String type, {String? category}) async {
  final amount = TextEditingController(), cat = TextEditingController(text: category ?? (type == 'income' ? 'sales' : 'general')),
      note = TextEditingController(), contact = TextEditingController();
  await showDialog(context: context, builder: (_) => AlertDialog(
    title: Text(type == 'income' ? l.t('income') : l.t('expense')),
    content: SingleChildScrollView(child: Column(children: [
      TextField(controller: amount, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l.t('amount'))),
      TextField(controller: cat, decoration: InputDecoration(labelText: l.t('category'))),
      TextField(controller: contact, decoration: InputDecoration(labelText: l.t('customer'))),
      TextField(controller: note, decoration: InputDecoration(labelText: l.t('note'))),
    ])),
    actions: [
      TextButton(onPressed: ()=>Navigator.pop(context), child: Text(l.t('cancel'))),
      FilledButton(onPressed: () async {
        final value = double.tryParse(amount.text.replaceAll(',', '')) ?? 0;
        if (value <= 0) return;
        await AppDatabase.instance.addTransaction(TransactionItem(
          type: type, amount: value, category: cat.text.trim().isEmpty ? 'general' : cat.text.trim(),
          note: note.text.trim(), contact: contact.text.trim(),
          date: DateTime.now().toIso8601String(), paymentMethod: 'cash'));
        if (context.mounted) Navigator.pop(context);
      }, child: Text(l.t('save'))),
    ],
  ));
}

Future<void> showContactDialog(BuildContext context, AppLocalizations l) async {
  final name=TextEditingController(), phone=TextEditingController(), note=TextEditingController();
  String role='customer';
  await showDialog(context: context, builder: (_) => StatefulBuilder(builder: (context,set) => AlertDialog(
    title: Text(l.t('contacts')),
    content: SingleChildScrollView(child: Column(children: [
      TextField(controller: name, decoration: InputDecoration(labelText: l.t('name'))),
      TextField(controller: phone, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: l.t('phone'))),
      DropdownButtonFormField<String>(value: role, items: [
        DropdownMenuItem(value:'customer',child:Text(l.t('customer'))),
        DropdownMenuItem(value:'supplier',child:Text(l.t('supplier'))),
      ], onChanged:(v)=>set(()=>role=v!)),
      TextField(controller: note, decoration: InputDecoration(labelText: l.t('note'))),
    ])),
    actions: [
      TextButton(onPressed: ()=>Navigator.pop(context), child: Text(l.t('cancel'))),
      FilledButton(onPressed: () async {
        if(name.text.trim().isEmpty) return;
        await AppDatabase.instance.addContact(ContactItem(name:name.text.trim(),phone:phone.text.trim(),role:role,note:note.text.trim()));
        if(context.mounted) Navigator.pop(context);
      }, child: Text(l.t('save'))),
    ],
  )));
}

Future<void> showAppointmentDialog(BuildContext context, AppLocalizations l) async {
  final title=TextEditingController(), contact=TextEditingController(), amount=TextEditingController(), note=TextEditingController();
  DateTime date=DateTime.now(); TimeOfDay time=TimeOfDay.now();
  await showDialog(context: context, builder: (_) => StatefulBuilder(builder: (context,set) => AlertDialog(
    title: Text(l.t('appointments')),
    content: SingleChildScrollView(child: Column(children: [
      TextField(controller:title, decoration:InputDecoration(labelText:l.t('service'))),
      TextField(controller:contact, decoration:InputDecoration(labelText:l.t('customer'))),
      TextField(controller:amount, keyboardType:TextInputType.number, decoration:InputDecoration(labelText:l.t('amount'))),
      ListTile(title:Text('${l.t('date')}: ${DateFormat('yyyy-MM-dd').format(date)}'),
        onTap:() async { final d=await showDatePicker(context:context,firstDate:DateTime.now().subtract(const Duration(days:3650)),lastDate:DateTime.now().add(const Duration(days:3650)),initialDate:date); if(d!=null)set(()=>date=d); }),
      ListTile(title:Text('${l.t('time')}: ${time.format(context)}'),
        onTap:() async { final t=await showTimePicker(context:context,initialTime:time); if(t!=null)set(()=>time=t); }),
      TextField(controller:note, decoration:InputDecoration(labelText:l.t('note'))),
    ])),
    actions:[
      TextButton(onPressed:()=>Navigator.pop(context),child:Text(l.t('cancel'))),
      FilledButton(onPressed:() async {
        await AppDatabase.instance.addAppointment(AppointmentItem(
          title:title.text.trim().isEmpty?l.t('service'):title.text.trim(), contact:contact.text.trim(),
          date:DateFormat('yyyy-MM-dd').format(date), time:time.format(context),
          amount:double.tryParse(amount.text.replaceAll(',',''))??0, status:'scheduled', note:note.text.trim()));
        if(context.mounted)Navigator.pop(context);
      },child:Text(l.t('save'))),
    ],
  )));
}

Future<void> showProductDialog(BuildContext context, AppLocalizations l) async {
  final name=TextEditingController(), buy=TextEditingController(), sell=TextEditingController(), stock=TextEditingController();
  await showDialog(context: context, builder: (_) => AlertDialog(
    title:Text(l.t('products')),
    content:SingleChildScrollView(child:Column(children:[
      TextField(controller:name,decoration:InputDecoration(labelText:l.t('name'))),
      TextField(controller:buy,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:l.t('buy_price'))),
      TextField(controller:sell,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:l.t('sell_price'))),
      TextField(controller:stock,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:l.t('stock'))),
    ])),
    actions:[
      TextButton(onPressed:()=>Navigator.pop(context),child:Text(l.t('cancel'))),
      FilledButton(onPressed:() async {
        if(name.text.trim().isEmpty)return;
        await AppDatabase.instance.addProduct(ProductItem(name:name.text.trim(),kind:'product',
          buyPrice:double.tryParse(buy.text.replaceAll(',',''))??0,
          sellPrice:double.tryParse(sell.text.replaceAll(',',''))??0,
          stock:double.tryParse(stock.text.replaceAll(',',''))??0));
        if(context.mounted)Navigator.pop(context);
      },child:Text(l.t('save'))),
    ],
  ));
}
