import 'package:flutter/material.dart';
import 'package:reto_promart/data/actions/user_action/user_action.dart';
import 'package:reto_promart/domain/entities/repository/person.dart';

// class AddPerson extends StatefulWidget {
//   const AddPerson({Key? key}) : super(key: key);

//   @override
//   AddPersonState createState() => AddPersonState();
// }

// class AddPersonState extends State<AddPerson> {
//   final _formKey = GlobalKey<FormState>();
//   final _userAction = UserAction();
//   final _person = PersonRepositoryEntity(
//       address_city: '',
//       address_geo_lat: '',
//       address_geo_lng: '',
//       address_suite: '',
//       address_street: '',
//       address_zipcode: '',
//       email: '',
//       isOnline: 0,
//       name: '',
//       username: '');

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextFormField(
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.person,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su nombre',
//                 ),
//                 validator: _userAction.validateName,
//                 onSaved: (value) => _person.name = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.person,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su nickname',
//                 ),
//                 validator: _userAction.validateNickname,
//                 onSaved: (value) => _person.username = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.mail,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su correo',
//                 ),
//                 validator: _userAction.validateEmail,
//                 onSaved: (value) => _person.email = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.home,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su calle',
//                 ),
//                 validator: _userAction.validateGeneral,
//                 onSaved: (value) => _person.address_street = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.home,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su suite',
//                 ),
//                 validator: _userAction.validateGeneral,
//                 onSaved: (value) => _person.address_suite = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.home,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su ciudad',
//                 ),
//                 validator: _userAction.validateGeneral,
//                 onSaved: (value) => _person.address_city = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.home,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su codigo postal',
//                 ),
//                 validator: _userAction.validateGeneral,
//                 onSaved: (value) => _person.address_zipcode = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.home,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su latitud',
//                 ),
//                 validator: _userAction.validateGeneral,
//                 onSaved: (value) => _person.address_geo_lat = value!,
//               ),
//               const SizedBox(height: 25),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.home,
//                     size: 30,
//                   ),
//                   labelText: 'Ingrese su longitud',
//                 ),
//                 validator: _userAction.validateGeneral,
//                 onSaved: (value) => _person.address_geo_lng = value!,
//               ),
//               const SizedBox(height: 25),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       await _userAction.addPerson(_person);
//                       if (!mounted) return;
//                       Navigator.pop(context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   child: const Text('Enviar'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



class EditPerson extends StatefulWidget {
  const EditPerson({Key? key, required this.person}) : super(key: key);
  final PersonRepositoryEntity person;

  @override
  EditPersonState createState() => EditPersonState();
}

class EditPersonState extends State<EditPerson> {
  final _formKey = GlobalKey<FormState>();
  final _userAction = UserAction();
  late PersonRepositoryEntity _person;

  @override
  void initState() {
    super.initState();
    _person = widget.person;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  labelText: 'Ingrese su nombre',
                ),
                validator: _userAction.validateName,
                onSaved: (value) => _person.name = value!,
                initialValue: _person.name,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  labelText: 'Ingrese su nickname',
                ),
                validator: _userAction.validateNickname,
                onSaved: (value) => _person.username = value!,
                initialValue: _person.username,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.mail,
                    size: 30,
                  ),
                  labelText: 'Ingrese su correo',
                ),
                validator: _userAction.validateEmail,
                onSaved: (value) => _person.email = value!,
                initialValue: _person.email,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  labelText: 'Ingrese su calle',
                ),
                validator: _userAction.validateGeneral,
                onSaved: (value) => _person.address_street = value!,
                initialValue: _person.address_street,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  labelText: 'Ingrese su suite',
                ),
                validator: _userAction.validateGeneral,
                onSaved: (value) => _person.address_suite = value!,
                initialValue: _person.address_suite,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  labelText: 'Ingrese su ciudad',
                ),
                validator: _userAction.validateGeneral,
                onSaved: (value) => _person.address_city = value!,
                initialValue: _person.address_city,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  labelText: 'Ingrese su codigo postal',
                ),
                validator: _userAction.validateGeneral,
                onSaved: (value) => _person.address_zipcode = value!,
                initialValue: _person.address_zipcode,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  labelText: 'Ingrese su latitud',
                ),
                validator: _userAction.validateGeneral,
                onSaved: (value) => _person.address_geo_lat = value!,
                initialValue: _person.address_geo_lat,
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  labelText: 'Ingrese su longitud',
                ),
                validator: _userAction.validateGeneral,
                onSaved: (value) => _person.address_geo_lng = value!,
                initialValue: _person.address_geo_lng,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await _userAction.updatePerson(_person);
                      if (!mounted) return;
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
