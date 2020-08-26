import 'package:dio/dio.dart';
import 'package:register_tunaiku/models/province.dart';
import 'package:register_tunaiku/utilites/constant.dart';

class ProvinceRepository {
    Dio dio = Dio();

    Future<List<Province>> getDataListProvince() async {
        try {
            List<Province> listProvince = new List<Province>();

            final Response response = await dio.get(apiProvince);
            if (response.statusCode == 200) {
                List listJson = response.data['provinsi'];
                listProvince = listJson.map((e) => new Province.fromJson(e)).toList();
            }

            return listProvince;

        } catch (e) {
            print(e.toString);
        }
    }
}