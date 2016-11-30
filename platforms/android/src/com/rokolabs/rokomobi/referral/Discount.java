package com.rokolabs.rokomobi.referral;

import com.rokolabs.sdk.referrals.ResponseDiscount;

public class Discount {
    public boolean active;
    public String name;
    public ResponseDiscount.Data.Discount recipientDiscount;
    public ResponseDiscount.Data.Discount rewardDiscount;
    public ResponseDiscount.Data.User user;
}
