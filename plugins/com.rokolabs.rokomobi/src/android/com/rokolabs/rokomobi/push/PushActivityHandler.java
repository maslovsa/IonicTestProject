package com.rokolabs.rokomobi.push;


import android.app.Activity;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

public class PushActivityHandler extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        boolean isPushPluginActive = PushPlugin.isActive();
        processPushBundle(isPushPluginActive);

        finish();

        if (!isPushPluginActive) {
            forceMainActivityReload();
        }
    }


    private void forceMainActivityReload() {
        PackageManager pm = getPackageManager();
        Intent launchIntent = pm.getLaunchIntentForPackage(getApplicationContext().getPackageName());
        startActivity(launchIntent);
    }

    @Override
    protected void onResume() {
        super.onResume();
        final NotificationManager notificationManager = (NotificationManager) this.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

    private void processPushBundle(boolean isPushPluginActive) {
        Bundle extras = getIntent().getExtras();

        if (extras != null) {
            PushPlugin.sendExtras(extras);
        }
    }
}
