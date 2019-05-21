class Validator{
  String validateText(String val) {
    Pattern pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
    RegExp regex = new RegExp(pattern);

    if (val == "" || val == null) return "Please enter something!";
    else return regex.hasMatch(val) ? 'Enter valid text!' : null;
  }

  String validatePassword(String val){
    if(val == "" || val == null) return "Please enter something!";
    else if(val.length < 8) return "Password must be a least 8 characters!";
    else return null;
  }

  String validateEmail(String val) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    return !regex.hasMatch(val) ? 'Enter valid email!' : null;
  }

  String validateNumber(String val){
    if(val == null) return "Value can't be null!";
    else if(int.tryParse(val) == null) return "Enter number!";
    else return null;
  }
}