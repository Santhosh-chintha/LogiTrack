import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => CounterProvider(),
    child: const LogiTrackApp(),
  ));
}

class LogiTrackApp extends StatelessWidget {
  const LogiTrackApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LogiTrack',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16),
          ),
        ),
        home: const LogiTrackDashboard(),
        routes: {
          '/responsive': (_) => const ResponsiveScreen(),
          '/state': (_) => const StateScreen(),
          '/form': (_) => const ShipmentFormScreen(),
          '/animation': (_) => const AnimationScreen(),
          '/api': (_) => const RestApiScreen(),
        },
      );
}

class CounterProvider extends ChangeNotifier {
  int count = 0;
  void increase() { count++; notifyListeners(); }
  void decrease() { if (count > 0) { count--; notifyListeners(); } }
  void reset() { count = 0; notifyListeners(); }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const items = <({String title, String subtitle, IconData icon, Widget page})>[
    (title: 'Experiment 1 - Dart Basics', subtitle: 'Variables, types, operations and conditions', icon: Icons.code, page: DartBasicsScreen()),
    (title: 'Experiment 2 - Widgets & Layouts', subtitle: 'Row, Column, Stack and shipment UI', icon: Icons.dashboard, page: WidgetsLayoutScreen()),
    (title: 'Experiment 3 - Responsive UI', subtitle: 'Mobile, tablet and desktop layouts', icon: Icons.devices, page: ResponsiveScreen()),
    (title: 'Experiment 4 - Navigation', subtitle: 'Named route navigation example', icon: Icons.alt_route, page: NavigationScreen()),
    (title: 'Experiment 5 - State Management', subtitle: 'setState and Provider counters', icon: Icons.exposure_plus_1, page: StateScreen()),
    (title: 'Experiment 6 - Custom Widgets & Themes', subtitle: 'Reusable widgets and app styling', icon: Icons.palette, page: CustomWidgetsScreen()),
    (title: 'Experiment 7 - Form Validation', subtitle: 'Shipment form with validation', icon: Icons.assignment, page: ShipmentFormScreen()),
    (title: 'Experiment 8 - Animations', subtitle: 'Fade and slide transitions', icon: Icons.animation, page: AnimationScreen()),
    (title: 'Experiment 9 - REST API', subtitle: 'Fetch and display JSON data', icon: Icons.cloud_download, page: RestApiScreen()),
    (title: 'Experiment 10 - Testing & Debugging', subtitle: 'Widget tests and Flutter debugging tools', icon: Icons.bug_report, page: TestingDebuggingScreen()),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('LogiTrack'),
          backgroundColor: const Color(0xFF1769AA),
          foregroundColor: Colors.white,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900 ? 3 : constraints.maxWidth >= 600 ? 2 : 1;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: columns == 1 ? 4.0 : 2.25,
                children: items.map((item) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFE3F2FD),
                          child: Icon(item.icon, color: const Color(0xFF1769AA)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(item.subtitle, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        )),
                        const Icon(Icons.chevron_right),
                      ]),
                    ),
                  ),
                )).toList(),
              ),
            ),
          );
        }),
      );
}

class PageShell extends StatelessWidget {
  final String title;
  final Widget child;
  const PageShell({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
      backgroundColor: const Color(0xFF1769AA),
      foregroundColor: Colors.white,
    ),
    body: child,
  );
}

class InfoTile extends StatelessWidget {
  final String label, value;
  final IconData? icon;
  const InfoTile({super.key, required this.label, required this.value, this.icon});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: icon == null ? null : CircleAvatar(backgroundColor: const Color(0xFFE3F2FD), child: Icon(icon, color: const Color(0xFF1769AA))),
    title: Text(label), subtitle: Text(value),
  ));
}

class ShipmentHeader extends StatelessWidget {
  final String title, subtitle;
  const ShipmentHeader({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(children: [
      const CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xFF1769AA),
        child: Icon(Icons.local_shipping, size: 35, color: Colors.white),
      ),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4), Text(subtitle),
      ])),
    ]),
  ));
}

