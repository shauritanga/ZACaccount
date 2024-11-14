import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zaccount/widgets/custom_tile.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({super.key});

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
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
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 32),
                                width:
                                    MediaQuery.of(context).size.width * 0.73 -
                                        19,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
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
                                  color: Theme.of(context).primaryColorDark,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
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
                                const Text("TZS 0.00"),
                                const Text("09/05/2024 - 09/10/2024"),
                                const SizedBox(height: 24),
                                Flexible(
                                  child: BarChart(
                                    BarChartData(
                                      barGroups: [
                                        BarChartGroupData(
                                          x: 5,
                                          barRods: [
                                            BarChartRodData(
                                              toY: 400000,
                                              color: Colors.blue,
                                              width: 15,
                                            ),
                                            BarChartRodData(
                                              toY: 500000,
                                              color: Colors.blue.shade200,
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 6,
                                          barRods: [
                                            BarChartRodData(
                                              toY: 200000,
                                              color: Colors.blue,
                                              width: 15,
                                            ),
                                            BarChartRodData(
                                              toY: 600000,
                                              color: Colors.blue.shade200,
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 7,
                                          barRods: [
                                            BarChartRodData(
                                              toY: 8,
                                              color: Colors.blue,
                                              width: 15,
                                            ),
                                            BarChartRodData(
                                              toY: 300000,
                                              color: Colors.blue.shade200,
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 8,
                                          barRods: [
                                            BarChartRodData(
                                              toY: 800000,
                                              color: Colors.blue,
                                              width: 15,
                                            ),
                                            BarChartRodData(
                                              toY: 400000,
                                              color: Colors.blue.shade200,
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 9,
                                          barRods: [
                                            BarChartRodData(
                                              toY: 200000,
                                              color: Colors.blue,
                                              width: 15,
                                            ),
                                            BarChartRodData(
                                              toY: 100000,
                                              color: Colors.blue.shade200,
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 10,
                                          barRods: [
                                            BarChartRodData(
                                              toY: 600000,
                                              color: Colors.blue,
                                              width: 15,
                                            ),
                                            BarChartRodData(
                                              toY: 500000,
                                              color: Colors.blue.shade200,
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ],
                                      maxY: 1000000,
                                      borderData: FlBorderData(
                                        border: const Border(
                                          top: BorderSide.none,
                                          right: BorderSide.none,
                                          left: BorderSide(width: 1),
                                          bottom: BorderSide(width: 1),
                                        ),
                                      ),
                                      titlesData: FlTitlesData(
                                        rightTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              switch (value.toInt()) {
                                                case 5:
                                                  return const Text(
                                                    "Sep 05",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  );
                                                case 6:
                                                  return const Text(
                                                    "Sep 06",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  );
                                                case 7:
                                                  return const Text(
                                                    "Sep 07",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  );
                                                case 8:
                                                  return const Text(
                                                    "Sep 08",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  );
                                                case 9:
                                                  return const Text(
                                                    "Sep 09",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  );
                                                case 10:
                                                  return const Text(
                                                    "Sep 10",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  );
                                              }
                                              return const Text("");
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
                                    const Text("TZS 0.00"),
                                    const Text("09/05/2024 - 09/10/2024"),
                                    const SizedBox(height: 24),
                                    Flexible(
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: [
                                            BarChartGroupData(
                                              x: 1,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: 400000,
                                                  color: Colors.blue,
                                                  width: 15,
                                                ),
                                                BarChartRodData(
                                                  toY: 500000,
                                                  color: Colors.blue.shade200,
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              x: 2,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: 200000,
                                                  color: Colors.blue,
                                                  width: 15,
                                                ),
                                                BarChartRodData(
                                                  toY: 600000,
                                                  color: Colors.blue.shade200,
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              x: 3,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: 8,
                                                  color: Colors.blue,
                                                  width: 15,
                                                ),
                                                BarChartRodData(
                                                  toY: 300000,
                                                  color: Colors.blue.shade200,
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              x: 4,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: 800000,
                                                  color: Colors.blue,
                                                  width: 15,
                                                ),
                                                BarChartRodData(
                                                  toY: 400000,
                                                  color: Colors.blue.shade200,
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              x: 5,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: 200000,
                                                  color: Colors.blue,
                                                  width: 15,
                                                ),
                                                BarChartRodData(
                                                  toY: 100000,
                                                  color: Colors.blue.shade200,
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                            BarChartGroupData(
                                              x: 6,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: 600000,
                                                  color: Colors.blue,
                                                  width: 15,
                                                ),
                                                BarChartRodData(
                                                  toY: 500000,
                                                  color: Colors.blue.shade200,
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ],
                                          maxY: 1000000,
                                          borderData: FlBorderData(
                                            border: const Border(
                                              top: BorderSide.none,
                                              right: BorderSide.none,
                                              left: BorderSide(width: 1),
                                              bottom: BorderSide(width: 1),
                                            ),
                                          ),
                                          titlesData: FlTitlesData(
                                            rightTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            topTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  switch (value.toInt()) {
                                                    case 1:
                                                      return const Text(
                                                        "08/05",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      );
                                                    case 2:
                                                      return const Text(
                                                        "08/11",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      );
                                                    case 3:
                                                      return const Text(
                                                        "08/18",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      );
                                                    case 4:
                                                      return const Text(
                                                        "08/25",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      );
                                                    case 5:
                                                      return const Text(
                                                        "09/01",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      );
                                                    case 6:
                                                      return const Text(
                                                        "09/08",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      );
                                                  }
                                                  return const Text("");
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
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
                          const Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Total expense in",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "today",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
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
