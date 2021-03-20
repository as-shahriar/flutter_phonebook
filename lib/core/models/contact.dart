import 'dart:typed_data';

class Contact {
  int contact_id;
  int user_id;
  String address;
  String name;
  Uint8List picture;

  Contact();
  Contact.fromMap(Map<String, dynamic> map) {
    contact_id = map['contact_id'];
    user_id = map['user_id'];
    address = map['address'];
    name = map['name'];
    picture = map['picture'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'contact_id': contact_id,
      'user_id': user_id,
      'address': address,
      'name': name,
      'picture': picture
    };
    if (contact_id != null) map['contact_id'] = contact_id;
    return map;
  }
}

class Email {
  int email_id;
  int contact_id;
  String email;

  Email();
  Email.fromMap(Map<String, dynamic> map) {
    contact_id = map['contact_id'];
    email_id = map['email_id'];
    email = map['email'];
  }

  Email.init(String emailIdAndEmail, int contactId) {
    List l = emailIdAndEmail.split('-');

    contact_id = contactId;
    email_id = int.tryParse(l[0]);
    email = l[1];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'contact_id': contact_id,
      'email_id': email_id,
      'email': email
    };
    if (email_id != null) map['email_id'] = email_id;
    return map;
  }
}

class Phone {
  int phone_id;
  int contact_id;
  String phone;

  Phone();
  Phone.fromMap(Map<String, dynamic> map) {
    contact_id = map['contact_id'];
    phone_id = map['phone_id'];
    phone = map['phone'];
  }
  Phone.init(String phoneIdandPhone, int contactId) {
    List l = phoneIdandPhone.split('-');
    contact_id = contactId;
    phone_id = int.tryParse(l[0]);
    phone = l[1];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'contact_id': contact_id,
      'phone_id': phone_id,
      'phone': phone
    };
    if (phone_id != null) map['phone_id'] = phone_id;
    return map;
  }
}

class BaseContact {
  Contact contact = new Contact();
  List<Email> emails = [];
  List<Phone> phones = [];
  BaseContact();
  BaseContact.contact(this.contact);
  BaseContact.fromMap(Map<String, dynamic> map) {
    contact.contact_id = map['contact_id'];
    contact.address = map['address'];
    contact.name = map['name'];

    List l = map['phones'].split(',');
    for (var item in l) {
      phones.add(Phone.init(item, map['contact_id']));
    }
    List l1 = map['emails'].split(',');
    for (var item in l1) {
      emails.add(Email.init(item, map['contact_id']));
    }
  }
}
