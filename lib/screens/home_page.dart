import 'package:flutter/material.dart';

import '../controllers/homepage_controller.dart';

import '../widgets/tracked_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = HomePageController.instance;

  void showModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: true,
      backgroundColor: const Color(0xFF252525),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: BottomSheet(
            onClosing: () => {},
            dragHandleColor: const Color(0xFFAAAAAA),
            dragHandleSize: const Size(50, 4),
            constraints: const BoxConstraints(maxHeight: 150),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Package ID',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                        onChanged: (value) => setState(() => controller.packageID = value),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => controller.addPackage());

                          Navigator.of(context).pop();
                        },
                        child: const Text('Add', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        );
      }
    );
  }

  @override
  Widget build(context) { 
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Scaffold(
          backgroundColor: const Color(0xFF111111),
          appBar: AppBar(
            title: const Text(
              'My Pack',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              for (var (index, tracked) in controller.packages.reversed.indexed)
                TrackedWidget(id: tracked, index: index, description: 'Objeto em trânsito, por favor aguarde.', date: 'há 3 horas'),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 5),
            child: FloatingActionButton(
              onPressed: () => showModal(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add_rounded, size: 30, color: Colors.white),
            ),
          ),
        );
        }
    );
  }
}
