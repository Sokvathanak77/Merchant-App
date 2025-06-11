import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/utils/helper/helper_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/core/screens/home/home_screen.dart';
import 'exceptions/t_exceptions.dart';

/// -- README(Docs[6]) -- Bindings
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  static ApiService apiService = Get.find();

  /// Variables
  late final Rx<User?> _firebaseUser;
  final auth = FirebaseAuth.instance;
  final _phoneVerificationId = ''.obs;

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => firebaseUser?.uid ?? "";

  String get getUserEmail => firebaseUser?.email ?? "";

  /// Loads when app Launch from main.dart
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(auth.currentUser);
    _firebaseUser.bindStream(auth.userChanges());
    FlutterNativeSplash.remove();
    setInitialScreen(_firebaseUser.value);
    // ever(_firebaseUser, _setInitialScreen);
  }

  /// Setting initial screen
  setInitialScreen(User? user) async {
    var pref = await SharedPreferences.getInstance();
    String token = await pref.getString("user_token")??"";
    await checkToken(token).then((res) => {
      if(user == null || res.statusCode!=200){
        Get.offAll(() => SplashScreen())//WelcomeScreen())
      }else{
        apiService.updateHeader(token),
        AppConstant.USER_ID = res.body["data"]["id"].toString(),
        Get.offAll(()=>HomeScreen())
      }
    });
    
  }

  /* ---------------------------- Email & Password sign-in ---------------------------------*/

  /// [EmailAuthentication] - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code); // Throw custom [message] variable
      throw result.message;
    } catch (_) {
      const result = TExceptions();
      throw result.message;
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  // Future<void> sendEmailVerification() async {
  //   try {
  //     await _auth.currentUser?.sendEmailVerification();
  //   } on FirebaseAuthException catch (e) {
  //     final ex = TExceptions.fromCode(e.code);
  //     throw ex.message;
  //   } catch (_) {
  //     const ex = TExceptions();
  //     throw ex.message;
  //   }
  // }

  /* ---------------------------- Federated identity & social sign-in ---------------------------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  ///[FacebookAuthentication] - FACEBOOK
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email']);

      // Create a credential from the access token
      final AccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.tokenString);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Something went wrong. Try again!';
    }
  }

  /// [PhoneAuthentication] - LOGIN
  Future<void> loginWithPhoneNo(String phoneNumber) async {
    try {
      await auth.signInWithPhoneNumber(phoneNumber);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (e) {
      throw e.toString().isEmpty ? 'Unknown Error Occurred. Try again!' : e.toString();
    }
  }

  /// [PhoneAuthentication] - REGISTER
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        codeSent: (verificationId, resendToken) {
          _phoneVerificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _phoneVerificationId.value = verificationId;
        },
        verificationFailed: (e) {
          final result = TExceptions.fromCode(e.code);
          if(result == 'invalid-phone-number'){
            Get.snackbar("error", "The provided phone number is invalid");
          }else{
            Get.snackbar("error", "somthing went wrong!");
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } catch (e) {
      throw e.toString().isEmpty ? 'Unknown Error Occurred. Try again!' : e.toString();
    }
  }

  //check if user is created or not
  Future<void> checkIsSignUp(String phoneNo) async{
    if(firebaseUser==null){
      await phoneAuthentication(phoneNo);
    }else{
      await loginWithPhoneNo(phoneNo);
    }
  }

  /// [PhoneAuthentication] - VERIFY PHONE NO BY OTP
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: _phoneVerificationId.value, smsCode: otp),
      );
       if(credentials.user != null){
        return true;
      }else{
        Helper.errorSnackBar(title: tOhSnap, message: "something went wrong!");
        return false;
      }
    } on FirebaseException catch (e) {
      final result = TExceptions.fromCode(e.code);
      Helper.errorSnackBar(title: tOhSnap, message: result.message);
      return false;
    }
    
  }

  Map<String,String> header = {};
  Future<Response> logInToApi(String phone) async{
    Map<String ,String> body={
      "phoneNumber": phone,
      "pss":"12345678"
    };
      return await apiService.signUp(AppConstant.LOG_WITH_PHONE, body,header);
  }
  
  Future<Response> newUserToApi(String phone,name,dob,pass) async{
    Map<String ,String> body={
      "phoneNumber": phone,
      "name":name,
      "dob":dob,
      "pss":pass,
    };
      return await apiService.signUp(AppConstant.CREATE_NEW_USER, body,header);
  }
  
  Future<Response> checkToken(String token) async{
    Map<String,String> header ={
      "Authorization":"Bearer $token"
    };

    return await apiService.checkToken(AppConstant.CHECK_TOKEN, header);
  }
  
  Future<Response> signOut(String token) async{
    Map<String,String> header ={
      "Authorization":"Bearer $token"
    };
    Map<String,String> body = {};
    return await apiService.signUp(AppConstant.SIGNOUT,body,header);
  }

  

  /* ---------------------------- ./end Federated identity & social sign-in ---------------------------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SplashScreen());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      print(e.toString());
      // throw 'Unable to logout. Try again.';
    }
  }
}
