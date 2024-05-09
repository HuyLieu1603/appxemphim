import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/data/model/Favorite/favoriteMovie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/movies.dart';
import '../page/Detailwidget/detailmoviewidget.dart';

class favoriteMovie extends StatefulWidget {
  const favoriteMovie({super.key});

  @override
  State<favoriteMovie> createState() => _favoriteMovieState();
}

class _favoriteMovieState extends State<favoriteMovie> {

  late Movies test;


  Future<List<Favorite>> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await APIResponsitory().takefavall(pref.getString('name').toString());
  }

  Future<Movies> fetchMovie(String id) async {
    Movies mov = await APIResponsitory().fetchMovieById(id);
    print(mov);
    return mov;
  }

  String capslock(String s) {
    List<String> words = s.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Danh sách yêu thích',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Favorite>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Không có dữ liệu",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              // hoặc SizedBox
              height: MediaQuery.of(context)
                  .size
                  .height, // thiết lập chiều cao cố định hoặc dựa vào điều kiện
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Số lượng cột trong lưới
                    crossAxisSpacing: 5, // Khoảng cách giữa các cột
                    mainAxisSpacing: 1, // Khoảng cách giữa các dòng
                    childAspectRatio:
                        0.65 // Tỷ lệ chiều rộng và chiều cao của mỗi ô trong lưới
                    ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final history = snapshot.data![index];
                  return _favWidget(history, context);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _favWidget(Favorite fav, BuildContext context) {
    
    


    return Card(
      color: Colors.black,
      child: InkWell(
        onTap: () async {
          Movies movs = await fetchMovie(fav.idMovie!);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => DetailMovies(
                        objMov: movs,
                      ))));
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 150,
                height: 200,
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  fav.img.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 223,
                      child: Text(
                        capslock(fav.nameMovie!),
                        maxLines: 2, // Giới hạn số dòng
                        overflow: TextOverflow
                            .ellipsis, // Xử lý trường hợp text dài vượt quá số dòng giới hạn
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
