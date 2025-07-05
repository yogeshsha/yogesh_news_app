import 'package:flutter/material.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({super.key});

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  // List<Details> items = [
  //   Details(
  //       title: "Health",
  //       description:
  //           "2017 Golden Globe asdfs Awards and g sajkl;djflksjfklsdjfklsjflsjfklsjfkldjfajdslkjflksadjkljklsjlkfsjadklfsklafjlkjet ready for the craziestaslk;dfhjlsjklsjfjfaklsjfklsdjfkljlksadjfkl;aaaa night sadlkfjlkdasjfdjsklfjdsaklfjsdklfjklsdjflk;sdfjklsdjfklsdajfkl;dsjfklsdjfkl;sdjfklasjfklsdajfklsfjlks;jkldsfgjlksfjslkdflskdjfklsjflkflkads",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       isLiked: false,
  //       type: "shortnews",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: true,
  //       type: "normal",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: false,
  //       type: "normal",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: false,
  //       type: "normal",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: false,
  //       type: "normal",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: false,
  //       type: "normal",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: false,
  //       type: "normal",
  //       time: DateTime.now()),
  //   Details(
  //       title: "World",
  //       image:
  //           "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  //       description:
  //           "2017 Golden Globe Awards and get ready for the craziest night",
  //       isLiked: false,
  //       type: "normal",
  //       time: DateTime.now()),
  // ];
  //
  // List<String> homeSlider = [
  //   "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
  //   "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
  //   "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  // ];

  // final detailRepository = DetailRepositoryImpl();
  // late DetailUseCase detailUseCase = DetailUseCase(detailRepository: detailRepository) ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // return Template1(feature: const [], latest: const [],controller: widget,);
    // return BlocBuilder<DetailBloc, DetailState>(
    //   builder: (context, state) {
    //     if (state is DetailLoading) {
    //       return Template1(homeSlider: const [], items: const []);
    //     } else if (state is DetailLoaded) {
    //       // return Template1(homeSlider:const [] ,items: const []);
    //
    //       return Template1(homeSlider: homeSlider, items: items);
    //     } else {
    //       return Template1(homeSlider: homeSlider, items: items);
    //
    //       // return const Center(
    //       //   child: Text('No agents found'),
    //       // );
    //     }
    //   },
    // );
  }
}

class Details {
  String title;
  String image;
  String description;
  String type;
  bool isLiked;
  DateTime time;

  Details(
      {required this.title,
      required this.image,
      required this.description,
      required this.isLiked,
      required this.type,
      required this.time});
}
