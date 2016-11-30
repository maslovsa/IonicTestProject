# Cordova RokoMobi Plugin

Plugin allows to integrate with RokoMobi Portal

## Prerequisites

1) Install npm here - https://nodejs.org/en/
or run in console 

    $ curl https://npmjs.org/install.sh | sh

2) Install Cordova - 

    $ npm install -g cordova

## Using

Create a new Cordova Project

    $ cordova create hello com.example.helloapp Hello
    
Install the plugin

    $ cd hello
    $ cordova plugin add cordova-plugin-rokomobi
    

Edit `www/js/index.js` and add the following code inside `onDeviceReady`

```js
    var success = function(message) {
        alert("Success")
    }
    var failure = function(error) {
        alert("Error calling Roko Plugin" + error);
    }
    var dictionary = {userName: "username"}
    rokomobi.setUser(dictionary, success, failure);
```

Install iOS or Android platform

    cordova platform add ios
    cordova platform add android
    
Run the code
    cordova prepare
    cordova run 

## More Info

For more information about RokoMobi integration [the documentation](http://docs.roko.mobi/docs/cordova)
