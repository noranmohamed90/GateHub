import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/cubit/cubit/objection_cubit.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';

class Objectionbody extends StatefulWidget {
  final int vehicleEntryId;
  const Objectionbody({super.key, required this.vehicleEntryId});

  @override
  State<Objectionbody> createState() => _ObjectionbodyState();
}
class _ObjectionbodyState extends State<Objectionbody> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<ObjectionCubit, ObjectionState>(
      listener: (context, state) {
        if(state is GetobjectionFailure){
          ScaffoldMessenger.of(context).showSnackBar(
         const  SnackBar(content: Text("Objection submitted successfully"),backgroundColor: Colors.green,),
        );
        }else if(state is GetobjectionSuccess){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Objection submitted successfully")),
          );
          Navigator.pop(context); 
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F2F5),
        //title: const Text('Objection Page',style: TextStyle(color: kMainColor,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/object.png')),
               const SizedBox(height: 35),
               TextField(
               controller: context.read<ObjectionCubit>().objectionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write the reason for your objection...',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kMainColor, width: 2), ),
                ),
              ),
              const SizedBox(height: 50),
          Center(
            child: SizedBox(
                    width: 140,
                    height: 55,   
                    child: CustomeGeneralButton(
                      text: 'Submit',
                      onTap: () {
                        context.read<NotificationCubit>().getNotifications();
                        context.read<ObjectionCubit>().postObjection(
                        vehicleEntryId: widget.vehicleEntryId,
                      
  );
                      },
                    ),
                  ),
          ),
            ],
          ),
        ),
      ),
    ));
    }
}
