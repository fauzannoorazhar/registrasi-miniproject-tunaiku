import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_tunaiku/bloc/province_event.dart';
import 'package:register_tunaiku/bloc/province_state.dart';
import 'package:register_tunaiku/models/province.dart';
import 'package:register_tunaiku/data/domain/province_domain.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
    final ProvinceDomain proviceDomain;
    final Future future;

    ProvinceBloc({
        @required this.proviceDomain,
        @required this.future
    });

    @override
    ProvinceState get initialState => ProvinceLoadingFetch();

    @override
    Stream<ProvinceState> mapEventToState(ProvinceEvent event) async* {
        if (event is ProvinceListFetching) {
            yield ProvinceLoadingFetch();

            try {
                List<Province> listProvince = await this.future;
                yield ProvinceSuccessFetch(listProvince: listProvince);
            } catch (e) {
                yield ProvinceErrorFetch(error: e.toString());
            }
        }
    }
}