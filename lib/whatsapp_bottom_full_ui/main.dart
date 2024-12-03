import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Hero(
            tag: "page1",
            child: HomePage()),
        "/home": (context) => Hero(tag: "page1",
            child: const HomePage1()),
      },
    );
  }
}

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    BottomClass.bottomClass.listContextAddBottomMethod(context);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ListView.builder(
              itemCount: colorSet.length,
              itemBuilder: (context, index) => ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  color: colorSet[index],
                ),
                title: Text(0.toString()),
              ),),
          ),
          // bottomIconNavigator(context: context, selectText: "selectText"),
        ],
      ),
      bottomNavigationBar: bottomContainer(),
    );
  }
}


List colorSet = [Colors.black,Colors.red,Colors.blue,Colors.orange];
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BottomClass.bottomClass.listContextAddBottomMethod(context);
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: colorSet.length+20,
            itemBuilder: (context, index) => ListTile(
              leading: Container(
                height: 50,
                width: 50,
                color: colorSet[1],
              ),
              title: Text(0.toString()),
            ),),
          // bottomIconNavigator(context: context, selectText: "selectText"),
        ],
      ),
      bottomNavigationBar: bottomContainer(),
      backgroundColor: Colors.blue.withOpacity(0.1),
    );
  }
}

List _bottomList = [];

class BottomClass {
  BottomClass._();

  static BottomClass bottomClass = BottomClass._();

  int index = 0;
  void listContextAddBottomMethod(BuildContext context) {
    _bottomList = [
      TextButton(
        onPressed: () {
          // Navigator.of(context).pushNamed("/home");
          if(index!=0)
          {
            Navigator.of(context).pushReplacementNamed("/");
            index=0;
          }
        },
        child: SizedBox(
            height: double.infinity,
            child: index==0?columnIconSetUser(iconFind: Icon(Icons.home,color: Colors.black,size: 22,), textFind: 'Home'):columnIconSetUser2(iconFind: Icon(Icons.home_outlined,color: Colors.black,), textFind: "Home")),
      ),
      TextButton(
        onPressed: () {
          if(index!=1)
          {
            Navigator.of(context).pushReplacementNamed("/home");
            index=1;
          }
        },
        child: SizedBox(
            height: double.infinity,
            child: index==1?columnIconSetUser(iconFind: Icon(Icons.web,color: Colors.black,size: 22,), textFind: 'Website'):columnIconSetUser2(iconFind: Icon(Icons.web_asset,color: Colors.black,), textFind: "Website")),
      ),
      TextButton(
        // height: double.infinity,
        onPressed: () {
          if(index!=2)
          {
            Navigator.of(context).pushReplacementNamed("/");
            index=2;
          }
        },
        child: SizedBox(
            height: double.infinity,
            child: index==2?columnIconSetUser(iconFind: Icon(Icons.chat,color: Colors.black,size: 22,), textFind: 'Massage'):columnIconSetUser2(iconFind: const Icon(Icons.chat_outlined,color: Colors.black,), textFind: "Massage")),
      ),
      TextButton(
        // height: double.infinity,
        onPressed: () {
          if(index!=3)
          {
            Navigator.of(context).pushReplacementNamed("/home");
            index=3;
          }
        },
        child: SizedBox(
            height: double.infinity,
            child: index==3?columnIconSetUser(iconFind: Icon(Icons.favorite,color: Colors.black,size: 22,), textFind: 'Favorite'):columnIconSetUser2(iconFind: Icon(Icons.favorite_border_rounded,color: Colors.black,), textFind: "Favorite")),
      ),
      TextButton(
        // height: double.infinity,
        onPressed: () {
          if(index!=4)
          {
            Navigator.of(context).pushReplacementNamed("/home");
            index=4;
          }
        },
        child: SizedBox(
            height: double.infinity,
            child: index==4?columnIconSetUser(iconFind: Icon(Icons.person,color: Colors.black,size: 22,), textFind: 'Profile'):columnIconSetUser2(iconFind: Icon(Icons.person_2_outlined,color: Colors.black,), textFind: "Profile")),
      ),
    ];
  }

  Column columnIconSetUser({required Icon iconFind,required String textFind}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(),
        Spacer(),
        Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15)),
            child: iconFind),
        Spacer(),
        Text(textFind,style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
        Spacer(),
        Spacer(),
      ],
    );
  }
}
Column columnIconSetUser2({required Icon iconFind,required String textFind}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(),
        Spacer(),
        iconFind,
        Spacer(),
        Text(textFind,style: TextStyle(color: Colors.black,fontSize: 12),),
        Spacer(),
        Spacer(),
      ],
    );
  }


Container bottomContainer() {
  return Container(
    height: 80,
    color: Colors.grey.shade200,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          _bottomList.length,
              (index) => _bottomList[index],
        ),
      ],
    ),
  );
}
