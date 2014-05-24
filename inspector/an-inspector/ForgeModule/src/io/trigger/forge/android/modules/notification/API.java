package io.trigger.forge.android.modules.notification;

import io.trigger.forge.android.core.ForgeActivity;
import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.core.ForgeParam;
import io.trigger.forge.android.core.ForgeTask;
import android.app.AlertDialog;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;
import android.widget.Toast;

public class API {
	private static ProgressDialog loading = null;

	public static void create(final ForgeTask task, @ForgeParam("title") final String title, @ForgeParam("text") final String text) {
		NotificationCompat.Builder notif = new NotificationCompat.Builder(ForgeApp.getActivity());
		notif.setSmallIcon(ForgeApp.getResourceId("icon", "drawable"));
		notif.setTicker(text);
		notif.setAutoCancel(true);

		Intent notifiIntent = new Intent(ForgeApp.getActivity(), ForgeActivity.class);
		notifiIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
		notifiIntent.putExtra("io.trigger.forge.modules.notification", task.callid);
		PendingIntent contentIntent = PendingIntent.getActivity(ForgeApp.getActivity(), 0, notifiIntent, 0);

		notif.setContentTitle(title);
		notif.setContentText(text);
		notif.setContentIntent(contentIntent);

		NotificationManager nm = (NotificationManager) ForgeApp.getActivity().getSystemService(Context.NOTIFICATION_SERVICE);
		nm.notify(1, notif.getNotification());
	}
	
	public static void alert(final ForgeTask task, @ForgeParam("title") final String title, @ForgeParam("body") final String body) {
		task.performUI(new Runnable() {
			@Override
			public void run() {
				AlertDialog.Builder alertBuilder = new AlertDialog.Builder(ForgeApp.getActivity());
				alertBuilder.setTitle(title);
				alertBuilder.setMessage(body);
				alertBuilder.setCancelable(false);
				alertBuilder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						task.success();
					}
				});
				
				alertBuilder.create().show();
			}
		});
	}

	public static void showLoading(final ForgeTask task, @ForgeParam("title") final String title, @ForgeParam("body") final String body) {
		task.performUI(new Runnable() {
			@Override
			public void run() {
				if (loading != null) {
					loading.setTitle(title);
					loading.setMessage(body);
				} else {
					loading = ProgressDialog.show(ForgeApp.getActivity(), title, body, true);
				}
				task.success();
			}
		});
	}

	public static void hideLoading(final ForgeTask task) {
		task.performUI(new Runnable() {
			@Override
			public void run() {
				if (loading != null) {
					loading.dismiss();
					loading = null;
				}
				task.success();
			}
		});
	}	
	
	public static void confirm(final ForgeTask task, @ForgeParam("title") final String title, @ForgeParam("body") final String body, @ForgeParam("positive") final String positive, @ForgeParam("negative") final String negative) {
		task.performUI(new Runnable() {
			@Override
			public void run() {
				AlertDialog.Builder alertBuilder = new AlertDialog.Builder(ForgeApp.getActivity());
				alertBuilder.setTitle(title);
				alertBuilder.setMessage(body);
				alertBuilder.setCancelable(false);
				alertBuilder.setPositiveButton(positive, new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						task.success(true);
					}
				});
				alertBuilder.setNegativeButton(negative, new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						task.success(false);
					}
				});

				alertBuilder.create().show();
			}
		});
	}

	public static void prompt(final ForgeTask task, @ForgeParam("title") final String title, @ForgeParam("body") final String body) {
		task.performUI(new Runnable() {
			@Override
			public void run() {
				AlertDialog.Builder alertBuilder = new AlertDialog.Builder(ForgeApp.getActivity());
				alertBuilder.setTitle(title);
				alertBuilder.setMessage(body);

				final EditText input = new EditText(this);
				alertBuilder.setView(input);

				alertBuilder.setCancelable(false);
				alertBuilder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						task.success(input.getText());
					}
				});

				alertBuilder.create().show();
			}
		});
	}

	public static void toast(final ForgeTask task, @ForgeParam("body") final String body) {
		task.performUI(new Runnable() {
			@Override
			public void run() {
				Toast.makeText(ForgeApp.getActivity(), body, Toast.LENGTH_SHORT).show();
				task.success();
			}
		});
	}
}
