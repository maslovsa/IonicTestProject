

# Steps to create

```bash
$ ionic start IonicTestProject sidemenu -i com.rokolabs.cordova.test
$ cd IonicTestProject
$ ionic build ios
$ ionic build android
$ ionic emulate ios
$ ionic resources
$ cordova plugin add cordova-plugin-rokomobi
```

# Credentials

* You can change it on platforms/ios/IonictestProject/IonicTestProject-Info.plist

```javascript
baseURL: "api.roko.mobi/v1/",
apiToken: "bU6QiXzSjqgjvUT/J7akrxz78mxuzksdYulHFGMPp5o="
```

# Configuring Android project

* Add
```xml
<meta-data android:name="ROKOMobiAPIToken" android:value="bU6QiXzSjqgjvUT/J7akrxz78mxuzksdYulHFGMPp5o="/>
```
inside ***application*** tag at **platforms/android/AndroidManifest.xml**

* Replace **platforms/android/src/com/rokolabs/cordova/test/MainActivity.java** with following snippet:
```java
package com.rokolabs.cordova.test;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;

import org.apache.cordova.CordovaActivity;

public class MainActivity extends CordovaActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (this.checkCallingOrSelfPermission("android.permission.READ_PHONE_STATE") == PackageManager.PERMISSION_DENIED
                && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (this instanceof Activity) {
                String[] permissions = {
                        "android.permission.READ_PHONE_STATE"
                };
                ActivityCompat.requestPermissions(this, permissions, 1);
            }
        }

        Bundle extras = getIntent().getExtras();
        if (extras != null && extras.getBoolean("cdvStartInBackground", false)) {
            moveTaskToBack(true);
        }

        com.rokolabs.sdk.RokoMobi.start(this);
        loadUrl(launchUrl);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        com.rokolabs.rokomobi.push.PushPlugin.init("1012112689425", appView);
    }
}

```

# Adding setUser

* Replace function **doLogin** at ***www/js/controllers.js*** with following snippet:

```javascript
$scope.doLogin = function() {
  console.log('Doing login', $scope.loginData);

  var success = function(){
  alert("OK");
  };
  var failure = function(message){
  alert("Error calling plugin "+message);
  };

  rokomobi.setUser({userName: $scope.loginData.username},success,failure);

  // Simulate a login delay. Remove this and replace with your login
  // code if using a login system
  $timeout(function() {
    $scope.closeLogin();
  }, 1000);
};
```

# Link to portal app

https://portal.roko.mobi/devCompany-23400/application-645595/settings/apps/645595


# Usage

* Menu -> Login -> Input any user name -> Press Login
