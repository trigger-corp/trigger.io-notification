module("forge.notification");

asyncTest("Simple notification", 1, function() {
    forge.notification.create("†î†lé", "message content", function () {
        askQuestion("Did you see a notification with title '†î†lé' and message 'message content'?", {
            Yes: function () {
                ok(true, "Success");
                start();
            },
            No: function () {
                ok(false, "User claims failure");
                start();
            }
        });
    }, function (e) {
        ok(false, "API call failure: "+e.message);
        start();
    });
});


if (forge.is.ios()) {
    asyncTest("Set badge number", 1, function () {
        forge.notification.setBadgeNumber(7, function () {
            askQuestion("Does the icon for this app have a badge with the number 7 on it? (You'll need to go to the iOS home screen to see this)", {
                Yes: function () {
                    ok(true, "Success");
                    start();
                },
                No: function () {
                    ok(false, "User claims failure");
                    start();
                }
            });
        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });

    asyncTest("Remove badge", 1, function () {
        forge.notification.setBadgeNumber(0, function () {
            askQuestion("Does the icon for this app no longer have a badge on it? (You'll need to go to the iOS home screen to see this)", {
                Yes: function () {
                    ok(true, "Success");
                    start();
                },
                No: function () {
                    ok(false, "User claims failure");
                    start();
                }
            });
        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });
}

if (forge.is.mobile()) {
    asyncTest("alert", 1, function () {
        forge.notification.alert("†î†lé", "Body", function () {
            askQuestion("Did you see an alert with '†î†lé' and 'Body'?", {
                Yes: function () {
                    ok(true, "Success");
                    start();
                },
                No: function () {
                    ok(false, "User claims failure");
                    start();
                }
            });
        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });

    asyncTest("confirm", 1, function () {
        forge.notification.confirm("†î†lé", "Choose yes", "Yes", "No", function (result) {
            askQuestion("Did you see a confirm with '†î†lé' and 'Choose yes'?", {
                Yes: function () {
                    ok(result, "Result value");
                    start();
                },
                No: function () {
                    ok(false, "User claims failure");
                    start();
                }
            });
        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });

    asyncTest("toast", 1, function () {
        forge.notification.toast("†és† toast", function () {
            askQuestion("Did you see a toast '†és† toast'?", {
                Yes: function () {
                    ok(true, "Success");
                    start();
                },
                No: function () {
                    ok(false, "User claims failure");
                    start();
                }
            });
        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });

    asyncTest("toast - long", 1, function () {
        forge.notification.toast("Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\n\nAenean ut mauris tortor. In fermentum, lectus eu facilisis dignissim, metus elit porttitor neque, dignissim adipiscing libero massa ac velit. Nullam nec dui est. Quisque blandit, urna ut vulputate sagittis, tellus odio sollicitudin turpis, in laoreet elit justo id nisi. Ut venenatis varius libero sed interdum. In eget lectus vitae lacus malesuada tempus a in dui. Nunc iaculis mattis erat ac faucibus. Donec non aliquam tellus, nec scelerisque nibh.", function () {
            askQuestion("Did you see a long toast that wrapped correctly?", {
                Yes: function () {
                    ok(true, "Success");
                    start();
                },
                No: function () {
                    ok(false, "User claims failure");
                    start();
                }
            });
        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });

    asyncTest("loading", 1, function () {
        forge.notification.showLoading("†és†", "Loading message", function () {
            setTimeout(function () {
                forge.notification.showLoading("†és†", "Changing message");
            }, 1000);
            setTimeout(function () {
                forge.notification.showLoading("†és†", "And again");
            }, 2000);
            setTimeout(function () {
                forge.notification.hideLoading(function () {
                    askQuestion("Did you see a loading message (that changed twice) for 3 seconds?", {
                        Yes: function () {
                            ok(true, "Success");
                            start();
                        },
                        No: function () {
                            ok(false, "User claims failure");
                            start();
                        }
                    });
                });
            }, 3000);

        }, function (e) {
            ok(false, "API call failure: "+e.message);
            start();
        });
    });
}