class ShipmentInfoCard extends StatelessWidget {
  final IconData icon;
  final String title, value;
  const ShipmentInfoCard({super.key, required this.icon, required this.title, required this.value});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: CircleAvatar(backgroundColor: const Color(0xFFE3F2FD), child: Icon(icon, color: const Color(0xFF1769AA))),
    title: Text(title), subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
  ));
}

class DispatchButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const DispatchButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed, icon: const Icon(Icons.send_rounded), label: Text(text),
  );
}

// Experiment 1: Dart variables, data types, arithmetic and conditions.
class DartBasicsScreen extends StatelessWidget {
  const DartBasicsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const shipmentId = 'LT1001';
    const packageCount = 24;
    const deliveryCharge = 149.50;
    const isServiceActive = true;
    const standardCharge = 85, expressFee = 90;
    return PageShell(title: 'Experiment 1 - Dart Basics', child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Dart Basics - LogiTrack', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const InfoTile(label: 'String (Shipment ID)', value: shipmentId),
      const InfoTile(label: 'Integer (Package Count)', value: '$packageCount'),
      const InfoTile(label: 'Double (Delivery Charge)', value: 'Rs. $deliveryCharge'),
      const InfoTile(label: 'Boolean (Service Active)', value: '$isServiceActive'),
      const Divider(),
      const InfoTile(label: '$standardCharge + $expressFee (Total Charge)', value: 'Rs. ${standardCharge + expressFee}'),
      const InfoTile(label: '$expressFee - $standardCharge (Difference)', value: 'Rs. ${expressFee - standardCharge}'),
      const InfoTile(label: '$standardCharge × 2 (Roundtrip)', value: 'Rs. ${standardCharge * 2}'),
      const InfoTile(label: '$standardCharge ÷ 2 (Base Half)', value: 'Rs. ${standardCharge ~/ 2}'),
      Text(deliveryCharge >= 100 ? 'Status: Priority logistics dispatch active!' : 'Status: Standard ground shipping',
        style: const TextStyle(color: Color(0xFF1769AA), fontWeight: FontWeight.bold)),
    ]));
  }
}

// Experiment 2: Row, Column, Stack and Flutter widgets.
class WidgetsLayoutScreen extends StatelessWidget {
  const WidgetsLayoutScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 2 - Widgets & Layouts', child: ListView(padding: const EdgeInsets.all(20), children: [
    Stack(alignment: Alignment.bottomLeft, children: [
      Container(height: 155, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(colors: [Color(0xFF1769AA), Color(0xFF42A5F5)]),
      )),
      const Positioned(left: 20, top: 20, child: CircleAvatar(radius: 34, backgroundColor: Colors.white, child: Icon(Icons.local_shipping, size: 40, color: Color(0xFF1769AA)))),
      const Positioned(left: 20, bottom: 20, child: Text('LogiTrack Overview', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
    ]),
    const SizedBox(height: 16),
    const InfoTile(label: 'Central Hub', value: 'Hyderabad Regional Distribution Center', icon: Icons.warehouse_outlined),
    const InfoTile(label: 'Active Consignments', value: '24 Shipments', icon: Icons.inventory_2_outlined),
    const InfoTile(label: 'Fleet Status', value: '98.5% On Schedule', icon: Icons.speed),
    const InfoTile(label: 'Service Coverage', value: 'National Logistics Network', icon: Icons.map_outlined),
    const SizedBox(height: 8),
    const Text('Row layout example:', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Icon(Icons.local_shipping, color: Color(0xFF1769AA)),
      Icon(Icons.inventory_2, color: Color(0xFF1769AA)),
      Icon(Icons.check_circle, color: Color(0xFF20845A)),
    ]),
  ]));
}

// Experiment 3: responsive UI using LayoutBuilder.
class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 3 - Responsive UI', child: LayoutBuilder(builder: (context, c) {
    final wide = c.maxWidth >= 700;
    const details = [
      InfoTile(label: 'Origin', value: 'Mumbai Central Cargo Terminal', icon: Icons.flight_takeoff),
      InfoTile(label: 'Destination', value: 'Hyderabad Hub', icon: Icons.location_on),
      InfoTile(label: 'Fleet Assigned', value: 'Express Courier Van #08', icon: Icons.local_shipping),
      InfoTile(label: 'Tracking State', value: 'In Transit', icon: Icons.check_circle_outline),
    ];
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(children: [
        const ShipmentHeader(title: 'Shipment #LT1001', subtitle: 'Priority Express Delivery'),
        if (wide) GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 4, children: details)
        else ...details,
        const SizedBox(height: 12),
        Text(wide ? 'Wide screen layout (tablet/desktop)' : 'Compact layout (mobile)', style: const TextStyle(color: Color(0xFF1769AA), fontWeight: FontWeight.bold)),
      ]),
    )));
  }));
}

