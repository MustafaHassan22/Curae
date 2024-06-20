import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/views/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:pharmacy/views/requests/bloc/request_bloc.dart';
import 'package:pharmacy/views/requests/model/request_model.dart';
import 'package:pharmacy/views/requests/widgets/request_card.dart';

class RequestsScreen extends StatefulWidget {
  RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final bloc = KiwiContainer().resolve<RequestBloc>()
    ..add(GetAllRequestsEvent());
  final bloctwo = KiwiContainer().resolve<AddMedicineBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 250, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF4E97C5).withOpacity(0.9),
        title: const Text('All requests',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
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
                if (state is GetAllRequestsSuccessState) {
                  List<RequestModel> listv = state.requests;
                  return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => RequestCard(
                            request: listv[index],
                            func: () {
                              bloctwo.add(DeletemedicineEvent(
                                  id: listv[index].medicine.id));
                              bloc.add(DeleteRequestMedicineEvent(
                                  requestid: listv[index].id));
                              listv.removeAt(index);
                              setState(() {});
                              ;
                            },
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                      itemCount: listv.length);
                } else if (state is GetAllRequestsFailureState) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
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
