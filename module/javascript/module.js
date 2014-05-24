forge['notification'] = {
	/**
	 * Create a standard un-customized notification.
	 *
	 * @param {string} title
	 * @param {string} text
	 * @param {function()=} success
	 * @param {function({message: string}=} error
	 */
	'create': function (title, text, success, error) {
		forge.internal.call("notification.create", {
			title: title,
			text: text
		}, success, error);
	},

	/**
	 * Set the badge number for the application icon.
	 * Setting the badge number to 0 removes the badge.
	 *
	 * @param {number} number
	 * @param {function()=} success
	 * @param {function({message: string}=} error
	 */
	'setBadgeNumber': function (number, success, error) {
		forge.internal.call("notification.setBadgeNumber", {
			number: number
		}, success, error);
	},

	/**
	 * Get the badge number for the application icon.
	 *
	 * @param {function(string)=} success
	 * @param {function({message: string}=} error
	 */
	'getBadgeNumber': function (success, error) {
		forge.internal.call("notification.getBadgeNumber", {}, success, error);
	},

	'alert': function (title, body, success, error) {
		forge.internal.call("notification.alert", {
			title: title,
			body: body
		}, success, error);
	},
	'confirm': function (title, body, positive, negative, success, error) {
		forge.internal.call("notification.confirm", {
			title: title,
			body: body,
			positive: positive,
			negative: negative
		}, success, error);
	},
	'prompt': function (title, body, success, error) {
		forge.internal.call("notification.prompt", {
			title: title,
			body: body
		}, success, error);
	},
	'toast': function (body, success, error) {
		forge.internal.call("notification.toast", {
			body: body
		}, success, error);
	},
	'showLoading': function (title, body, success, error) {
		forge.internal.call("notification.showLoading", {
			title: title,
			body: body
		}, success, error);
	},
	'hideLoading': function (success, error) {
		forge.internal.call("notification.hideLoading", {}, success, error);
	}
};
