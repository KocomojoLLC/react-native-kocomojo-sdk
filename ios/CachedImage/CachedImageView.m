//
//  CachedImageView
//  EspyIt
//
//  Created by Elijah Windsor on 6/17/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "CachedImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>


@implementation CachedImageView

@synthesize onLoadEnd = _onLoadEnd;
@synthesize urlString = _urlString;
@synthesize blurRadius = _blurRadius;

UIImage *loadedImage = nil;

- (void)loadImage {
  [self sd_setImageWithURL:[NSURL URLWithString:self.urlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    loadedImage = image;

    if(_onLoadEnd) {
      _onLoadEnd(nil);
    }
    [self reloadImage];
    
  }];
}

- (void)setSrc:(NSString *)urlString {
  _urlString = urlString;
}

- (void)setBlurRadius:(CGFloat)blurRadius
{
  _blurRadius = blurRadius;
}

- (void)setOnLoadEnd:(RCTDirectEventBlock)onLoadEnd {
  _onLoadEnd = onLoadEnd;
}

-(void)reloadImage {
  __weak CachedImageView *selfRef = self;
  
  if(loadedImage) {
    if (_blurRadius > __FLT_EPSILON__) {
      // Blur on a background thread to avoid blocking interaction
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self blurredImageWithImage:loadedImage blurRadius:_blurRadius];
        dispatch_async(dispatch_get_main_queue(), ^{
          selfRef.image = image;
        });
      });
    }
  } else {
    self.image = nil;
  }
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
  if (self.contentMode != contentMode) {
    super.contentMode = contentMode;
  }
}

/**
 Taken from: http://stackoverflow.com/questions/28613713/blur-an-image-via-objective-c
 **/
- (UIImage *)blurredImageWithImage:(UIImage *)sourceImage blurRadius:(CGFloat)blurRadius {
  
  //  Create our blurred image
  CIContext *context = [CIContext contextWithOptions:nil];
  CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
  
  //  Setting up Gaussian Blur
  CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
  [filter setValue:inputImage forKey:kCIInputImageKey];
  [filter setValue:[NSNumber numberWithFloat:blurRadius] forKey:@"inputRadius"];
  CIImage *result = [filter valueForKey:kCIOutputImageKey];
  
  /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
   *  up exactly to the bounds of our original image */
  CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
  
  UIImage *retVal = [UIImage imageWithCGImage:cgImage];
  
  if (cgImage) {
    CGImageRelease(cgImage);
  }
  
  return retVal;
}

@end
