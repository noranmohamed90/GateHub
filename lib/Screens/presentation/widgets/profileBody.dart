import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:gatehub/core/constants.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';

class Profilebody extends StatefulWidget {
  const Profilebody({Key? key}) : super(key: key);

  @override
  State<Profilebody> createState() => _ProfilebodyState();
}

class _ProfilebodyState extends State<Profilebody> {
  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().getUserInfo();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'successful':
      case 'completed':
      case 'done':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is GetUserInfoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is GetUserInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserInfoSuccess) {
          final user = state.user;

          return Scaffold(
            backgroundColor: const Color(0xFFF0F2F5),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF0F2F5),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Navigator.of(context).canPop()
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back, color: kMainColor),
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  : null,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/profile.jpg'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kMainColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.natId,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user.phoneNumber,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user.address,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Vehicles Details',
                    style: TextStyle(
                      fontSize: 15,
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Column(
                    children: user.vehicles.map((vehicle) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: kMainColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(Icons.directions_car, color: kMainColor, size: 30),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.modelCompany,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kMainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('Color: ${vehicle.color}'),
                                  Text('Plate Number: ${vehicle.plateNumber}'),
                                  Text(
                                    'License Expiry: ${DateFormat('d/MM/yyyy').format(DateTime.parse(vehicle.licenseEnd))}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Transaction History',
                    style: TextStyle(
                      fontSize: 20,
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      shrinkWrap: true,
                       physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: user.transactions.length,
                      separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final tx = user.transactions[index];
                        final statusColor = _getStatusColor(tx.status);
                    
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: kMainColor,
                            child: Icon(Icons.account_balance_wallet, color: Colors.white),
                          ),
                          title: Text(
                            tx.paymentType,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kMainColor,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount: ${tx.amount}'),
                            Text(
                              tx.status,
                              style: TextStyle(color: statusColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Date: ${DateFormat('d/MM/yyyy').format(DateTime.parse(tx.transactionDate))}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No user data found'));
        }
      },
    );
  }
}
