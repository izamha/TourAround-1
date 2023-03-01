import 'package:flutter/material.dart';
import 'package:tour_around/components/card_list_item.dart';
import 'package:tour_around/components/circle_list_item.dart';
import 'package:tour_around/components/custom_snackbar.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'components/shimmer_loading.dart';

class Playground extends StatefulWidget {
  const Playground({super.key});

  static String routeName = "/playground";

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playground"),
      ),
      body: Column(
        children: [
          Center(
            child: _buildTopRowItem(),
          ),
          _buildListItem(),
        ],
      ),
    );
  }

  Widget _buildTopRowItem() {
    return const ShimmerLoading(
      isLoading: true,
      child: CircleListItem(),
    );
  }

  Widget _buildListItem() {
    return const ShimmerLoading(
      isLoading: true,
      child: CardListItem(
        isLoading: true,
      ),
    );
  }

  void customShowSnackbar() {
    Future.delayed(Duration.zero).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomSnackbar(
            text: "666 km",
            bubbleColor: Color.fromARGB(255, 230, 234, 241),
            snackbarColor: tPrimaryColor,
            snackTitle: "Total Distance",
          ),
          duration: Duration(milliseconds: 15000),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
