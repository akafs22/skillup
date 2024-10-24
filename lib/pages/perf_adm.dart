import 'package:flutter/material.dart';

class EditAdm extends StatefulWidget {
  const EditAdm({super.key});

  @override
  State<EditAdm> createState() => _EditAdmState();
}

class _EditAdmState extends State<EditAdm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 203, 224),
        title: Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Image.asset('images/logop.png'),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
  
            Text(
              'Matricula n°0000',
              style: TextStyle(
                color: Color.fromARGB(255, 159, 54, 54),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
