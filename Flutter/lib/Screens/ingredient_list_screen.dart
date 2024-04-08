import 'package:ezpill/Screens/pill_list_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:ezpill/widgets/image_button.dart';
import 'package:flutter/material.dart';

class IngredientListScreen extends StatelessWidget {
  const IngredientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> nutritionList = [
      //  {key : value_string, key : value_dynamic}
      {
        'name': '엽산',
        'image': "assets/icons/free-icon-carrot-1628768.png",
        'text': "면역력에\n도움을 주는",
      },
      {
        'name': '칼슘',
        'image': "assets/icons/free-icon-milk-products-8708829.png",
        'text': "튼튼한 뼈와\n치아를 위한",
      },
      {
        'name': '철분',
        'image': "assets/icons/free-icon-meat-2339945.png",
        'text': "빈혈 예방과\n면역력을 위한",
      },
      {
        'name': '비타민D',
        'image': "assets/icons/free-icon-sun-5892536.png",
        'text': "햇빛이 필요한\n엄마들을 위해",
      },
      {
        'name': '오메가3',
        'image': "assets/icons/free-icon-fish-1907083.png",
        'text': "건강한 눈과\n혈행개선을 위한",
      },

      {
        'name': '콜라겐',
        'image': "assets/icons/free-icon-massage-5362182.png",
        'text': "촉촉하고 탄탄한\n피부를 위해",
      },
      {
        'name': '루테인',
        'image': "assets/icons/free-icon-eye-822102.png",
        'text': "피로한 눈이\n힘낼 수 있게",
      },
      {
        'name': '유산균',
        'image': "assets/icons/free-icon-intestine-6147731.png",
        'text': "장 건강을\n책임지는",
      },
      {
        'name': '비타민B',
        'image': "assets/icons/free-icon-egg-3635657.png",
        'text': "피로 회복에\n도움을 주는",
      },
      {
        'name': '마그네슘',
        'image': "assets/icons/free-icon-nuts-6355295.png",
        'text': "스트레스와\n혈당 조절에 좋은",
      },
    ];

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "성분으로 검색하기"),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 한 줄에 3개의 요소를 표시
          crossAxisSpacing: 16, // 수평 간격
          mainAxisSpacing: 16, // 수직 간격
          childAspectRatio: 1, // 아이템의 가로 세로 비율
        ),
        itemCount: nutritionList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String nutrientName = nutritionList[index]['name'] as String;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PillListScreen(nutrientName),
                ),
              );
            },
            child: SizedBox(
                height: 100,
                width: 100,
                child: ImageButton(
                  ingredientName: nutritionList.elementAt(index)['name'],
                  ingredientImage: nutritionList.elementAt(index)['image'],
                  ingredientText: nutritionList.elementAt(index)['text'],
                )),
          );
        },
      ),
    );
  }
}
