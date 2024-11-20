import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/utils/charts/daily_chart.dart';
import 'package:zaccount/utils/charts/monthly_chart.dart';
import 'package:zaccount/utils/charts/weekly_chart.dart';
import 'package:zaccount/utils/charts/yearly_chart.dart';
import 'package:zaccount/utils/get_yearly_invoices.dart';
import 'package:zaccount/utils/geting_today_invoices.dart';
import 'package:zaccount/utils/getting_date_weekly.dart';
import 'package:zaccount/utils/getting_invoices_weekly.dart';
import 'package:zaccount/utils/getting_monthly_invoices.dart';
import 'package:zaccount/shared/widgets/custom_tile.dart';

class MyBusiness extends ConsumerStatefulWidget {
  const MyBusiness({super.key});

  @override
  ConsumerState<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends ConsumerState<MyBusiness> {
  late ScrollController _controller;
  bool _isModalOpen = false;
  String _dataFilter = "Daily";
  bool _isAtTop = true;

  _scrollListener() {
    if (_controller.offset > 0.0) {
      setState(() {
        _isAtTop = false;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isAtTop = true;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoices = ref.watch(invoicesFurureProvider);
    final expenses = ref.watch(expenseFurureProvider);

    double dayTotalInvoices = getInvoicesCreatedToday(invoices)
        .map((invoice) => invoice['totalAmount'])
        .fold(0.0, (acc, value) => acc + value);

    double weekTotalInvoices = getInvoicesThisWeek(invoices)
        .map((invoice) => invoice['totalAmount'])
        .fold(0.0, (acc, value) => acc + value);

    double monthTotalInvoices = getInvoicesThisMonth(invoices)
        .map((invoice) => invoice['totalAmount'])
        .fold(0.0, (acc, value) => acc + value);

    double yearTotalInvoices = getInvoicesThisYear(invoices)
        .map((invoice) => invoice['totalAmount'])
        .fold(0.0, (acc, value) => acc + value);

    double totalExpenses = invoices
        .map((invoice) => invoice['totalAmount'])
        .fold(0.0, (acc, value) => acc + value);
    final week = getCurrentWeekRange();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              color: Theme.of(context).primaryColor,
            ),
          ),
          CustomScrollView(
            controller: _controller,
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                centerTitle: true,
                pinned: true,
                title: const Column(
                  children: [
                    Text(
                      "Cash flow",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                bottom: _isAtTop
                    ? null
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(120.0),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  setState(() {
                                    _isModalOpen = true;
                                  });
                                  await showModalBottomSheet(
                                    showDragHandle: true,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(
                                              0) // Removes the top rounded corners
                                          ),
                                    ),
                                    builder: (context) {
                                      return Container(
                                        height: 250,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            const Text(
                                              "Select a time interval",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            CustomTile(
                                              title: "Daily",
                                              color: _dataFilter == "Daily"
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  _dataFilter = "Daily";
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(),
                                            CustomTile(
                                              title: "Weekly",
                                              color: _dataFilter == "Weekly"
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  _dataFilter = "Weekly";
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(),
                                            CustomTile(
                                              title: "Monthly",
                                              color: _dataFilter == "Monthly"
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  _dataFilter = "Monthly";
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(),
                                            CustomTile(
                                              title: "Quarterly",
                                              color: _dataFilter == "Quarterly"
                                                  ? const Color.fromARGB(
                                                      255, 17, 21, 117)
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  _dataFilter = "Quarterly";
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(),
                                            CustomTile(
                                              title: "Yearly",
                                              color: _dataFilter == "Yearly"
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : null,
                                              onTap: () {
                                                setState(() {
                                                  _dataFilter = "Yearly";
                                                });
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {
                                    _isModalOpen = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 32),
                                  width:
                                      MediaQuery.of(context).size.width * 0.73 -
                                          19,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withBlue(90),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _dataFilter,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 32),
                                width:
                                    MediaQuery.of(context).size.width * 0.27 -
                                        19,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withBlue(90),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.chevron_left,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _dataFilter == "Daily"
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            height: 400,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 5,
                                  color: Colors.grey.shade800,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(_dataFilter),
                                        IconButton(
                                          icon: Icon(_isModalOpen
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                          onPressed: () async {
                                            setState(() {
                                              _isModalOpen = true;
                                            });
                                            await showModalBottomSheet(
                                              showDragHandle: true,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        0) // Removes the top rounded corners
                                                    ),
                                              ),
                                              builder: (context) {
                                                return Container(
                                                  height: 250,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    children: [
                                                      const Text(
                                                        "Select a time interval",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      CustomTile(
                                                        title: "Daily",
                                                        color: _dataFilter ==
                                                                "Daily"
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : null,
                                                        onTap: () {
                                                          setState(() {
                                                            _dataFilter =
                                                                "Daily";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      const Divider(),
                                                      CustomTile(
                                                        title: "Weekly",
                                                        color: _dataFilter ==
                                                                "Weekly"
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : null,
                                                        onTap: () {
                                                          setState(() {
                                                            _dataFilter =
                                                                "Weekly";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      const Divider(),
                                                      CustomTile(
                                                        title: "Monthly",
                                                        color: _dataFilter ==
                                                                "Monthly"
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : null,
                                                        onTap: () {
                                                          setState(() {
                                                            _dataFilter =
                                                                "Monthly";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      const Divider(),
                                                      CustomTile(
                                                        title: "Quarterly",
                                                        color: _dataFilter ==
                                                                "Quarterly"
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : null,
                                                        onTap: () {
                                                          setState(() {
                                                            _dataFilter =
                                                                "Quarterly";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      const Divider(),
                                                      CustomTile(
                                                        title: "Yearly",
                                                        color: _dataFilter ==
                                                                "Yearly"
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : null,
                                                        onTap: () {
                                                          setState(() {
                                                            _dataFilter =
                                                                "Yearly";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                            setState(() {
                                              _isModalOpen = false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Text("Revenue")
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Row(children: [
                                          Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text("Expenses")
                                        ])
                                      ],
                                    )
                                  ],
                                ),
                                const Text("Total Revenue"),
                                Text(
                                    "Tsh ${NumberFormat("#,##0.00").format(dayTotalInvoices)}"),
                                Text(
                                    "${week['firstDate']} - ${week['lastDate']}"),
                                const SizedBox(height: 24),
                                Flexible(
                                  child: DailyRevenueExpenseChart(
                                    invoices: invoices,
                                    expenses: expenses,
                                  ),
                                )
                              ],
                            ),
                          )
                        : _dataFilter == "Weekly"
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                height: 400,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 1,
                                      spreadRadius: 2.0,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(_dataFilter),
                                            IconButton(
                                              icon: Icon(_isModalOpen
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down),
                                              onPressed: () async {
                                                setState(() {
                                                  _isModalOpen = true;
                                                });
                                                await showModalBottomSheet(
                                                  showDragHandle: true,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top: Radius.circular(
                                                                0) // Removes the top rounded corners
                                                            ),
                                                  ),
                                                  builder: (context) {
                                                    return Container(
                                                      height: 250,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          const Text(
                                                            "Select a time interval",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          CustomTile(
                                                            title: "Daily",
                                                            color: _dataFilter ==
                                                                    "Daily"
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                : null,
                                                            onTap: () {
                                                              setState(() {
                                                                _dataFilter =
                                                                    "Daily";
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          const Divider(),
                                                          CustomTile(
                                                            title: "Weekly",
                                                            color: _dataFilter ==
                                                                    "Weekly"
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                : null,
                                                            onTap: () {
                                                              setState(() {
                                                                _dataFilter =
                                                                    "Weekly";
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          const Divider(),
                                                          CustomTile(
                                                            title: "Monthly",
                                                            color: _dataFilter ==
                                                                    "Monthly"
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                : null,
                                                            onTap: () {
                                                              setState(() {
                                                                _dataFilter =
                                                                    "Monthly";
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          const Divider(),
                                                          CustomTile(
                                                            title: "Quarterly",
                                                            color: _dataFilter ==
                                                                    "Quarterly"
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    17,
                                                                    21,
                                                                    117)
                                                                : null,
                                                            onTap: () {
                                                              setState(() {
                                                                _dataFilter =
                                                                    "Quarterly";
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          const Divider(),
                                                          CustomTile(
                                                            title: "Yearly",
                                                            color: _dataFilter ==
                                                                    "Yearly"
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                : null,
                                                            onTap: () {
                                                              setState(() {
                                                                _dataFilter =
                                                                    "Yearly";
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                                setState(() {
                                                  _isModalOpen = false;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                const Text("Revenue")
                                              ],
                                            ),
                                            const SizedBox(width: 12),
                                            Row(children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text("Expenses")
                                            ])
                                          ],
                                        )
                                      ],
                                    ),
                                    const Text("Total Revenue"),
                                    Text(
                                        "Tsh ${NumberFormat().format(weekTotalInvoices)}"),
                                    const Text("09/05/2024 - 09/10/2024"),
                                    const SizedBox(height: 24),
                                    Flexible(
                                      child: WeeklyRevenueExpenseChart(
                                        invoices: invoices,
                                        expenses: expenses,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : _dataFilter == "Monthly"
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    height: 400,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(1, 1),
                                          blurRadius: 1,
                                          spreadRadius: 2.0,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(_dataFilter),
                                                IconButton(
                                                  icon: Icon(_isModalOpen
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down),
                                                  onPressed: () async {
                                                    setState(() {
                                                      _isModalOpen = true;
                                                    });
                                                    await showModalBottomSheet(
                                                      showDragHandle: true,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .surface,
                                                      context: context,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        0) // Removes the top rounded corners
                                                                ),
                                                      ),
                                                      builder: (context) {
                                                        return Container(
                                                          height: 250,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: [
                                                              const Text(
                                                                "Select a time interval",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              CustomTile(
                                                                title: "Daily",
                                                                color: _dataFilter ==
                                                                        "Daily"
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                    : null,
                                                                onTap: () {
                                                                  setState(() {
                                                                    _dataFilter =
                                                                        "Daily";
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              const Divider(),
                                                              CustomTile(
                                                                title: "Weekly",
                                                                color: _dataFilter ==
                                                                        "Weekly"
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                    : null,
                                                                onTap: () {
                                                                  setState(() {
                                                                    _dataFilter =
                                                                        "Weekly";
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              const Divider(),
                                                              CustomTile(
                                                                title:
                                                                    "Monthly",
                                                                color: _dataFilter ==
                                                                        "Monthly"
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                    : null,
                                                                onTap: () {
                                                                  setState(() {
                                                                    _dataFilter =
                                                                        "Monthly";
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              const Divider(),
                                                              CustomTile(
                                                                title:
                                                                    "Quarterly",
                                                                color: _dataFilter ==
                                                                        "Quarterly"
                                                                    ? const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        17,
                                                                        21,
                                                                        117)
                                                                    : null,
                                                                onTap: () {
                                                                  setState(() {
                                                                    _dataFilter =
                                                                        "Quarterly";
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              const Divider(),
                                                              CustomTile(
                                                                title: "Yearly",
                                                                color: _dataFilter ==
                                                                        "Yearly"
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                    : null,
                                                                onTap: () {
                                                                  setState(() {
                                                                    _dataFilter =
                                                                        "Yearly";
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    setState(() {
                                                      _isModalOpen = false;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Text("Revenue")
                                                  ],
                                                ),
                                                const SizedBox(width: 12),
                                                Row(children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .blue.shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Text("Expenses")
                                                ])
                                              ],
                                            )
                                          ],
                                        ),
                                        const Text("Total Revenue"),
                                        Text(
                                            "Tsh ${NumberFormat("#,##0.00").format(monthTotalInvoices)}"),
                                        const Text("09/05/2024 - 09/10/2024"),
                                        const SizedBox(height: 24),
                                        Flexible(
                                          child: MonthlyRevenueExpenseChart(
                                            invoices: invoices,
                                            expenses: expenses,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : _dataFilter == "Yearly"
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        height: 400,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 2.0,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(_dataFilter),
                                                    IconButton(
                                                      icon: Icon(_isModalOpen
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _isModalOpen = true;
                                                        });
                                                        await showModalBottomSheet(
                                                          showDragHandle: true,
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface,
                                                          context: context,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            0) // Removes the top rounded corners
                                                                    ),
                                                          ),
                                                          builder: (context) {
                                                            return Container(
                                                              height: 250,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .surface,
                                                              child: ListView(
                                                                shrinkWrap:
                                                                    true,
                                                                children: [
                                                                  const Text(
                                                                    "Select a time interval",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  CustomTile(
                                                                    title:
                                                                        "Daily",
                                                                    color: _dataFilter ==
                                                                            "Daily"
                                                                        ? Theme.of(context)
                                                                            .primaryColor
                                                                        : null,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _dataFilter =
                                                                            "Daily";
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  const Divider(),
                                                                  CustomTile(
                                                                    title:
                                                                        "Weekly",
                                                                    color: _dataFilter ==
                                                                            "Weekly"
                                                                        ? Theme.of(context)
                                                                            .primaryColor
                                                                        : null,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _dataFilter =
                                                                            "Weekly";
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  const Divider(),
                                                                  CustomTile(
                                                                    title:
                                                                        "Monthly",
                                                                    color: _dataFilter ==
                                                                            "Monthly"
                                                                        ? Theme.of(context)
                                                                            .primaryColor
                                                                        : null,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _dataFilter =
                                                                            "Monthly";
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  const Divider(),
                                                                  CustomTile(
                                                                    title:
                                                                        "Quarterly",
                                                                    color: _dataFilter ==
                                                                            "Quarterly"
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            17,
                                                                            21,
                                                                            117)
                                                                        : null,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _dataFilter =
                                                                            "Quarterly";
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  const Divider(),
                                                                  CustomTile(
                                                                    title:
                                                                        "Yearly",
                                                                    color: _dataFilter ==
                                                                            "Yearly"
                                                                        ? Theme.of(context)
                                                                            .primaryColor
                                                                        : null,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _dataFilter =
                                                                            "Yearly";
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        setState(() {
                                                          _isModalOpen = false;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 10,
                                                          width: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        const Text("Revenue")
                                                      ],
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Row(children: [
                                                      Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .blue.shade200,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Text("Expenses")
                                                    ])
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Text("Total Revenue"),
                                            Text(
                                                "Tsh ${NumberFormat().format(yearTotalInvoices)}"),
                                            const Text(
                                                "09/05/2024 - 09/10/2024"),
                                            const SizedBox(height: 24),
                                            Flexible(
                                              child: YearlyRevenueExpenseChart(
                                                invoices: invoices,
                                                expenses: expenses,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("REVENUE BREAKDOWN"),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 400,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 2.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("include unpaid invoices"),
                              Transform.scale(
                                scale: 0.6,
                                child: Switch.adaptive(
                                    activeColor: Colors.white,
                                    trackColor: WidgetStatePropertyAll<Color?>(
                                      Colors.blue.shade900,
                                    ),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            ],
                          ),
                          const Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total expense in"),
                              Text("today"),
                              Text(
                                "TZS 0.0",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("EXPENSE BREAKDOWN"),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      height: 400,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 2.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("include product costs"),
                              Transform.scale(
                                scale: 0.6,
                                child: Switch.adaptive(
                                    activeColor: Colors.white,
                                    trackColor: WidgetStatePropertyAll<Color?>(
                                        Colors.blue.shade900),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            ],
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Total expense in",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Text(
                                "today",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Tsh ${NumberFormat().format(totalExpenses)}",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
