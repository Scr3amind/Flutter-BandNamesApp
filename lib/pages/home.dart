import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(
      id: '1',
      name: 'Nirvana',
      votes: 5
    ),
    Band(
      id: '2',
      name: 'Foo Fighters',
      votes: 5
    ),
    Band(
      id: '3',
      name: 'Arctic Monkeys',
      votes: 5
    ),
    Band(
      id: '4',
      name: 'Cage The Elephant',
      votes: 5
    ),
    Band(
      id: '5',
      name: 'Joy Division',
      votes: 5
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index]),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
      ),


   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        print('Direction: $direction');
        print('id: ${band.name}');
        // TODO
      },
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Deleted', style: TextStyle(color: Colors.white),)
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
            onTap: (){
              print(band.name);
            },
          ),
    );
  }

  void addNewBand() {

    final textController = new TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New band name'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text)
            )
          ],
        );
      }
    );
  }

  void addBandToList(String bandName) {

    print(bandName);

    if(bandName.length > 1){
      this.bands.add(new Band(id: DateTime.now().toString(), name: bandName, votes: 0));
      setState(() {});
    }

    

    Navigator.pop(context);

  }


}