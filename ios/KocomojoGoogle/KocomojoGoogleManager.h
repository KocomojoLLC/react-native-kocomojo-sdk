//
//  KocomojoGoogleManager.h
//  EspyIt
//
//  Created by Elijah Windsor on 6/28/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>

typedef void(^OauthBlock)(NSError * _Nullable error, NSDictionary * _Nullable data);

@interface KocomojoGoogleManager : NSObject <RCTBridgeModule>

+ (void)loginWithGoogle:(UIViewController *)viewController loginCallback:(OauthBlock _Nonnull)loginCallback;
+ (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
