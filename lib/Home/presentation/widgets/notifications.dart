import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/cubit/notifications_states.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationUpdated && state.notifications.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.notifications.length,
              itemBuilder: (context, i) {
                final notification = state.notifications[i];
                return Align(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0XFFF1F5F9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: kMainColor,
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                          ),
                        ),
                        const HorizintalSpace(1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification["title"] ?? "No Title",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                notification["message"] ?? "No message",
                                style: const TextStyle(fontSize: 14),
                                softWrap: true,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                notification["date"] ?? "Unknown Date",
                                style: const TextStyle(
                                  
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "No Notifications",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          }
        },
      ),
    );
  }
}