// Experiment 4: named route navigation.
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 4 - Navigation', child: ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Named Route Navigation', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 6),
    const Text('Use these buttons to open other experiment screens.'),
    const SizedBox(height: 16),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/responsive'), child: const Text('Open Responsive UI')),
    const SizedBox(height: 10),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/state'), child: const Text('Open State Management')),
    const SizedBox(height: 10),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/form'), child: const Text('Open Shipment Form')),
    const SizedBox(height: 10),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/animation'), child: const Text('Open Animations')),
  ]));
}

// Experiment 5: StatefulWidget/setState and Provider/ChangeNotifier.
class StateScreen extends StatefulWidget {
  const StateScreen({super.key});
  @override
  State<StateScreen> createState() => _StateScreenState();
}
class _StateScreenState extends State<StateScreen> {
  int localCount = 0;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CounterProvider>();
    return PageShell(title: 'Experiment 5 - State Management', child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('A. StatefulWidget + setState()', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Card(child: ListTile(
        title: Text('Local package counter: $localCount'),
        trailing: Wrap(children: [
          IconButton(onPressed: () => setState(() => localCount > 0 ? localCount-- : 0), icon: const Icon(Icons.remove)),
          IconButton(onPressed: () => setState(() => localCount++), icon: const Icon(Icons.add)),
        ]),
      )),
      const SizedBox(height: 20),
      const Text('B. Provider + ChangeNotifier', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        Text('Dispatched packages: ${provider.count}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: [
          FilledButton(onPressed: provider.decrease, child: const Text('-1')),
          FilledButton(onPressed: provider.increase, child: const Text('+1')),
          OutlinedButton(onPressed: provider.reset, child: const Text('Reset')),
        ]),
      ]))),
    ]));
  }
}

// Experiment 6: custom widgets and ThemeData.
class CustomWidgetsScreen extends StatelessWidget {
  const CustomWidgetsScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 6 - Custom Widgets & Themes', child: ListView(padding: const EdgeInsets.all(20), children: [
    const ShipmentHeader(title: 'Shipment #LT1001', subtitle: 'Destination: Hyderabad · Priority Express'),
    const ShipmentInfoCard(icon: Icons.person_outline, title: 'Recipient', value: 'Rahul Sharma'),
    const ShipmentInfoCard(icon: Icons.location_city_outlined, title: 'Hub Location', value: 'Telangana Distribution Hub'),
    const ShipmentInfoCard(icon: Icons.check_circle_outline, title: 'Delivery Status', value: 'In Transit (Estimated: Tomorrow 2 PM)'),
    const SizedBox(height: 12),
    DispatchButton(text: 'Update Dispatch Status', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shipment dispatch status updated')))),
  ]));
}

// Experiment 7: shipment form and validation.
class ShipmentFormScreen extends StatefulWidget {
  const ShipmentFormScreen({super.key});
  @override
  State<ShipmentFormScreen> createState() => _ShipmentFormScreenState();
}
class _ShipmentFormScreenState extends State<ShipmentFormScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final destination = TextEditingController();

  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter sender name';
    if (v.trim().length < 3) return 'Name must contain at least 3 characters';
    return null;
  }
  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }
  String? validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter phone number';
    if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Phone number must contain 10 digits';
    return null;
  }
  String? validateDestination(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter destination address';
    return null;
  }
  void submit() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Shipment registered for ${name.text.trim()}!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fix the errors in the form')));
    }
  }
  @override
  void dispose() {
    name.dispose(); email.dispose(); phone.dispose(); destination.dispose(); super.dispose();
  }
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 7 - Shipment Form', child: Form(
    key: formKey,
    child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Register New Shipment', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Sender Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()), validator: validateName),
      const SizedBox(height: 16),
      TextFormField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()), validator: validateEmail),
      const SizedBox(height: 16),
      TextFormField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()), validator: validatePhone),
      const SizedBox(height: 16),
      TextFormField(controller: destination, decoration: const InputDecoration(labelText: 'Destination Address', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()), validator: validateDestination),
      const SizedBox(height: 24),
      FilledButton.icon(onPressed: submit, icon: const Icon(Icons.check), label: const Text('Submit')),
    ]),
  ));
}

