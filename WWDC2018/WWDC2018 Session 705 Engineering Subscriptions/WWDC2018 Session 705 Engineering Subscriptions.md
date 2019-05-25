# WWDC2018 Session 705 Engineering Subscriptions - Implementaion Best Practices

## 1. Device and Server Architecture

### What is a subscription?
1. Receive Transaction
2. Verify Authenticity
	- App Store Receipt:
		
		It's a trusted record of App and In-App purchases, stored on device, issued by the App Store.
		It's for your app, on that device only.

	- Receipt Validation:
		
		On-device vs Server-to-server
		
		- __NOT__ Use online validation directly from the device.
		- Request from Apple
		- Send binary receipt data to my own server.
		- The server send it to Apple Server to get it verified or not.


3. Update Subscription Status

	__orignal_transaction_id -> user’s subscription ID__
	
	Does user have active subscription?
	1. Filter transactions by orignal_transaction_id
	2. Find the transaction with latest expires_date (sort transactions by expires_date)
	3. Date in the past shows user not active subscribed.
	4. Date in future shows user active

	Status Polling
	Discover new transactions directly from your server.
		
		- Save latest version of encoded receipt data on your serer(latestReceiptData, exclude-old-transactions: true)
		- Treat receipt data like a token
		- /verifyReceipt response also includes new transactions
		- Located in the latest_receipt_info field
		- Unlock new subscription periods without waiting for app to launch
		
		New transactions will still appear in StoreKit on next app launch
		- Must verify and finish these transactions
		- Even if your server already knows about them
		- Opportunity to update latest receipt data on server

	Reacting to Billing Issues

		1. Observe no renewal transaction appears 
		2. Direct user to amend their billing details
		3. Unblock user immediately when transaction occurs
			1.1 Server-to-Server Notification
				1.1.1 Status URL in App Store Connect 
				1.1.2 HTTPS POST to your server for status changes 
				1.1.3 Includes latest_transaction_info for the transaction in question (support ATS)




## 2. In-App Experience
1. Creating User Accounts
2. Introductory Pricing
3. Upgrade/Downgrade Subscriptions
4. Subscription Management

## 3. Reducing Subscriber Churn

Problem: 
1. Involuntary churn
2. Voluntary churn
3. Winback

Solution:
1. Leverage subscription specific receipt fields 
2. Implement status polling
3. Implement customer messaging
4. Present contextual subscription offers 

## 4. Analytics and Reporting

## Summary 
- Server side state management offers more flexibility
- Use notifications from the App Store
- Offer introductory pricing
- Reduce churn with simple messaging
- Win back users with alternative subscription options
- New reporting tools in App Store Connect