class CSValidator{
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "User is required";
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return "Enter a valid User";
    }
    return null;
  }
  static String? validateEmptyText( String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return "$fieldName is required";
    }
    return null;
  }
  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Password is required";
    }

    // check if password is at least 6 characters
    if(value.length < 6){
      return "Password must be at least 6 characters";
    }
    return null;
  }
}