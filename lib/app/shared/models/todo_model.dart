import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  late String title;
  late bool check;
  DocumentReference? reference;

  TodoModel({this.title = '', this.check = false, this.reference});

  //*Recuperando Dados do Firebase Firestore em uma Factory
  factory TodoModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return TodoModel(
      title: documentSnapshot['title'],
      check: documentSnapshot['check'],
      reference: documentSnapshot.reference,
    );
  }

  //*Salvando ou Editando Dados no/do Firebase Firestore
  Future save() async {
    if (reference == null) {
      //Pega a posição que será salva para futura ordenação dos dados para um menor processamento
      //Outra opção seria utilizar um timestamp, mas isso demandaria maior processamento da aplicação
      int position =
          (await FirebaseFirestore.instance.collection('todos').get()).size;
      reference = await FirebaseFirestore.instance.collection('todos').add({
        'title': title,
        'check': check,
        'position': position,
      }).then((value) {
        //TODO: Implementar tratamento de Sucesso
      }).catchError((error) {
        //TODO: Implementar o tratamento de erro
      });
    } else {
      await reference!.update({
        'title': title,
        'check': check,
      }).then((value) {
        //TODO: Implementar tratamento de Sucesso
      }).catchError((error) {
        //TODO: Implementar o tratamento de erro
      });
    }
  }
}