// Experiment 8: fade and slide animations.
class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}
class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fade;
  late final Animation<Offset> slide;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    fade = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward();
  }
  void replay() => controller.forward(from: 0);
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 8 - Animations', child: Center(child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: Card(child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(children: [
          const CircleAvatar(radius: 42, backgroundColor: Color(0xFF1769AA), child: Icon(Icons.local_shipping, size: 42, color: Colors.white)),
          const SizedBox(height: 16),
          Text('Shipment In Transit', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Fade + Slide Animation'),
          const SizedBox(height: 12),
          const Icon(Icons.auto_awesome, size: 32, color: Color(0xFF1769AA)),
        ]),
      )))),
      const SizedBox(height: 24),
      FilledButton.icon(onPressed: replay, icon: const Icon(Icons.replay), label: const Text('Replay Animation')),
    ]),
  )));
}

// Experiment 9: fetch REST API data, parse JSON and display results.
class RestApiScreen extends StatefulWidget {
  const RestApiScreen({super.key});
  @override
  State<RestApiScreen> createState() => _RestApiScreenState();
}

class _RestApiScreenState extends State<RestApiScreen> {
  late Future<List<Map<String, dynamic>>> records;

  @override
  void initState() {
    super.initState();
    records = loadShipments();
  }

  Future<List<Map<String, dynamic>>> loadShipments() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums?_limit=10'))
        .timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('API request failed: ${response.statusCode}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  void refresh() => setState(() => records = loadShipments());

  @override
  Widget build(BuildContext context) => PageShell(
    title: 'Experiment 9 - REST API',
    child: FutureBuilder<List<Map<String, dynamic>>>(
      future: records,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator(), SizedBox(height: 12), Text('Loading shipment data...')],
          ));
        }
        if (snapshot.hasError) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.cloud_off, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              const Text('Unable to fetch data. Check your connection and retry.', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(onPressed: refresh, icon: const Icon(Icons.refresh), label: const Text('Try again')),
            ]),
          ));
        }
        final rows = snapshot.data ?? <Map<String, dynamic>>[];
        return ListView(padding: const EdgeInsets.all(16), children: [
          Card(color: Theme.of(context).colorScheme.primaryContainer, child: ListTile(
            leading: const Icon(Icons.cloud_done, size: 32),
            title: const Text('Live API response'),
            subtitle: Text('${rows.length} shipment records fetched from REST API'),
            trailing: IconButton(onPressed: refresh, icon: const Icon(Icons.refresh), tooltip: 'Refresh'),
          )),
          ...rows.map((item) => Card(child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFE3F2FD),
              child: Text('#${item['id']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1769AA))),
            ),
            title: Text('Consignment: ${item['title']}', maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text('Carrier Hub ID: HUB-${item['userId']} • Status: Verified'),
          ))),
        ]);
      },
    ),
  );
}

// Experiment 10: UI testing and Flutter debugging.
class TestingDebuggingScreen extends StatelessWidget {
  const TestingDebuggingScreen({super.key});

