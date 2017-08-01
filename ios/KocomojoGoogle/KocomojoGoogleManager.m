//
//  KocomojoGoogleManager.m
//  EspyIt
//
//  Created by Elijah Windsor on 6/23/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "KocomojoGoogleManager.h"
#import "KocomojoGoogle.h"

@implementation KocomojoGoogleManager


RCT_EXPORT_MODULE();

// called from RN
RCT_EXPORT_METHOD(showLogin:(RCTResponseSenderBlock)callback) {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    [KocomojoGoogle loginWithGoogle:  [[UIApplication sharedApplication]delegate].window.rootViewController loginCallback:^(NSError * _Nullable error, NSDictionary * _Nullable data) {
      id errorMessage = [NSNull null];
      
      if(error != nil) {
        errorMessage = [error localizedDescription];
      }
      
      callback(@[errorMessage, data]);
    }];
  });
}

+ (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    return [KocomojoGoogle application:application openURL:url options:options];
}


@end
