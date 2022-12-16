String validateEmail (String value) {
  String msg = "";
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
  );
  if (value.isEmpty) {
    msg = "Nome de Utilizador obrigatório!";
  } else if (!regex.hasMatch(value)) {
    msg = "Por favor adicione o endereço de e-mail válido!";
  }
  return msg;
}