  @override
  Widget build(BuildContext context) => PageShell(
    title: 'Experiment 10 - Testing & Debugging',
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Testing Flutter UI Components',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Widget tests verify what a user can see and do without manually tapping through every screen.',
        ),
        const SizedBox(height: 12),
        const InfoTile(
          label: 'Test 1: Shipment header',
          value: 'Verify the shipment ID and destination are displayed.',
          icon: Icons.verified,
        ),
        const InfoTile(
          label: 'Test 2: Form validation',
          value: 'Submit an empty registration form and verify validation messages.',
          icon: Icons.fact_check,
        ),
        const InfoTile(
          label: 'Test 3: Navigation',
          value: 'Verify that the Experiment 10 card opens this screen.',
          icon: Icons.route,
        ),
        const Divider(height: 32),
        const Text(
          'Flutter Debugging Tools',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const InfoTile(
          label: 'Flutter Inspector',
          value: 'Inspect the widget tree, layout constraints, padding, and alignment.',
          icon: Icons.account_tree,
        ),
        const InfoTile(
          label: 'DevTools / Performance view',
          value: 'Inspect rebuilds, frame performance, memory, and runtime behavior.',
          icon: Icons.speed,
        ),
        const InfoTile(
          label: 'Breakpoints and debugger',
          value: 'Pause execution and inspect variables and call stacks in the IDE.',
          icon: Icons.pause_circle,
        ),
        const InfoTile(
          label: 'Console and logging',
          value: 'Use debugPrint() and exception details to locate the source of a problem.',
          icon: Icons.terminal,
        ),
        const Divider(height: 32),
        const Text(
          'Commands used for verification',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const InfoTile(
          label: 'flutter analyze',
          value: 'Finds static analysis and lint issues.',
          icon: Icons.search,
        ),
        const InfoTile(
          label: 'flutter test',
          value: 'Runs unit and widget tests.',
          icon: Icons.play_circle,
        ),
        const InfoTile(
          label: 'flutter run --debug',
          value: 'Runs the app in debug mode for interactive investigation.',
          icon: Icons.bug_report,
        ),
      ],
    ),
  );
}

/// Responsive logistics dashboard used as the Flutter Web landing page.
class LogiTrackDashboard extends StatefulWidget {
  const LogiTrackDashboard({super.key});

  @override
  State<LogiTrackDashboard> createState() => _LogiTrackDashboardState();
}

