import 'dart:js_interop';

class Notee{

  int? _id;
  late String _title;
  late String _body;

  Notee(this._title, this._body);
  Notee.withId(this._id,this._title, this._body);

  int? get id => _id;
  String get title => _title;
  String get body => _body;


  set title(String newTitle){
    if(newTitle.length < 255){
      _title = newTitle;
    }
  }
   set body(String newBody){
    _body = newBody;
   }

   //Convert a NOte object into a Map object
    Map<String, dynamic> toMap(){
      var map = <String, dynamic>{};

      map['id'] = _id;
      map['title'] = _title;
      map['body'] = _body;

      return map;
    }

    //Extract a NOte object from a Map object
    Notee.fromMapObject(Map<String, dynamic> map){
    _id = map['id'];
    _title = map['title'];
    _body = map['body'];
    }



}