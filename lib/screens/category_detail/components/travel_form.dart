import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../constants/colors.dart';
import '../../../constants/size_config.dart';

class TravelForm extends StatelessWidget {
  const TravelForm({
    Key? key,
    required this.place,
  }) : super(key: key);

  final String place;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8.0),
              ),
              child: Text(
                "Book a Trip?",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                  color: tPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                buildNumberOfPeopleField(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                buildDateFromField(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'To',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  initialDate: DateTime.now(),
                ),
              ],
            ),
          ),
          // const DatePickerWidget(
          //   restorationId: "datePicker",
          // ),
        ],
      ),
    );
  }

  DateTimeFormField buildDateFromField() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'From',
      ),
      mode: DateTimeFieldPickerMode.date,
    );
  }

  DateTimeFormField buildDateToField() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'To',
      ),
      mode: DateTimeFieldPickerMode.date,
    );
  }

  TextFormField buildNumberOfPeopleField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Number People",
        hintText: "Number of People",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/pen.svg"),
        suffixIconColor: tPrimaryColor,
      ),
    );
  }
}
