import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  List<UserModel>users=[
      UserModel(id: 1, name: 'Yassine', email: 'yassine@gmail.com',phone: '0666639064'),
    UserModel(id: 2, name: 'rahim', email: 'rahim@gmail.com',phone: '0712144521'),
    UserModel(id: 3, name: 'mirizik', email: 'mirizik@gmail.com',phone: '0612144521'),
  ] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(
        leading: Icon(Icons.account_balance_outlined),
        title: Text('REAL MADRID'),
      ),
      body: ListView.separated(itemBuilder: (context,index)=>builditem(users[index]),
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ) ,
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.teal[300],
            ),
          ),

          itemCount: users.length)
    );
  }
  Widget builditem(UserModel user)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 25.0,
            child: Text(
              '${user.name![0]}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),

            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                '${user.name}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                '${user.email}',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 50.0,
          ),
          Text('${user.phone}',
          )
        ],
      ),
    );
  }

}
class UserModel
{
  final int? id;
  final String? name;
  String? email;
  String? phone;
  UserModel({
    @required this.id,
    @required  this.name,
    @required  this.email,
    @required  this.phone,
});

}
