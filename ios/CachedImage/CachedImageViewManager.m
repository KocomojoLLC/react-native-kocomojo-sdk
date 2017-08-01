//
//  CachedImageViewManager.m
//  EspyIt
//
//  Created by Elijah Windsor on 6/17/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "CachedImageViewManager.h"
#import "CachedImageView.h"
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>

@implementation CachedImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  return [[CachedImageView alloc]init];
}

RCT_EXPORT_VIEW_PROPERTY(blurRadius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(src, NSString)
RCT_REMAP_VIEW_PROPERTY(resizeMode, contentMode, RCTResizeMode)
RCT_EXPORT_VIEW_PROPERTY(onLoadEnd, RCTDirectEventBlock)

RCT_EXPORT_METHOD(loadImage:(nonnull NSNumber *)reactTag) {
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    
    UIView *view = viewRegistry[reactTag];
    
    if([view class] == [CachedImageView class]) {
      [((CachedImageView *)view) loadImage];
    }
  }];
}

@end
