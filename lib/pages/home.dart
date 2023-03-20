import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data_time = {};

  @override
  Widget build(BuildContext context) {

    try{
      data_time = data_time.isNotEmpty ? data_time : ModalRoute.of(context)!.settings.arguments as Map;
    }catch(e){
      data_time = data_time;
    }

    String bgImage = data_time['isDayTime'] ? 'day.png' : 'night.png';

    Color? bgColor = data_time['isDayTime'] ? Colors.blue[700] : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 280.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data_time = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[200],
                  ),
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit Location'),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data_time['location'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        letterSpacing: 2.0
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  data_time['time'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 66.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
