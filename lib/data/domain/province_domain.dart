import 'package:register_tunaiku/data/repository/province_repository.dart';
import 'package:register_tunaiku/models/province.dart';

class ProvinceDomain {
    final ProvinceRepository _provinceRepository;

    ProvinceDomain(this._provinceRepository);

    Future<List<Province>> getListProvince() {
        return _provinceRepository.getDataListProvince();
    }
}