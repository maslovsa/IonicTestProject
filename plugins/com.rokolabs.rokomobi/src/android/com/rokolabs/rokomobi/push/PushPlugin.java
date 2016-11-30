package com.rokolabs.rokomobi.push;

import android.app.NotificationManager;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.sdk.RokoMobi;
import com.rokolabs.sdk.push.RokoPush;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;

public class PushPlugin extends BasePlugin {
    private static CordovaWebView gWebView;
    private static Bundle gCachedExtras = null;
    private static boolean gForeground = false;

    public static void sendJavascript(JSONObject _json) {
        try {
            String script = "javascript:" + "onRecievePushNotification" + "(" + _json.getJSONObject("payload").toString() + ")";
            if (gWebView != null) {
                gWebView.sendJavascript(script);
            }
        } catch (JSONException ex){
            //TODO nothing
        }
    }

    public static void sendExtras(Bundle extras) {
        if (extras != null) {
            if (gWebView != null) {
                sendJavascript(convertBundleToJson(extras));
            } else {
                gCachedExtras = extras;
            }
        }
    }

    public static void init(String gcmSenderID, CordovaWebView webView) {
        RokoPush.start(gcmSenderID);
        gWebView = webView;
    }

    private static JSONObject convertBundleToJson(Bundle extras) {
        try {
            JSONObject json;
            json = new JSONObject().put("event", "message");

            JSONObject jsondata = new JSONObject();
            Iterator<String> it = extras.keySet().iterator();
            while (it.hasNext()) {
                String key = it.next();
                Object value = extras.get(key);

                // System data from Android
                if (key.equals("from") || key.equals("collapse_key")) {
                    json.put(key, value);
                } else if (key.equals("foreground")) {
                    json.put(key, extras.getBoolean("foreground"));
                } else if (key.equals("coldstart")) {
                    json.put(key, extras.getBoolean("coldstart"));
                } else {
                    // Maintain backwards compatibility
                    if (key.equals("message") || key.equals("msgcnt") || key.equals("soundname")) {
                        json.put(key, value);
                    }

                    if (value instanceof String) {
                        // Try to figure out if the value is another JSON object

                        String strValue = (String) value;
                        if (strValue.startsWith("{")) {
                            try {
                                JSONObject json2 = new JSONObject(strValue);
                                jsondata.put(key, json2);
                            } catch (Exception e) {
                                jsondata.put(key, value);
                            }
                            // Try to figure out if the value is another JSON array
                        } else if (strValue.startsWith("[")) {
                            try {
                                JSONArray json2 = new JSONArray(strValue);
                                jsondata.put(key, json2);
                            } catch (Exception e) {
                                jsondata.put(key, value);
                            }
                        } else {
                            jsondata.put(key, value);
                        }
                    }
                }
            } // while
            json.put("payload", jsondata);


            return json;
        } catch (JSONException e) {
        }
        return null;
    }

    public static boolean isInForeground() {
        return gForeground;
    }

    public static boolean isActive() {
        return gWebView != null;
    }



    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        gForeground = true;
    }

    @Override
    public void onPause(boolean multitasking) {
        super.onPause(multitasking);
        gForeground = false;
        final NotificationManager notificationManager = (NotificationManager) cordova.getActivity().getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
        gForeground = true;
    }
}
