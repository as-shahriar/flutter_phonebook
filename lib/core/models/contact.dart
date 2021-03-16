class Contact {
  int contact_id;
  int user_id;
  String address;
  String name;

  Contact();
  Contact.fromMap(Map<String, dynamic> map) {
    contact_id = map['contact_id'];
    user_id = map['user_id'];
    address = map['address'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'contact_id': contact_id,
      'user_id': user_id,
      'address': address,
      'name': name
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
