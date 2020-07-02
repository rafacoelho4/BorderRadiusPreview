import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Border Radius Preview'),
        backgroundColor: Colors.purple[400],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 20.0),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final key = new GlobalKey<ScaffoldState>();
  double _border = 15.0;

  TextEditingController borderController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _setBorder() {
    setState(() {
      _border = double.parse(borderController.text);
      borderController.text = "";
    });
  }

  void _copyTo() {
    String _borderCode = '''
.box {
  border-radius: ${_border}px;
  }
  ''';
    Clipboard.setData(new ClipboardData(text: _borderCode.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.ease,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_border),
              color: Colors.purple[400]),
          height: 180.0,
          width: 180.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                controller: borderController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira um número";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) _setBorder();
                    },
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Go!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0),
                    ),
                    color: Colors.purple),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                child: Text(
                  'Copy to clipboard',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                ),
                onTap: () {
                  _copyTo();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
