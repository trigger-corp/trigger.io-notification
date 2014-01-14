module("forge.notification");

if (forge.is.ios()) {
	asyncTest("setBadgeNumber", 1, function () {
		forge.notification.setBadgeNumber(42, function () {
			forge.notification.getBadgeNumber(function (badge) {
				ok(badge === 42);
				forge.notification.setBadgeNumber(0);
				start();
			}, function () {
				ok(false);
				start();
			});
		}, function () {
			ok(false);
			start();
		});
	});
}
