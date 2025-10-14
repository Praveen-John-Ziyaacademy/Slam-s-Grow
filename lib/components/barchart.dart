import 'package:flutter/material.dart';

class AppActivityScreen extends StatelessWidget {
  const AppActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final activityData = [
      [0, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 11, 10],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 3, 5, 7, 8, 10, 11, 12, 11, 10, 9, 8, 7],
      [0, 2, 4, 6, 8, 10, 11, 12, 10, 9, 8, 7, 6],
      [0, 1, 3, 5, 7, 9, 10, 11, 10, 9, 8, 6, 5],
      [0, 2, 4, 6, 7, 9, 10, 11, 12, 10, 9, 8, 6],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'App Activity',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'This Week',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '5/7',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Days Active',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                        List.generate(days.length, (dayIndex) {
                              return Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: List.generate(
                                      activityData[dayIndex].length,
                                      (hourIndex) {
                                        final intensity =
                                            activityData[dayIndex][hourIndex];
                                        final isInactive =
                                            activityData[dayIndex].every(
                                              (v) => v == 0,
                                            );

                                        Color getColor(int value) {
                                          if (isInactive)
                                            return Colors.grey[300]!;
                                          if (value == 0)
                                            return Colors.grey[300]!;
                                          if (value <= 3)
                                            return const Color(0xFF99E6D3);
                                          if (value <= 6)
                                            return const Color(0xFF66D9C4);
                                          if (value <= 9)
                                            return const Color(0xFF4DBFB5);
                                          return const Color(0xFF2563EB);
                                        }

                                        return Container(
                                          width: 32,
                                          height: 16,
                                          margin: const EdgeInsets.only(
                                            bottom: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                            color: getColor(intensity),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    days[dayIndex],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            })
                            .map(
                              (widget) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: widget,
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 30),

                // Legend
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '5 Day Streak',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.green[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '5 Days This Week',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
