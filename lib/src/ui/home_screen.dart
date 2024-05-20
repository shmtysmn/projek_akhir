import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool tripType = false;
  int _counter = 1;
  final TextEditingController _fromTec = TextEditingController();
  final TextEditingController _toTec = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Book tickets for your",
              style: GoogleFonts.montserrat(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "next trip",
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 140,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                "From",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _fromTec,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                "To",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _toTec,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    top: 16,
                    child: GestureDetector(
                      onTap: () {
                        final tmpText = _fromTec.text;
                        _fromTec.text = _toTec.text;
                        _toTec.text = tmpText;
                        setState(() {});
                      },
                      child: const Center(
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Icon(
                            Icons.sync,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Passengers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_counter > 1) {
                            setState(() {
                              _counter--;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                          color: _counter == 1 ? Colors.grey : Colors.black,
                        ),
                      ),
                      Text(
                        "$_counter",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _counter++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            const Text(
              "Do you have promocode?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            GestureDetector(
              onTap: () {
                context.push("/detail");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(48),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Search for Trips",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
