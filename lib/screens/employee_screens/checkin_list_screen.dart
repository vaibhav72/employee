import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/cubits/checkin_cubit/checkin_cubit.dart';
import 'package:employee_app/models/checkin/checkin_model.dart';
import 'package:employee_app/models/employee/employee_model.dart';
import 'package:employee_app/repository/checkin_repository.dart';
import 'package:employee_app/utils/helpers.dart';
import 'package:employee_app/utils/meta_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckinList extends StatelessWidget {
  const CheckinList({super.key, required this.employee});
  final EmployeeModel employee;
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Checkins")),
      body: Column(
        children: [
          EmployeeDetailsWidget(employee: employee),
          CheckinWidget(employee: employee, scrollController: scrollController),
        ],
      ),
    );
  }
}

class CheckinWidget extends StatelessWidget {
  const CheckinWidget({
    Key? key,
    required this.employee,
    required this.scrollController,
  }) : super(key: key);

  final EmployeeModel employee;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (context) =>
            CheckinCubit(CheckinRepository(employee))..loadCheckins(),
        child:
            BlocBuilder<CheckinCubit, CheckinState>(builder: (context, state) {
          if (state is CheckinLoadError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          List<CheckinModel> dataList = [];
          if (state is CheckinLoading) {
            if (state.isFirstFetch) {
              return Center(child: CircularProgressIndicator());
            } else {
              dataList = state.oldList;
            }
          }
          if (state is CheckinLoaded) {
            dataList = state.employeeList;
          }

          return ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: scrollController
                ..addListener(() {
                  if (scrollController.position.atEdge &&
                      scrollController.position.pixels != 0) {
                    context.read<CheckinCubit>().loadCheckins();
                  }
                }),
              itemCount: (state is CheckinLoading)
                  ? dataList.length + 1
                  : dataList.length,
              itemBuilder: (context, index) {
                if (index == dataList.length) {
                  Timer(Duration(milliseconds: 30), () {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  });
                  return Center(child: const CircularProgressIndicator());
                }
                return CheckinTile(data: dataList[index]);
              });
        }),
      ),
    );
  }
}

class CheckinTile extends StatelessWidget {
  const CheckinTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final CheckinModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Icon(Icons.timelapse),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Check in on ${DateFormat('dd MMM,yyy hh:mm:ss a').format(data.checkin!)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                            Text(data.employeeId!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.withOpacity(0.9))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "at ${data.location}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            ),

                            // Formats the given data to dd MMM,yyyy for readability purpose
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.amberAccent.withOpacity(0.4)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.purpose!.capitalize(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class EmployeeDetailsWidget extends StatelessWidget {
  const EmployeeDetailsWidget({
    Key? key,
    required this.employee,
  }) : super(key: key);

  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Hero(
            tag: employee.id!,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                foregroundImage: CachedNetworkImageProvider(employee.avatar!),
              ),
            ),
          ),
          Hero(
            tag: employee.name!+employee.id! ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                employee.name!,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              employee.email!,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: MetaColors.primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Phone",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.withOpacity(0.9))),
                Expanded(
                  child: Text(
                    employee.phone!,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text("DOB",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.withOpacity(0.9))),
                ),
                Text(
                  DateFormat('dd MMM,yyyy')
                      .format(employee.birthday!.toLocal()),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Country",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.withOpacity(0.9))),
                Expanded(
                  child: Text(
                    employee.country!,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Department",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.withOpacity(0.9))),
                Expanded(
                  child: Text(
                    employee.department != null
                        ? "${employee.department!.join(",")}"
                        : "",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Joined on ${DateFormat('dd MMM,yyyy').format(employee.createdAt!)}",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
