import 'package:http/http.dart'as http;
import 'dart:convert';
class Networking
{
  Networking(this.uRl);
  var uRl;



  Future getdata()async
  {
    var url = Uri.parse(uRl);
    http.Response responce=await http.get(url);
    if(responce.statusCode==200)
    {
      String data= responce.body;

      return  jsonDecode(data);


    }else
    {
      print(responce.statusCode);}
  }


}
