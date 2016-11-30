package com.rokolabs.rokomobi.base;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.rokolabs.sdk.RokoMobi;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONObject;

public abstract class BasePlugin extends CordovaPlugin {
    protected static Gson gson = new Gson();

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        RokoMobi.start(cordova.getActivity());
    }
}
