mixin AuthValidator {
  String? emailValidate(String? value) {
    if(value == null || value.isEmpty) {
      return "The Email is required!";
    } else if(!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      return "Please enter a valid email address!";
    }
    return null;
  }

  String? passwordValidate(String? value) {
    if(value == null || value.isEmpty) {
      return "The Password is required!";
    } else if(value.length < 6) {
      return "Password must be at least 6 characters!";
    }
    return null;
  }
}