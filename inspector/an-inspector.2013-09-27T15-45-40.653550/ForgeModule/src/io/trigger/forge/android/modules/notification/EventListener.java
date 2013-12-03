package io.trigger.forge.android.modules.notification;

import com.google.gson.JsonObject;

import android.content.Intent;
import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.core.ForgeEventListener;
import io.trigger.forge.android.core.ForgeTask;

public class EventListener extends ForgeEventListener {
	@Override
	public void onNewIntent(Intent intent) {
		if (intent != null && intent.hasExtra("io.trigger.forge.modules.notification")) {
			ForgeTask task = new ForgeTask(intent.getExtras().getString("io.trigger.forge.modules.notification"), new JsonObject(), ForgeApp.getActivity().webView);
			task.success();
		}
	}
}
