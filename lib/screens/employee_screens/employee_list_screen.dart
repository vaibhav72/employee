import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/cubits/employee_cubit/employee_cubit.dart';
import 'package:employee_app/models/employee/employee_model.dart';
import 'package:employee_app/repository/employee_repository.dart';
import 'package:employee_app/screens/employee_screens/checkin_list_screen.dart';
import 'package:employee_app/screens/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      endDrawer: const Drawer(
        child: FilterWidget(),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
            child: const Icon(Icons.filter_alt),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            });
      }),
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body:
          BlocBuilder<EmployeeCubit, EmployeeState>(builder: (context, state) {
        if (state is EmployeeLoadError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        List<EmployeeModel> dataList = [];
        if (state is EmployeeLoading) {
          //A boolean variable is used to identify whether the current data fetch if the first time which inherently provides us a way to render the progress indicator in the center
          if (state.isFirstFetch) {
            return const Center(child: CircularProgressIndicator());
          } else {
            dataList = state.oldList;
          }
        }
        if (state is EmployeeLoaded) {
          dataList = state.employeeList;
        }

        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: scrollController
              ..addListener(() {
                //The scrollcontroller is checked to whether the scrol has reached maximum extent in order to trigger pagination. scrollController.position.pixels != 0 conditions provides whether the edge it ate the top of the screen or bottom
                if (scrollController.position.atEdge &&
                    scrollController.position.pixels != 0) {
                  context.read<EmployeeCubit>().loadEmployees();
                }
              }),
            itemCount: (state is EmployeeLoading)
                //The itemCount is increased by +1 to display the progress indicator during pagination fetch call
                ? dataList.length + 1
                : dataList.length,
            itemBuilder: (context, index) {
              if (index == dataList.length) {
                // A delay of 20 milliseconds is used to move the screen to the bottom so that the progress indicator is visible.
                Timer(const Duration(milliseconds: 20), () {
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                });

                return const Center(child: CircularProgressIndicator());
              }
              return EmployeeTile(data: dataList[index]);
            });
      }),
    );
  }
}

//This code represents the individual Employee tile
class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final EmployeeModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckinList(employee: data)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Hero(
                tag: data.id!,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundImage: CachedNetworkImageProvider(data.avatar!),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: data.name! + data.id!,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                            Text("DOB",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.withOpacity(0.9))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.country!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.withOpacity(0.9)),
                            ),
                          ),

                          // Formats the given data to dd MMM,yyyy for readability purpose
                          Text(
                            DateFormat('dd MMM,yyyy')
                                .format(data.birthday!.toLocal()),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
