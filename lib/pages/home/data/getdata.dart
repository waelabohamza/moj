import 'package:moj/component/crud.dart';
import 'package:moj/pages/linkapi.dart';
Crud _crud = new Crud();
getDataHome()async  {
        var responsebody = await _crud.readData(linkHomeData);
        return responsebody ; 
}







