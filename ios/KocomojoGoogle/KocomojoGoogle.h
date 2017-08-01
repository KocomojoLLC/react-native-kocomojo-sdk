//
//  KocomojoGoogle_iOS.h
//  KocomojoGoogle-iOS
//
//  Created by Elijah Windsor on 7/27/17.
//  Copyright © 2017 Kocomojo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^OauthBlock)(NSError * _Nullable error, NSDictionary * _Nullable data);

@interface KocomojoGoogle : NSObject

+ (void)loginWithGoogle:(UIViewController *_Nonnull)viewController loginCallback:(OauthBlock _Nonnull )loginCallback;
+ (BOOL)application:(UIApplication *_Nonnull)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
