import 'package:flutter/material.dart';
import 'package:digital_domi/models/document_model.dart';
import 'package:digital_domi/widgets/domi_docs_section.dart';
import 'package:digital_domi/widgets/domi_in_section.dart';

class CardView extends StatefulWidget {
  final double initialSize;
  final ValueChanged<double> onSizeChanged;

  const CardView({
    super.key,
    required this.initialSize,
    required this.onSizeChanged,
  });

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  // Let's imagine that we will get this data from an API
  final List<String> _imagePath = [
    "lib/assets/images/purse.jpg",
    "lib/assets/images/model.jpeg",
    "lib/assets/images/walking_purse.jpg",
    "lib/assets/images/tesla_red_car.jpg",
    "lib/assets/images/location_image.jpeg",
    "lib/assets/images/purse.jpg",
    "lib/assets/images/model.jpeg",
    "lib/assets/images/walking_purse.jpg",
    "lib/assets/images/tesla_red_car.jpg",
    "lib/assets/images/location_image.jpeg",
  ];

  final List<Document> _docsDetail = [
    Document(
      title: "100 Martinique Ave Title.pdf",
      lastOpen: "Opened Dec 4, 2023",
    ),
    Document(
      title: "Chase Bank Statement - November 2023.pdf",
      lastOpen: "Opened Nov 11, 2023",
    ),
    Document(
      title: "Backyard Remodal Renderings.xls",
      lastOpen: "Opened Dec 2, 2023",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateSize);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSize);
    _controller.dispose();
    super.dispose();
  }

  void _updateSize() {
    widget.onSizeChanged(_controller.size);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      minChildSize: 0.15,
      maxChildSize: 1,
      initialChildSize: widget.initialSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.black,
          ),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      DomiInSection(imagePath: _imagePath),
                      DomiDocsSection(docsDetail: _docsDetail),
                    ],
                  ),
                ),
              ),
              IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff4e4e4e),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