class _LogiTrackDashboardState extends State<LogiTrackDashboard> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'Overview': GlobalKey(),
    'Fleet': GlobalKey(),
    'Operations': GlobalKey(),
    'Shipments': GlobalKey(),
    'Milestones': GlobalKey(),
    'Contact': GlobalKey(),
    'Experiments': GlobalKey(),
  };

  void _goTo(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 450), curve: Curves.easeInOut, alignment: 0.04);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.local_shipping_rounded, color: Color(0xFF1769AA)),
            SizedBox(width: 10),
            Text('LogiTrack', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
        actions: [
          if (wide)
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(30)),
                  child: const Text('Logistics Prototype', style: TextStyle(color: Color(0xFF1769AA), fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
            ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth >= 1200 ? 1120.0 : 920.0;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: wide ? 28 : 16, vertical: 24),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _sectionKeys.keys.map((section) => ActionChip(
                    label: Text(section),
                    avatar: Icon(_sectionIcon(section), size: 17),
                    onPressed: () => _goTo(section),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE1E6F0)),
                  )).toList(),
                ),
                const SizedBox(height: 22),
                Container(
                  key: _sectionKeys['Overview'],
                  padding: EdgeInsets.all(wide ? 30 : 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF1769AA), Color(0xFF42A5F5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: wide
                    ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        _avatar(82),
                        const SizedBox(width: 24),
                        const Expanded(child: _HeroCopy()),
                        const SizedBox(width: 18),
                        const _AvailabilityTag(),
                      ])
                    : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _avatar(72),
                        const SizedBox(height: 18),
                        const _HeroCopy(),
                        const SizedBox(height: 18),
                        const _AvailabilityTag(),
                      ]),
                ),
                const SizedBox(height: 18),
                GridView.count(
                  crossAxisCount: wide ? 4 : constraints.maxWidth >= 520 ? 2 : 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: wide ? 1.8 : constraints.maxWidth >= 520 ? 2.1 : 3.4,
                  children: const [
                    _StatCard(icon: Icons.inventory_2_outlined, label: 'Active Shipments', value: '24 Consignments'),
                    _StatCard(icon: Icons.check_circle_outline, label: 'Delivery Rate', value: '98.5% On Time'),
                    _StatCard(icon: Icons.warehouse_outlined, label: 'Distribution Hubs', value: '12 Centers'),
                    _StatCard(icon: Icons.location_on_outlined, label: 'Headquarters', value: 'Hyderabad'),
                  ],
                ),
                const SizedBox(height: 28),
                _sectionTitle('Fleet & Hubs', 'Infrastructure & logistics network', Icons.local_shipping_outlined, _sectionKeys['Fleet']),
                const SizedBox(height: 12),
                _panel(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('LogiTrack Ground & Air Delivery Network', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  SizedBox(height: 7),
                  Text('Regional Distribution Centers · Inter-state Cargo · Express Delivery', style: TextStyle(color: Color(0xFF5F6B80))),
                  SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    _Pill(text: 'Fleet Size: 50+ Vehicles'),
                    _Pill(text: 'Cold-chain Supported'),
                    _Pill(text: '24/7 GPS Tracking'),
                  ]),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Operations', 'Logistics features & core competencies', Icons.build_outlined, _sectionKeys['Operations']),
                const SizedBox(height: 12),
                _panel(child: Wrap(spacing: 10, runSpacing: 10, children: const [
                  _SkillChip(label: 'Real-time Tracking', icon: Icons.gps_fixed),
                  _SkillChip(label: 'Form Validation', icon: Icons.assignment_turned_in),
                  _SkillChip(label: 'State Management', icon: Icons.tune),
                  _SkillChip(label: 'REST API Integration', icon: Icons.cloud_sync),
                  _SkillChip(label: 'Responsive Layouts', icon: Icons.devices),
                  _SkillChip(label: 'Route Navigation', icon: Icons.alt_route),
                  _SkillChip(label: 'Automated Testing', icon: Icons.fact_check),
                  _SkillChip(label: 'Animated Alerts', icon: Icons.animation),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Shipments', 'Recent deliveries & active tracking', Icons.folder_open_outlined, _sectionKeys['Shipments']),
                const SizedBox(height: 12),
                LayoutBuilder(builder: (context, box) {
                  final columns = box.maxWidth >= 700 ? 2 : 1;
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: columns == 2 ? 1.5 : 2.0,
                    children: [
                      _ProjectCard(
                        icon: Icons.local_shipping_outlined,
                        title: 'Consignment LT1001',
                        description: 'Express parcel dispatched from Mumbai Cargo Center to Hyderabad Hub. Verified in transit.',
                        tags: const ['Express', 'In Transit', 'GPS Active'],
                        onTap: () => _goTo('Experiments'),
                      ),
                      _ProjectCard(
                        icon: Icons.inventory_2_outlined,
                        title: 'Consignment LT1002',
                        description: 'Commercial wholesale electronics consignment delivered to Warangal Distribution Facility.',
                        tags: const ['Delivered', 'Verified', 'Standard'],
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shipment LT1002 delivered successfully.'))),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 28),
                _sectionTitle('Milestones', 'Logistics accomplishments & reliability', Icons.emoji_events_outlined, _sectionKeys['Milestones']),
                const SizedBox(height: 12),
                _panel(child: const Column(children: [
                  _AchievementRow(icon: Icons.verified_outlined, title: '99% On-time delivery SLA', subtitle: 'Consistently maintaining delivery target windows across all zones.'),
                  Divider(height: 24),
                  _AchievementRow(icon: Icons.warehouse_outlined, title: 'Zero inventory loss record', subtitle: 'Automated barcode registration and dispatch verification protocols.'),
                  Divider(height: 24),
                  _AchievementRow(icon: Icons.bolt_outlined, title: 'Rapid dispatch prototype', subtitle: 'Built with Flutter to combine responsive UI, state management, and API sync.'),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Contact', 'Dispatch & customer support', Icons.mail_outline, _sectionKeys['Contact']),
                const SizedBox(height: 12),
                _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('For logistics queries, consignment tracking, and dispatch coordination.', style: TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 14),
                  Wrap(spacing: 10, runSpacing: 10, children: [
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contact support: dispatch@logitrack.com'))),
                      icon: const Icon(Icons.email_outlined),
                      label: const Text('Email Support'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Repository: https://github.com/Santhosh-chintha/LogiTrack'))),
                      icon: const Icon(Icons.code),
                      label: const Text('GitHub'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Track shipments at track.logitrack.internal'))),
                      icon: const Icon(Icons.local_shipping),
                      label: const Text('Live Tracking'),
                    ),
                  ]),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Experiments', 'Flutter learning lab · 1–10', Icons.science_outlined, _sectionKeys['Experiments']),
                const SizedBox(height: 12),
                ...HomeScreen.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Color(0xFFE5E9F2))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: CircleAvatar(backgroundColor: const Color(0xFFE3F2FD), child: Icon(item.icon, color: const Color(0xFF1769AA))),
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: Text(item.subtitle),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                const Center(child: Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Built with Flutter · LogiTrack Prototype', style: TextStyle(color: Color(0xFF7B8496), fontSize: 12)),
                )),
              ],
            ),
          ),
        );
      }),
    );
  }

  IconData _sectionIcon(String section) {
    switch (section) {
      case 'Overview': return Icons.home_outlined;
      case 'Fleet': return Icons.local_shipping_outlined;
      case 'Operations': return Icons.build_outlined;
      case 'Shipments': return Icons.folder_open_outlined;
      case 'Milestones': return Icons.emoji_events_outlined;
      case 'Contact': return Icons.mail_outline;
      default: return Icons.science_outlined;
    }
  }

  Widget _avatar(double radius) => CircleAvatar(
    radius: radius / 2,
    backgroundColor: Colors.white.withValues(alpha: 0.18),
    child: Icon(Icons.local_shipping_rounded, size: radius * 0.56, color: Colors.white),
  );

  Widget _sectionTitle(String title, String subtitle, IconData icon, GlobalKey? key) => Padding(
    key: key,
    padding: const EdgeInsets.only(top: 2),
    child: Row(children: [
      Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF1769AA))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1F2937))),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
      ])),
    ]),
  );

  Widget _panel({required Widget child}) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE5E9F2))),
    child: child,
  );
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();
  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('LOGISTICS & DELIVERY PROTOTYPE', style: TextStyle(color: Color(0xFFD8DFFF), letterSpacing: 1.7, fontSize: 11, fontWeight: FontWeight.w800)),
      SizedBox(height: 8),
      Text('LogiTrack', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800, height: 1.1)),
      SizedBox(height: 8),
      Text('Cross-Platform Logistics Management Solution', style: TextStyle(color: Colors.white, fontSize: 15)),
      SizedBox(height: 8),
      Text('Streamlining supply chains and package tracking one shipment at a time.', style: TextStyle(color: Color(0xFFE0E6FF), fontSize: 13, height: 1.4)),
    ],
  );
}

