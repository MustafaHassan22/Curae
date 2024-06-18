import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/cache_helper.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/all_medicines/widgets/medicine_card.dart';
import 'package:pharmacy/views/requests/bloc/request_bloc.dart';

class Search extends SearchDelegate {
  final AllMedicinesBloc bloc = KiwiContainer().resolve<AllMedicinesBloc>()
    ..add(GetAllMedicinesEvent());
  final RequestBloc bloc2 = KiwiContainer().resolve<RequestBloc>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
          icon: Icon(Icons.close,color: Colors.red.shade800,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back,color: Color(0xFF4DA8CF),),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetAllMedicinesSuccessState) {
            final filteredMedicines = query.isEmpty
                ? state.medicines
                : state.medicines.where((medicine) {
                    return medicine.name
                        .toLowerCase()
                        .contains(query.toLowerCase());
                  }).toList();
      
            if (filteredMedicines.isEmpty) {
              return Center(
                child: Text('No medicine found.',style: TextStyle(color: Color(0xFF4DA8CF),fontSize: 20.sp,fontWeight: FontWeight.bold),),
              );
            }
      
            return ListView.separated(
              padding: EdgeInsets.all(16.h),
              itemCount: filteredMedicines.length,
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
                  medicine: filteredMedicines[index],
                  onTap: () {
                    bloc2.add(RequestMedicineEvent(
                        medicineId: filteredMedicines[index].id,
                        userId: CacheHelper.getId()));
                  },
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
            );
          } else if (state is GetAllMedicinesFailureState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4DA8CF),
              ),
            );
          }
        },
      ),
    );
  }
}
