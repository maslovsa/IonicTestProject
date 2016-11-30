package com.rokolabs.rokomobi.analytics;

import android.util.Log;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.sdk.analytics.RokoLogger;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;

public class RMLoggerManager extends BasePlugin {
    private static final String ADD_EVENT = "addEvent";

    @Override
    public boolean execute(String action, final JSONArray data, final CallbackContext callbackContext) throws JSONException {
        if (ADD_EVENT.equals(action)) {
            cordova.getThreadPool().execute(new Runnable(){
                @Override
                public void run() {
                    try {
                        Event event = gson.fromJson(data.getJSONObject(0).toString(), Event.class);
                        RokoLogger.addEvents(new com.rokolabs.sdk.analytics.Event(event.name, event.params));
                        callbackContext.success();
                    } catch (JSONException ex){
                        callbackContext.error("Error parse json");
                    }
                }
            });
            return true;
        }
        return false;
    }
}
