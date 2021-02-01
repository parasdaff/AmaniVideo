//
//  IISightSDKManager.h
//  11Sight
//
//  Created by Berdikhan on 10/08/2017.
//  Copyright © 2017 11Sight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Intents/Intents.h>

@class IISightSDKManager;

/*!
    @brief Login delegate.
 */
@protocol IISightSDKLoginDelegate <NSObject>

-(void)loginSuccessful;
-(void)loginFailedWithErrorMessage:(NSString * _Nullable)errorMessage;

@end

/*!
    @brief Logout delegate.
 */
@protocol IISightSDKLogoutDelegate <NSObject>

-(void)logoutSuccessful;
-(void)logoutFailedWithErrorMessage:(NSString * _Nullable)errorMessage;

@end

/*!
 @brief State error delegate.
 */
@protocol IISightSDKStateErrorDelegate <NSObject>

-(void)stateErrorReceived:(NSString*_Nullable)reason;

@end

/*!
 @brief Incoming call received.
 */
@protocol IISightCallStatusDelegate <NSObject>

-(void)callReceived:(NSDictionary*_Nullable)call_data;
-(void)callAnswered:(NSDictionary*_Nullable)call_data;
-(void)callEstablished:(NSDictionary*_Nullable)call_data;
-(void)callEnded;
-(void)callFailed;

@end

typedef NS_ENUM (NSUInteger, IISightConnectionStatus) {
    Connected = 0,
    Connecting = 1,
    NotConnected = 2
};

typedef void (^ConnectionStatusChanged)(IISightConnectionStatus status);

typedef NS_ENUM (NSUInteger, IISightCallType) {
    Video = 0,
    Audio = 1,
    Chat = 2
};

@interface IISightSDKManager : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (IISightSDKManager*)sharedManager;

NS_ASSUME_NONNULL_END

/*!
    @brief Provide all the required credentials in order to use services.
    @param partnerUrl Partner Url.
 */
- (void) startWithPartnerUrl:( NSString* _Nonnull )partnerUrl;


/*!
    @brief Log in to 11Sight services.
    @param email Username or email.
    @param password Password.
 */
- (void)login_userWithEmail:(NSString* _Nonnull)email
                   password:(NSString* _Nonnull)password;


@property (weak, nonatomic) _Nullable id <IISightSDKLoginDelegate> loginDelegate;

/*!
    @brief Current connection status.
 */
@property (nonatomic, assign) IISightConnectionStatus currentConnectionStatus;

/*!
    @brief Get notified when there is a connection status change.
 */
@property (nonatomic, copy) ConnectionStatusChanged _Nullable connectionStatusChanged;


@property (weak, nonatomic) _Nullable id <IISightSDKStateErrorDelegate> stateErrorDelegate;

/*!
    @brief Get notified when call related updates happened
 */
@property (weak, nonatomic) _Nullable id <IISightCallStatusDelegate> callStatusDelegate;
/*!
    @brief Get notified when call received
 */
@property (weak, nonatomic) _Nullable id <IISightCallStatusDelegate> callReceived;

/*!
    @brief Get notified when call answered
 */
@property (weak, nonatomic) _Nullable id <IISightCallStatusDelegate> callAnswered;

/*!
    @brief Get notified when call established
 */
@property (weak, nonatomic) _Nullable id <IISightCallStatusDelegate> callEstablished;

/*!
    @brief Get notified when call ended
 */
@property (weak, nonatomic) _Nullable id <IISightCallStatusDelegate> callEnded;

/*!
    @brief Get notified when call failed
 */
@property (weak, nonatomic) _Nullable id <IISightCallStatusDelegate> callFailed;

/*!
    @brief Authorization status.
 */
@property (nonatomic) BOOL isLoggedIn;

/*!
 @brief Current user id. -1 for guest user.
 */
@property (nonatomic, readonly) NSInteger userId;


/*!
 @brief Enable debug mode.
 */
-(void) enableDebugMode:(BOOL)debugMode;

/*!
 @brief CallKit call screen app icon, if it is nil, app icon will be displayed.
 */
@property (strong, nonatomic) UIImage * _Nullable callkitImage;

/*!
    @brief Ringtone for incoming call, if it is nil, default sound will be played.
 */
@property (strong, nonatomic) NSString * _Nullable ringtone;

/*!
    @brief Initiate a call from app.
    @param buttonId ButtonId.
 */
- (void) startOutgoingCall:(NSString *_Nonnull)buttonId trackerId:(NSString *_Nullable)trackerId callType:(IISightCallType)callType;

/*!
    @brief Initiate a call from Intent (Recent calls)
    @param intent INIntent
 */

-(BOOL)startOutgoingCallFromIntent:(INIntent*)intent;

/*!
    @brief Log out from 11Sight services.
 */
- (void)logout_user;

@property (weak, nonatomic) _Nullable id  <IISightSDKLogoutDelegate> logoutDelegate;

/*
 *  Required methods of AppDelegate
 *
 *      In order to make Local notifications work, there are required UNUserNotificationCenterDelegate
 *  and AppDelegate functions need to be implemented.
 *
 *  iOS 10.0
 *  -(void)userNotificationCenter:(UNUserNotificationCenter *)center
 * didReceiveNotificationResponse:(UNNotificationResponse *)response
 *          withCompletionHandler:(void (^)())completionHandler
 *
 *  -(void)userNotificationCenter:(UNUserNotificationCenter *)center
 *       willPresentNotification:(UNNotification *)notification
 *          withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
 *
 *  iOS 8.0
 *  - (void)application:(UIApplication *)application
 *  didReceiveLocalNotification:(UILocalNotification *)notification
 *
 *  - (void)application:(UIApplication *)application
 *  handleActionWithIdentifier:(NSString *)identifier
 *  forLocalNotification:(UILocalNotification *)notification
 *  completionHandler:(void (^)())completionHandler
*/
/*!
    @brief Helper function to differentiate between App and 11Sight notification.
 */
- (BOOL)localNotificationBelongsToIISight:(NSString *_Nonnull)identifier content:(NSString *_Nullable)content;

- (void) stateErrorWithReason:(NSString*_Nullable)reason;

- (void) moveLogsToFileAndLoggly;

-(void) setApnsNormalToken:(NSString *_Nonnull)deviceToken;

- (void)remoteNotificationBelongsToIISight:(NSDictionary *_Nullable)payload;

@end
