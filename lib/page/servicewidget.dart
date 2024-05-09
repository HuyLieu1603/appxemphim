// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:appxemphim/page/payment/paymentmethodwidget.dart';
import 'package:flutter/material.dart';
import '../data/model/service.dart';
import '../config/const.dart';
import '../data/provider/serviceprovider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ServiceWidget extends StatefulWidget {
  final String? email;
  final String? password;

  ServiceWidget({Key? key, this.email, this.password}) : super(key: key);

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  List<Service> lstService = [];
  late int? durationn;
  late bool selectedbuttonframe = false;
  late String selectedServiceId = '1';
  Future<String> loadServiceList() async {
    final url = 'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Service';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Service> services =
          responseData.map((data) => Service.fromJson(data)).toList();
      lstService = services;
      print('lay duoc rui');
      return ' ';
    } else {
      print('ko lay dc ');
      throw Exception('Failed to load services');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _toggleServiceSelection(String serviceId) {
    setState(() {
      selectedServiceId = serviceId;
      print('selectedServiceId: $selectedServiceId');

      lstService.forEach((service) {
        if (service.id == selectedServiceId) {
          service.isSelected = selectedbuttonframe;
        } else {
          service.isSelected = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadServiceList(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    const Text(
                      "Chọn gói dịch vụ",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 150,
                      child: GridView.builder(
                        itemCount: lstService.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:
                              1.0, // Fix tỷ lệ chiều rộng và chiều cao của phần tử
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          lstService.forEach((service) {
                            if (service.id == selectedServiceId) {
                              service.isSelected = selectedbuttonframe;
                            } else {
                              service.isSelected = false;
                            }
                          });
                          print(lstService.length);
                          return Container(
                            // Thiết lập các thuộc tính để cố định phần tử
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.0),
                            ),
                            child: slide(lstService[index]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 1, // Chiều cao của Divider
                          margin: const EdgeInsets.symmetric(
                              vertical: 10), // Khoảng cách top và bottom
                          color: Colors.grey, // Màu của Divider
                          width: 300, // Độ rộng của Divider
                        ),
                        const Text(
                          "Số lượng thiết bị",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "1",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          "4",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 1, // Chiều cao của Divider
                          margin: const EdgeInsets.symmetric(
                              vertical: 10), // Khoảng cách top và bottom
                          color: Colors.grey, // Màu của Divider
                          width: 300, // Độ rộng của Divider
                        ),
                        const Text(
                          "Độ phân giải",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "480p",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          "1080p",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          "4K +HDR",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      "Khả năng xem ở chế độ HD và Ultra HD tùy thuộc vào dịch vụ Internet và khả năng thiết bị của bạn. Không phải nội dung nào cũng xem được ở chế độ HD hoặc Ultra HD. Xem điều khoản sử dụng để biết thêm chi tiết",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodWidget(
                              selectedServiceIds: selectedServiceId,
                              email: widget.email,
                              password: widget.password,
                              durationn: durationn,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(198, 198, 10, 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(317, 46))),
                      child: const Text(
                        "Tiếp theo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget slide(Service listService) {
    String selectedServiceId = listService.id ?? '';

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          listService.isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          listService.isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (!listService.isSelected) {
              // Only toggle selection if the service is not already selected
              listService.isSelected = true;
              selectedbuttonframe = true;
              _toggleServiceSelection(selectedServiceId);
              durationn = listService.duration;
              print('a' + ' ' + '${listService.isSelected}');
            } else {
              // Deselect the service if it is already selected
              listService.isSelected = false;
              _toggleServiceSelection('');
              // Pass an empty string to indicate no service is selected
            }
            print(listService.isSelected);
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Thời gian chuyển đổi màu
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: listService.isSelected ? Colors.white : Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            color: listService.isSelected
                ? Color.fromARGB(198, 198, 10, 10)
                : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${utf8.decode(listService.name.toString().codeUnits)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  color: listService.isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Image.asset(
                  url_img + 'HUFLIX.png',
                  width: 50,
                ),
              ),
              SizedBox(height: 8),
              Text(
                NumberFormat('#,##0').format(listService.price) + ' VND',
                style: TextStyle(
                  fontSize: 11,
                  color: listService.isSelected ? Colors.white : Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 8), // Add more spacing if needed
            ],
          ),
        ),
      ),
    );
  }
}
