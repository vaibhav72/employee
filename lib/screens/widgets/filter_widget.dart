import 'package:employee_app/cubits/employee_cubit/employee_cubit.dart';
import 'package:employee_app/repository/employee_repository.dart';
import 'package:employee_app/screens/employee_screens/employee_list_screen.dart';
import 'package:employee_app/utils/helpers.dart';
import 'package:employee_app/utils/meta_colors.dart';
import 'package:employee_app/utils/meta_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  TextEditingController filterController = TextEditingController();
  String filterName = 'name';
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: true, title: const Text("Filters")),
      body: Container(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildDropDownField(),
                FilterTextField(
                    filterName: filterName, filterController: filterController),
                AddFilterButton(
                    formKey: _formKey,
                    filterName: filterName,
                    filterController: filterController),
                BlocBuilder<EmployeeCubit, EmployeeState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        FilterList(filters: state.filters),
                        if (state.filters.isNotEmpty) ClearFiltersButton(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sort By',
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                          ),
                        ),
                        SortByWidget(sortBy: state.sortBy)
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Padding _buildDropDownField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
          decoration: MetaStyles.textFieldDecoration("Filter"),
          value: filterName,
          items: getEmployeeFilters()
              .map((e) => DropdownMenuItem(
                    onTap: () {
                      setState(() {});
                    },
                    value: e,
                    child: Text(
                      e.capitalize(),
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              filterName = value!;
            });
          }),
    );
  }
}

class FilterTextField extends StatelessWidget {
  const FilterTextField({
    Key? key,
    required this.filterName,
    required this.filterController,
  }) : super(key: key);

  final String filterName;
  final TextEditingController filterController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        keyboardType: TextInputType.name,
        decoration: MetaStyles.textFieldDecoration(filterName.capitalize()),
        validator: ((value) => value!.trim().isEmpty
            ? "Please enter a valid $filterName value"
            : null),
        controller: filterController,
      ),
    );
  }
}

class FilterList extends StatelessWidget {
  const FilterList({
    required this.filters,
    Key? key,
  }) : super(key: key);
  final Map<String, String> filters;
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: filters.entries
            .map<Chip>((key) => Chip(
                deleteIcon: Icon(Icons.close),
                onDeleted: () {
                  BlocProvider.of<EmployeeCubit>(context).removeFilter(key.key);
                },
                backgroundColor: Colors.green.withOpacity(0.1),
                avatar: CircleAvatar(
                    radius: 10, backgroundColor: Colors.greenAccent),
                label: Text("${key.key.capitalize()} : ${key.value}")))
            .toList());
  }
}

class AddFilterButton extends StatelessWidget {
  const AddFilterButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.filterName,
    required this.filterController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final String filterName;
  final TextEditingController filterController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        elevation: 0,
        color: MetaColors.primaryColor.withOpacity(0.1),
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            BlocProvider.of<EmployeeCubit>(context)
                .addFilter(filterName, filterController.text);
          }
        },
        child: const Text(
          "Add",
          style: TextStyle(
              color: MetaColors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      ),
    );
  }
}

class ClearFiltersButton extends StatelessWidget {
  const ClearFiltersButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        elevation: 0,
        // shape: ,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: const BorderSide(color: Colors.redAccent)),
        color: Colors.redAccent.withOpacity(0.1),
        onPressed: () {
          BlocProvider.of<EmployeeCubit>(context).clearFilters();
        },
        child: const Text(
          "Clear Filters",
          style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      ),
    );
  }
}

class SortByWidget extends StatelessWidget {
  const SortByWidget({super.key, required this.sortBy});
  final String sortBy;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: getEmployeeSortByValues()
            .map((e) => ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: sortBy == e ? Colors.green : Colors.white)),
                  selectedTileColor: Colors.green.withOpacity(0.1),
                  onTap: () {
                    BlocProvider.of<EmployeeCubit>(context).sortEmployees(e);
                  },
                  trailing: sortBy == e
                      ? Icon(
                          Icons.done_all,
                          color: Colors.green,
                        )
                      : null,
                  // selectedColor: Colors.green,
                  selected: sortBy == e,
                  title: Text(
                    e.capitalize(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: sortBy == e ? FontWeight.w700 : null),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
