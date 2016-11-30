package com.rokolabs.rokomobi.share;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.sdk.share.RokoShare;
import com.rokolabs.sdk.share.RokoShareChannelType;
import com.rokolabs.sdk.share.RokoShareViewController;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.text.TextUtils;

public class ShareManager extends BasePlugin {
    private static final String SHARE_WITH_UI = "shareWithUI";
    private static final String shareCompleteForChannel = "shareCompleteForChannel";

    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (SHARE_WITH_UI.equals(action)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    try {
                        ShareModel share = gson.fromJson(args.getJSONObject(0).toString(), ShareModel.class);
                        if(TextUtils.isEmpty(share.contentId)){
                            callbackContext.error("ContentId field should not be empty");
                        }
                        RokoShare rokoShare = new RokoShare(cordova.getActivity(), share.contentId);
                        rokoShare.text = share.text;
                        rokoShare.contentURL = share.contentURL;
                        rokoShare.contentId = share.contentId;
                        rokoShare.contentTitle = share.contentTitle;
                        rokoShare.linkId = share.linkId;
                        rokoShare.show(cordova.getActivity());
                    } catch (JSONException ex) {
                        callbackContext.error("Error json parse");
                    }
                }
            });
            return true;
        }
        if (shareCompleteForChannel.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        JSONObject obj = args.getJSONObject(0);
                        String contentId = obj.getString("contentId");
                        String channelType = obj.getString("channelType");
                        RokoShare share = new RokoShare(cordova.getActivity(), contentId);
                        share.shareCompleteForChannel(RokoShareChannelType.getByString(channelType));
                        callbackContext.success();
                    } catch (JSONException ex) {
                        callbackContext.error("Parse exception");
                    }
                }
            });

            return true;
        }
        return false;
    }
}
