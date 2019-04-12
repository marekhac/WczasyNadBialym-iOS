# WczasyNadBialym (iOS App)

This is a development version of the iOS Mobile App for travelers. It will be particulary useful for tourists who wants to visit one of the greatest Lake in Poland (White Lake in Okuninka). 

This is universal App and it should look "pretty" both on iPad and iPhone.

Technologies used: **Swift 4, Auto Layout, Size Classes, Codable Protocol (JSON parsing)**

Checkout WczasyNadBialym website available at [wczasynadbialym.pl](http://wczasynadbialym.pl)

*For more details scroll down below these lovely screenshots :)*

![Accommodation](Docs/Images/accommodation.png)

**Requirements**

- Xcode 9 or newer
- iPhone or iPad device with iOS 9 or newer
- Special AppID token (can be generated [here](http://wczasynadbialym.pl/index/appid-request) for free)
	
**Create AppID token**

Request for free `AppID` token to be able to get any responces from WczasyNadBialymAPI. It's free. Just fill the form at the following [page](http://wczasynadbialym.pl/index/appid-request). Your `AppID` will be generated automatically.

**Before first run**

- Using Terminal go to the project folder, in which you already cloned the repo. 
- Install cocoapod packages

	```$ pod install```
	
- Open `WczasyNadBialym.xcworkspace` file in Xcode 
- Go to `Build Settings`, then scroll down to `User-Defined` section and find `app_id` key.

- Fill `app_id` key, with the value of your `AppId` token 

	![Accommodation](Docs/Images/appid_token.png)

**Run schemes**

* Production - use production version of WczasyNadBialymAPI
* Development - use development (local) version of WczasyNadBialymAPI

**Build configurations**

* DebugOn - print a lot of useful debug and error logs
* DebugOff - hide all debug and error logs