class _AvailabilityTag extends StatelessWidget {
  const _AvailabilityTag();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white.withValues(alpha: 0.25))),
    child: const Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.circle, size: 8, color: Color(0xFF8FE0B1)),
      SizedBox(width: 8),
      Text('System Operational', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E9F2))),
    child: Row(children: [
      Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFF1769AA), size: 20)),
      const SizedBox(width: 10),
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Color(0xFF7B8496), fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(color: Color(0xFF263248), fontWeight: FontWeight.w800, fontSize: 14)),
      ])),
    ]),
  );
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
    decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(30)),
    child: Text(text, style: const TextStyle(color: Color(0xFF1769AA), fontSize: 12, fontWeight: FontWeight.w700)),
  );
}

class _SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SkillChip({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(icon, size: 17, color: const Color(0xFF1769AA)),
    label: Text(label),
    backgroundColor: const Color(0xFFF7F8FC),
    side: const BorderSide(color: Color(0xFFE1E6F0)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
  );
}

class _ProjectCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final VoidCallback onTap;
  const _ProjectCard({required this.icon, required this.title, required this.description, required this.tags, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE5E9F2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF1769AA))),
          const Spacer(),
          const Icon(Icons.north_east_rounded, color: Color(0xFF8B95A7), size: 18),
        ]),
        const SizedBox(height: 14),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 7),
        Expanded(child: Text(description, style: const TextStyle(color: Color(0xFF667085), height: 1.4, fontSize: 13))),
        const SizedBox(height: 10),
        Wrap(spacing: 6, runSpacing: 6, children: tags.map((tag) => _Pill(text: tag)).toList()),
      ]),
    ),
  );
}

class _AchievementRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _AchievementRow({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFF1769AA), size: 20)),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(color: Color(0xFF667085), height: 1.4, fontSize: 13)),
    ])),
  ]);
}
