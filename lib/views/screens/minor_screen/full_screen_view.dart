// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/appbar_widget.dart';

class FullScreenView extends StatefulWidget {
  final List<dynamic> imagelist;
  const FullScreenView({super.key, required this.imagelist});

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int numberImage = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: const AppbarBackButton(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  ('${numberImage + 1}') +
                      ('/') +
                      (widget.imagelist.length.toString()),
                  style: const TextStyle(fontSize: 24, letterSpacing: 8),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      numberImage = value;
                    });
                  },
                  controller: _controller,
                  children: images(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: imageView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> images() {
    return List.generate(
      widget.imagelist.length,
      (index) {
        return InteractiveViewer(
          transformationController: TransformationController(),
          child: Image.network(
            widget.imagelist[index].toString(),
          ),
        );
      },
    );
  }

  Widget imageView() {
    return ListView.builder(
      itemCount: widget.imagelist.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _controller.jumpToPage(index);
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Colors.lightBlue,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imagelist[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
