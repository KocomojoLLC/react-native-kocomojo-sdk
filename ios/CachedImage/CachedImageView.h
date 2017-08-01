//
//  CachedImageView
//  EspyIt
//
//  Created by Elijah Windsor on 6/17/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface CachedImageView : UIImageView

@property (nonatomic, copy) RCTDirectEventBlock onLoadEnd;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic) CGFloat blurRadius;

- (void)loadImage;

@end
