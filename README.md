## How to use this
- Please run `flutter pub get` to get all the packages
- Install JWT Auth - WordPress JSON Web Token Authentication plugin
- Modify wp-config on your WordPress file and add this line: <br> 
    `define( 'JWT_AUTH_SECRET_KEY', 'your-top-secret-key');`
- Please change apiUrl to your own url of wordpress link. To modify it go to lib/services/api_service.dart. 
- Run the app. It should work.
