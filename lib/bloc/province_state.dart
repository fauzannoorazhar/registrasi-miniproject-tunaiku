import 'package:equatable/equatable.dart';
import 'package:register_tunaiku/models/province.dart';

abstract class ProvinceState extends Equatable {
    const ProvinceState();
}

class ProvinceLoadingFetch extends ProvinceState {
    @override
    List<Object> get props => [];
}

class ProvinceSuccessFetch extends ProvinceState {
    final List<Province> listProvince;

    const ProvinceSuccessFetch({this.listProvince});

    @override
    List<Object> get props => [];
}

class ProvinceErrorFetch extends ProvinceState {
    final String error;
    
    const ProvinceErrorFetch({this.error});

    @override
    List<Object> get props => [];

    @override
    String toString() {
        return 'Failure {error : $error }';
    }
}