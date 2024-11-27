import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zaccount/presentation/providers/company_provider.dart';
import 'package:zaccount/presentation/providers/home_provider.dart';
import 'package:zaccount/screens/add_customer.dart';
import 'package:zaccount/screens/add_expense.dart';
import 'package:zaccount/screens/add_invoice.dart';
import 'package:zaccount/screens/add_product.dart';
import 'package:zaccount/screens/add_vendor.dart';
import 'package:zaccount/screens/todo_list.dart';
import 'package:zaccount/shared/widgets/activity.dart';
import 'package:zaccount/shared/widgets/page.dart';
import 'package:zaccount/shared/widgets/top_dashboard_menu.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  late ScrollController _controller;
  DateTime now = DateTime.now();

  bool _isAppBarExpanded = true;

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        _isAppBarExpanded = _controller.hasClients &&
            _controller.offset < (160.0 - kToolbarHeight);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final company = ref.watch(companyProvider);
    
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
            foregroundColor: Colors.white,

            leading: _isAppBarExpanded
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${company.businessProfile?.name}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(207, 208, 208, 208),
                          ),
                        ),
                        Text(
                          "Welcome, ${company.individual?.lastName}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                  ),
            leadingWidth: _isAppBarExpanded ? 200 : 50,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    ref.read(homeProvider.notifier).updateCurrentTab(3);
                  },
                  child: const CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/premium-photo/photography-handsome-black-american-men-happy-lifestyle_1288657-149451.jpg?ga=GA1.1.779399139.1725719480&semt=ais_hybrid"),
                  ),
                ),
              )
            ],
            // show and hide SliverAppBar Title
            backgroundColor: Theme.of(context).primaryColor,
            pinned: true,
            // show and hide FlexibleSpaceBar title
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: _isAppBarExpanded
                      ? const EdgeInsets.all(16)
                      : const EdgeInsets.only(left: 72, bottom: 10, right: 72),
                  title: Container(
                    // width: double.infinity,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Menu(
                            isAppBarExpanded: _isAppBarExpanded,
                            title: "Invoice",
                            icon: HugeIcons.strokeRoundedDocumentValidation,
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                useSafeArea: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize:
                                        1.0, //set this as you want
                                    maxChildSize: 1.0, //set this as you want
                                    minChildSize: 1.0, //set this as you want
                                    expand: true,
                                    builder: (context, scrollController) {
                                      return const AddInvoiceScreen(); //whatever you're returning, does not have to be a Container
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          Menu(
                            isAppBarExpanded: _isAppBarExpanded,
                            title: "Expense",
                            icon: HugeIcons.strokeRoundedInvoice03,
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                useSafeArea: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize:
                                        1.0, //set this as you want
                                    maxChildSize: 1.0, //set this as you want
                                    minChildSize: 1.0, //set this as you want
                                    expand: true,
                                    builder: (context, scrollController) {
                                      return const AddExpenseScreen(); //whatever you're returning, does not have to be a Container
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          Menu(
                            isAppBarExpanded: _isAppBarExpanded,
                            title: "Product",
                            icon: HugeIcons.strokeRoundedCodesandbox,
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                useSafeArea: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize:
                                        1.0, //set this as you want
                                    maxChildSize: 1.0, //set this as you want
                                    minChildSize: 1.0, //set this as you want
                                    expand: true,
                                    builder: (context, scrollController) {
                                      return const AddProductScreen(); //whatever you're returning, does not have to be a Container
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          Menu(
                            isAppBarExpanded: _isAppBarExpanded,
                            title: 'Vendor',
                            icon: HugeIcons.strokeRoundedUserAccount,
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                useSafeArea: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize:
                                        1.0, //set this as you want
                                    maxChildSize: 1.0, //set this as you want
                                    minChildSize: 1.0, //set this as you want
                                    expand: true,
                                    builder: (context, scrollController) {
                                      return const AddVendorScreen(
                                        title: "Add Vendor",
                                      ); //whatever you're returning, does not have to be a Container
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          Menu(
                            isAppBarExpanded: _isAppBarExpanded,
                            title: 'Customer',
                            icon: HugeIcons.strokeRoundedAbacus,
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                useSafeArea: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize:
                                        1.0, //set this as you want
                                    maxChildSize: 1.0, //set this as you want
                                    minChildSize: 1.0, //set this as you want
                                    expand: true,
                                    builder: (context, scrollController) {
                                      return const AddCustomerScreen(); //whatever you're returning, does not have to be a Container
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "${DateFormat.MMMM().format(now)} ",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: DateFormat.y().format(now),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: Text(DateFormat.yMMMMEEEEd().format(now)),
                ),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      useSafeArea: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 1.0, //set this as you want
                          maxChildSize: 1.0, //set this as you want
                          minChildSize: 1.0, //set this as you want
                          expand: true,
                          builder: (context, scrollController) {
                            return const ToDoListScreen();
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 18,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 32,
                          percent: 0.67,
                          startAngle: 90,
                          circularStrokeCap: CircularStrokeCap.round,
                          lineWidth: 7.0,
                          center: const Text("67%"),
                          progressColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome to ZACcount Let's get started",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "We are here to assist you with setting up",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 300,
                  child: const IncomeDashboard(),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text("RECENT ACTIVITIES"),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  // height: 700,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Activity(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                  child: Text(
                    "*ZACcount does not encompass tax preparation services, assistance with taxt preparations, or assurance services.For tax advice concerning the preparation of your tax return, it is advisable to seek consultation from tax preparer",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
