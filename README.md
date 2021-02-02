# Amani Video SDK #

# Table of Content
- [Overview](#overview)
- [Basics](#basics)
    - [General Requirements](#general-requirements)
    - [Capability](#capability)
    - [Permissions](#permissions)
    - [Integration](#integration)
- [Installation](#Installation)
    - [Via CocoaPods](#via-cocoaPods)


# Overview

The Amani Software Development kit (SDK) is about the confirmation of kyc process.This sdk consists of 6 steps or screens:

## 1. Pre-Registration:   

This screen will ask you about your basic details like tcn id, name, phone number to confirm the kyc process.

## 2. OTP:

OTP(One Time Password) will come to your registred mobile number and you have to fill the same in otp screen.


## 3. Extra Information:

 In this it will ask you for 2 types of details account type and occupation.For selection of account type we have a seperate screen Select Account Type. Therein you have to fill your account type.

## 4. NFC:

So the next step is nfc.For this you have to enable nfc in your device and start scanning your card with nfc on this screen.If your device does not have nfc then an error screen will come after 3rd step which will ask you to visit the nearest branch to complete the kyc process.

## 5. Congratulation Screen:

After successful scanning of nfc you will see a congratulation screen asking "You completed all the steps We will call you in 48 hours".

## 6. Video Call:

Then a video call will be initiated to verify your identity.

# Basics

## General Requirements
The minimum requirements for the SDK are:  
* iOS 11.0 and higher  


## Capability

Enable the Near Field Communication Tag Reading, Push Notification and Background Modes capability in the target Signing & Capabilities.


### App permissions

Amani SDK makes use of the device Camera, Location and NFC. You will be required to have the following keys in your application's Info.plist file:

```xml
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
    <array>
        <string>A0000002471001</string>
    </array>
    <key>NFCReaderUsageDescription</key>
    <string>This application requires access to NFC to  scan IDs.</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This application requires access to your location to upload the document.</string>
    <key>NSLocationUsageDescription</key>
    <string>This application requires access to your location to upload the document.</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>This application requires access to your location to upload the document.</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This application requires access to your location to upload the document.</string>
    <key>NSCameraUsageDescription</key>
    <string>This application requires access to your camera for scanning and uploading the document.</string>
```
**Note**: All keys will be required for app submission.



## Integration

##### Example Usage

##### Swift

```swift

import UIKit
import AmaniVideo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    // Initialize SDK 
        let amaniSDK = AmaniSDK.sharedInstance
    // Configure SDK 
        amaniSDK.set(server: "SERVER_URL", userName: "USER_NAME", password: "PASSWORD")
    // Start SDK 
        amaniSDK.showSDK(overParent: self)
    }


}


```

# Installation

## Via CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your Podfile:

```ruby
use_frameworks!
  pod 'AmaniVideo', :git => 'https://github.com/pratuldawande/AmaniVideo.git'
```

Then, run the following command:

```bash
$ pod install
```
