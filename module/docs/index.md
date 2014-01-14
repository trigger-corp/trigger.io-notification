``notification``: Notifications
===============================

The ``forge.notification`` namespace allows you to alert the user through various channels while the app is the foreground.

> ::Note:: to push notifications to users even if the app is not in focus, you can use the [parse module](/modules/parse/current/docs/index.html).

##API

!method: forge.notification.create(title, text, success, error)
!param: title `string` title
!param: text `string` notification message
!param: success `function()` called when the user taps on the notification in the statusbar, or dismisses the alert
!description: On Android, add a notification to the device's status bar: when it's tapped, the success callback is invoked. On iOS, a native alert-style popup is shown, and your success callback is invoked when it is cleared.
!platforms: iOS, Android
!param: error `function(content)` called with details of any error which may occur

!method: forge.notification.setBadgeNumber(number, success, error)
!param: number `integer` number
!param: success `function()` callback to be invoked when no errors occur
!description: Allows you to set or remove a badge for your app's icon on the iOS home screen.
!platforms: iOS
!param: error `function(content)` called with details of any error which may occur

> ::Note:: If you pass in 0 as number, it will remove this badge. This is
particularly useful if you want to clear a badge set by a push
notification.

![Badge number](badge_screenshot.png)

!method: forge.notification.getBadgeNumber(success, error)
!param: success `function(integer)` callback to be invoked when no errors occur (argument is the current badge number)
!description: Allows you to get the badge number for your app's icon on the iOS home screen.
!platforms: iOS
!param: error `function(content)` called with details of any error which may occur

!method: forge.notification.alert(title, text, success, error)
!param: title `string` title
!param: text `string` notification message
!param: success `function()` called when the user dismisses the alert
!description: Show a dialog window with text content that the user can dismiss. Similar to using ``window.alert`` except you can control the title text for the dialog.
!platforms: iOS, Android
!param: error `function(content)` called with details of any error which may occur

![Native alert dialog](notification_alert_screenshot.png)

!method: forge.notification.confirm(title, body, positive, negative, success, error)
!param: title `string` text to show as the title of the dialog
!param: body `string` text to show as the body of the dialog
!param: positive `string` text to use for the positive action button
!param: negative `string` text to use for the negative action button
!param: success `function(result)` called with ``true`` if the user selected the positive option, ``false`` if they selected the negative option
!description: Show a dialog window prompting the user with a "yes"/"no" style question.
!platforms: iOS, Android
!param: error `function(content)` called with details of any error which may occur

**Example**:

![Native confirm dialog](notification_confirm_screenshot.png)

    forge.notification.confirm("My Title: Confirm", "My Body: Confirm", "Y", "N", 
		function (userClickedYes) {
	      if (userClickedYes) {
	        // ... implement logic for when user clicked "Y"
	      } else {
	        // ... implement logic for when user clicked "N"
	      }
    });


!method: forge.notification.toast(body, success, error)
!param: body `string` text to show as the body of the dialog
!param: success `function()` called if the toast is displayed successfully
!description: Create a small popup which disappears after a few seconds.
!platforms: iOS, Android
!param: error `function(content)` called with details of any error which may occur

![Native toast](notification_toast_screenshot.png)

!method: forge.notification.showLoading(title, body, success, error)
!param: title `string` loading dialog title
!param: body `string` text to show as the body of the dialog
!param: success `function()` called if the loading dialog is displayed successfully
!param: error `function(content)` called with details of any error which may occur
!description: Show a loading spinner in front of the webview, must be hidden with `forge.notification.hideLoading()`. Repeated calls to showLoading will update the title and body on the shown loading dialog.
!platforms: iOS, Android

!method: forge.notification.hideLoading(success, error)
!param: success `function()` called if the loading dialog is hidden successfully
!param: error `function(content)` called with details of any error which may occur
!description: Hide any loading dialog shown with `forge.notification.showLoading()`.
!platforms: iOS, Android

##Permissions

On Android this module will add the ``VIBRATE`` permission.
