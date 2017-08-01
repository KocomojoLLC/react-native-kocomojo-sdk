//
//  CachedImagePrefetcher.m
//  EspyIt
//
//  Created by Elijah Windsor on 3/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "CachedImagePrefetcher.h"
#import <SDWebImage/SDWebImageManager.h>



@implementation CachedImagePrefetcher

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(prefetch:(NSString *)urlString callback:(RCTResponseSenderBlock)callback) {
  NSURL *url = [NSURL URLWithString:urlString];
  
  [SDWebImageManager.sharedManager downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    NSObject *errorObj = error == nil ? [NSNull null] : error;
    
    callback(@[errorObj, @{@"finished":[NSNumber numberWithBool:finished]}]);
  }];
}

@end
