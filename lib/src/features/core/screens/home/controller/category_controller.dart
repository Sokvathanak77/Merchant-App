import 'package:get/get.dart';
import 'package:merchant/src/features/core/screens/home/model/category_model.dart';
import 'package:merchant/src/features/core/screens/home/repository/category_repo.dart';

class CategoryController extends GetxController{
  @override
  void onInit() async{
    getCategoryList();
    super.onInit();
  }

  final CategoryRepo categoryRepo;

  CategoryController({required this.categoryRepo});

  RxList categoryLst=[].obs;
  RxList categoryItem=[].obs;
  RxString categoryName = "".obs;
  RxBool isLoadedCategory = false.obs;
  RxBool isNoCategory = false.obs;

  Future<void> getCategoryList()async{
    Response response = await categoryRepo.getCategoryList();
    if(response.statusCode==200){
      CategoryListModel categoryLstModel = CategoryListModel.fromJson(response.body);

      categoryLst.value = categoryLstModel.data!;
    }else{
      print("category list error");
    }
    update();
  }

  Future<void> refreshCategoryList() async {
  // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));
  // Generate new data
    await getCategoryList();
  }
  
  Future<void> getCategoryItems(int categoryId)async{
    isLoadedCategory.value=false;
    isNoCategory.value = false;
    Response response = await categoryRepo.getCategoryItems(categoryId);
    if(response.statusCode==200){
      CategoryItemModel _categoryItemModel = CategoryItemModel.fromJson(response.body);
      
      if(_categoryItemModel.data == null){
        _categoryItemModel.data = [];
        isNoCategory.value = true;
      }else{
        categoryItem.value = _categoryItemModel.data!;
        categoryName.value = _categoryItemModel.categoryName!;
       
      }
      isLoadedCategory.value = true;
      
      
    }else{
      print("category Items error");
    }
    update();
  }
}