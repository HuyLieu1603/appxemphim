import 'package:flutter/material.dart';
import '../data/model/service.dart';
import '../config/const.dart';
import '../data/provider/serviceprovider.dart';
import 'package:intl/intl.dart';

class ServiceWidget extends StatefulWidget {
  const ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  List<Service> lstService = [];
  Future<String> loadServiceList() async {
    lstService = await ReadData().loadData();
    return '';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadServiceList(),
      builder: (BuildContext, AsyncSnapshot<String> snapshot) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 64,
              ),
              const Text(
                "Chọn gói dịch vụ",
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: lstService.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return slide(lstService[index]);
                  },
                ),
              ),
              const SizedBox(
                height: 32,
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
                height: 32,
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
                height: 32,
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
              Expanded(
                child: GridView.builder(
                  itemCount: lstService.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return grid(lstService[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget grid(Service listService) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${listService.resolution}",
            style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
  Widget slide(Service listService) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(8),
      // decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              url_img + listService.img!,
              height: 87,
              width: 100,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
            ),
          ),
          Text(
            listService.name ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          Text(
            "${NumberFormat('###,###,### VNĐ').format(listService.price)}",
            style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
