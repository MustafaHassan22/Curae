import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/cache_helper.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/all_medicines/widgets/drop_menu.dart';
import 'package:pharmacy/views/all_medicines/widgets/medicine_card.dart';
import 'package:pharmacy/views/all_medicines/widgets/search.dart';
import 'package:pharmacy/views/requests/bloc/request_bloc.dart';

class AllMedicinesScreen extends StatelessWidget {
  AllMedicinesScreen({super.key});

  final bloc = KiwiContainer().resolve<AllMedicinesBloc>()
    ..add(GetAllMedicinesEvent());
  final bloc2 = KiwiContainer().resolve<RequestBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 250, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF4DA8CF).withOpacity(0.9),
        leading: DropMenuWidget(),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search, color: Colors.white,size: 25,),
          ),
        ],
        title: const Text('All Medicine',style: TextStyle(color: Colors.white, )),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is GetAllMedicinesSuccessState) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),                      shrinkWrap: true, // Add this line
                    physics: const NeverScrollableScrollPhysics(), // Add this line
                    itemBuilder: (context, index) => BlocListener(
                      bloc: bloc2,
                      listener: (context, state) {
                        if (state is RequestMedicineSuccessState) {
                          toast(msg: state.message);
                          bloc2.add(GetAllRequestsEvent());
                        } else if (state is RequestMedicineFailureState) {
                          toast(msg: state.message);
                        }
                      },
                      child: MedicineCard(
                        medicine: state.medicines[index],
                        onTap: () {
                          bloc2.add(RequestMedicineEvent(
                            medicineId: state.medicines[index].id,
                            userId: CacheHelper.getId(),
                          ));
                        },
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                    itemCount: state.medicines.length,
                  );
                } else if (state is GetAllMedicinesFailureState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF4E97C5),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),

    );
  }
}
