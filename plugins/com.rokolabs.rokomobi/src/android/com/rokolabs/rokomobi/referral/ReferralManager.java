package com.rokolabs.rokomobi.referral;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.sdk.base.BaseResponse;
import com.rokolabs.sdk.referrals.ResponseActivatedDiscountsList;
import com.rokolabs.sdk.referrals.ResponseCompletedDiscount;
import com.rokolabs.sdk.referrals.ResponseDiscount;
import com.rokolabs.sdk.referrals.RokoReferrals;
import com.rokolabs.sdk.referrals.invite.RokoInviteFriends;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReferralManager extends BasePlugin {
    private static final String loadReferralDiscountsList = "loadReferralDiscountsList";
    private static final String markReferralDiscountAsUsed = "markReferralDiscountAsUsed";
    private static final String loadDiscountInfoWithCode = "loadDiscountInfoWithCode";
    private static final String activateDiscountWithCode = "activateDiscountWithCode";
    private static final String completeDiscountWithCode = "completeDiscountWithCode";
    private static final String inviteFriends = "inviteFriends";

    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (loadReferralDiscountsList.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    RokoReferrals.loadReferralDiscountsList(new RokoReferrals.OnLoadReferralDiscountsList() {
                        @Override
                        public void success(ResponseActivatedDiscountsList responseActivatedDiscountsList) {
                            List<ResponseActivatedDiscount> resp = new ArrayList<ResponseActivatedDiscount>();
                            for (ResponseActivatedDiscountsList.Data item : responseActivatedDiscountsList.data) {
                                ResponseActivatedDiscount respItem = new ResponseActivatedDiscount();
                                respItem.id = item.objectId;
                                respItem.canBeUsed = item.canBeUsed;
                                respItem.createDate = item.createDate;
                                respItem.limit = item.limit;
                                respItem.type = item.type;
                                resp.add(respItem);
                            }
                            callbackContext.success(gson.toJson(resp));
                        }

                        @Override
                        public void failure(String s) {
                            callbackContext.error(s);
                        }
                    });
                }
            });

            return true;
        }
        if (markReferralDiscountAsUsed.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        Long code = args.getLong(0);
                        if (code != null) {
                            RokoReferrals.markReferralDiscountAsUsed(code, new RokoReferrals.OnMarkReferralDiscountAsUsed() {
                                @Override
                                public void success(BaseResponse baseResponse) {
                                    callbackContext.success();
                                }

                                @Override
                                public void failure(String s) {
                                    callbackContext.error("Code not found");
                                }
                            });
                        } else {
                            callbackContext.error("Code are empty");
                        }
                    } catch (JSONException ex) {
                        callbackContext.error("Parse error");
                    }
                }
            });
            return true;
        }
        if (loadDiscountInfoWithCode.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        String code = args.getString(0);
                        RokoReferrals.loadDiscountInfoWithCode(code, new RokoReferrals.OnLoadDiscountInfoWithCode() {
                            @Override
                            public void success(ResponseDiscount responseDiscount) {
                                Discount discount = new Discount();
                                discount.active = responseDiscount.data.isIncentiveActive;
                                discount.name = responseDiscount.data.incentiveName;
                                discount.recipientDiscount = responseDiscount.data.recipientDiscount;
                                discount.rewardDiscount = responseDiscount.data.referralDiscount;
                                discount.user = responseDiscount.data.referrerUser;
                                callbackContext.success(gson.toJson(discount));
                            }

                            @Override
                            public void failure(String s) {
                                callbackContext.error(s);
                            }
                        });
                    } catch (JSONException ex) {
                        callbackContext.error("Parse error");
                    }
                }
            });
            return true;
        }
        if (activateDiscountWithCode.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        String code = args.getString(0);
                        RokoReferrals.activateDiscountWithCode(code, new RokoReferrals.OnActivateDiscountWithCode() {
                            @Override
                            public void success(com.rokolabs.sdk.referrals.ResponseActivatedDiscount responseActivatedDiscount) {
                                callbackContext.success(String.valueOf(responseActivatedDiscount.data.discount.objectId));
                            }

                            @Override
                            public void failure(String s) {
                                callbackContext.error(s);
                            }
                        });
                    } catch (JSONException ex) {
                        callbackContext.error("Parse error");
                    }
                }
            });
            return true;
        }
        if (completeDiscountWithCode.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        String code = args.getString(0);
                        RokoReferrals.completeDiscountWithCode(code, new RokoReferrals.OnCompleteDiscountWithCode() {
                            @Override
                            public void success(ResponseCompletedDiscount responseCompletedDiscount) {
                                Map<String, String> result = new HashMap<String, String>();
                                result.put("discountId", String.valueOf(responseCompletedDiscount.data.discount.objectId));
                                result.put("referralId", String.valueOf(responseCompletedDiscount.data.referrerUser.objectId));
                                callbackContext.success(new JSONObject(result));
                            }

                            @Override
                            public void failure(String s) {
                                callbackContext.error(s);
                            }
                        });
                    } catch (JSONException ex) {
                        callbackContext.error("Parse erorr");
                    }
                }
            });
            return true;
        }
        if (inviteFriends.equals(action)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    RokoInviteFriends.show(cordova.getActivity());
                }
            });
            return true;
        }
        return false;
    }
}
