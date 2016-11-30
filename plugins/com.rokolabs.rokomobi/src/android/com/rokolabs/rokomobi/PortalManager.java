package com.rokolabs.rokomobi;

import android.app.Activity;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.rokomobi.base.User;
import com.rokolabs.sdk.RokoMobi;
import com.rokolabs.sdk.account.RokoAccount;
import com.rokolabs.sdk.http.Response;
import com.rokolabs.sdk.http.ResponseCallback;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;


public class PortalManager extends BasePlugin {
    private static final String setUser = "setUser";
    private static final String getUserInfo = "getUserInfo";
    private static final String login = "login";
    private static final String logout = "logout";
    private static final String signupUser = "signupUser";
    private static final String getPortalInfo = "getPortalInfo";
    private static final String getSessionInfo = "getSessionInfo";
    private static final String setUserCustomProperty = "setUserCustomProperty";


    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (setUserCustomProperty.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        JSONObject obj = args.getJSONObject(0);
                        String key = obj.getString("propertyName");
                        String value = obj.getString("propertyValue");
                        if (RokoAccount.getLoginUser(RokoMobi.getInstance().getApplicationContext()).customProperties == null) {
                            RokoAccount.getLoginUser(RokoMobi.getInstance().getApplicationContext()).customProperties = new HashMap();
                        }
                        RokoAccount.setUserCustomProperty(key, value, new ResponseCallback() {    @Override
                            public void success(Response response) {
                                callbackContext.success(gson.toJson(response));
                            }
                            @Override
                            public void failure(Response response) {
                                callbackContext.error(gson.toJson(response));
                            }
                        });
                    } catch (JSONException e) {
                        callbackContext.error("Error parse json");
                    }
                }
            });
            return true;
        }
        if (setUser.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        User user = gson.fromJson(args.getJSONObject(0).toString(), User.class);
                        RokoAccount.setUser(RokoMobi.getInstance().getApplicationContext(), user.userName, user.referralCode, user.shareChannel, new ResponseCallback() {
                            @Override
                            public void success(Response response) {
                                try {
                                    callbackContext.success(new JSONObject(response.body));
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }
                            }

                            @Override
                            public void failure(Response response) {
                                callbackContext.error(gson.toJson(response));
                            }
                        });
                    } catch (JSONException ex) {
                        callbackContext.error("Error parse json");
                    }
                }
            });
            return true;
        }
        if (getUserInfo.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    com.rokolabs.sdk.account.model.User user = RokoAccount.getLoginUser(cordova.getActivity());
                    if (user != null) {
                        Map<String, Object> result = new HashMap<String, Object>();
                        result.put("createDate", user.createDate);
                        result.put("email", user.email);
                        result.put("firstLoginTime", user.firstLoginTime);
                        result.put("lastLoginTime", user.lastLoginTime);
                        result.put("phone", user.phone);
                        result.put("photoFile", user.photoFile);
                        result.put("referralCode", user.referralCode);
                        result.put("updateDate", user.updateDate);
                        result.put("username", user.username);
                        callbackContext.success(new JSONObject(result));
                    } else {
                        callbackContext.error("User is anonymous");
                    }
                }
            });
            return true;
        }
        if (login.equals(action)) {
            JSONObject obj = args.getJSONObject(0);
            String userName = obj.getString("userName");
            String password = obj.getString("password");
            RokoAccount.login(cordova.getActivity(), userName, password, new ResponseCallback() {
                @Override
                public void success(Response response) {
                    try {
                        callbackContext.success(new JSONObject(response.body));
                    } catch (JSONException e) {
                        callbackContext.error("Error parse json");
                    }
                }

                @Override
                public void failure(Response response) {
                    callbackContext.error(gson.toJson(response));
                }
            });
            return true;
        }
        if (logout.equals(action)) {

            RokoAccount.logout(cordova.getActivity(), new ResponseCallback() {
                @Override
                public void success(Response response) {
                    callbackContext.success();
                }

                @Override
                public void failure(Response response) {
                    callbackContext.error(gson.toJson(response));
                }
            });
            return true;
        }
        if (signupUser.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        JSONObject param = args.getJSONObject(0);
                        String userName = param.getString("userName");
                        String password = param.getString("password");
                        String email = param.getString("email");
                        String referralCode = null;
                        if (param.has("ambassadorCode")) {
                            referralCode = param.getString("ambassadorCode");
                        }
                        RokoAccount.register(userName, password, email, referralCode, new ResponseCallback() {
                            @Override
                            public void success(Response response) {
                                try {
                                    callbackContext.success(new JSONObject(response.body));
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }
                            }

                            @Override
                            public void failure(Response response) {
                                callbackContext.error(gson.toJson(response));
                            }
                        });
                    } catch (JSONException ex) {
                        callbackContext.error("Parse exception");
                    }
                }
            });
            return true;
        }
        if (getPortalInfo.equals(action)) {
            Map<String, String> res = new HashMap<String, String>();
            res.put("version", RokoMobi.getSettings().applicationVersion);
            res.put("applicationName", getName());
            callbackContext.success(new JSONObject(res));
            return true;
        }
        if (getSessionInfo.equals(action)) {
            Map<String, Object> res = new HashMap<String, Object>();
            res.put("sessionKey", RokoMobi.getSettings().getSessionId());
            com.rokolabs.sdk.account.model.User user = RokoAccount.getLoginUser(cordova.getActivity());
            Map<String, Object> resUser = new HashMap<String, Object>();
            resUser.put("createDate", user.createDate);
            resUser.put("email", user.email);
            resUser.put("firstLoginTime", user.firstLoginTime);
            resUser.put("lastLoginTime", user.lastLoginTime);
            resUser.put("phone", user.phone);
            resUser.put("photoFile", user.photoFile);
            resUser.put("referralCode", user.referralCode);
            resUser.put("updateDate", user.updateDate);
            resUser.put("username", user.username);
            res.put("user", resUser);
            callbackContext.success(new JSONObject(res));
            return true;
        }

        return false;
    }

    private String getName() {
        Activity activity = cordova.getActivity();
        final PackageManager pm = activity.getApplicationContext().getPackageManager();
        ApplicationInfo ai;
        try {
            ai = pm.getApplicationInfo(activity.getPackageName(), 0);
        } catch (final PackageManager.NameNotFoundException e) {
            ai = null;
        }
        final String applicationName = (String) (ai != null ? pm.getApplicationLabel(ai) : "(unknown)");
        return applicationName;
    }
}
