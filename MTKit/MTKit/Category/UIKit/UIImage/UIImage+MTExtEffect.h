//
//  UIImage+MTExtEffect.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MTExtEffect)

/**
 Tint the image in alpha channel with the given color.
 
 @param color  The color.
 */
- (UIImage *)mt_imageByTintColor:(UIColor *)color;

/**
 Returns a grayscaled image.
 */
- (UIImage *)mt_imageByGrayscale;

/**
 Applies a blur effect to this image. Suitable for blur any content.
 */
- (UIImage *)mt_imageByBlurSoft;

/**
 Applies a blur effect to this image. Suitable for blur any content except pure white.
 (same as iOS Control Panel)
 */
- (UIImage *)mt_imageByBlurLight;

/**
 Applies a blur effect to this image. Suitable for displaying black text.
 (same as iOS Navigation Bar White)
 */
- (UIImage *)mt_imageByBlurExtraLight;

/**
 Applies a blur effect to this image. Suitable for displaying white text.
 (same as iOS Notification Center)
 */
- (UIImage *)mt_imageByBlurDark;

/**
 Applies a blur and tint color to this image.
 
 @param tintColor  The tint color.
 */
- (UIImage *)mt_imageByBlurWithTint:(UIColor *)tintColor;

/**
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
 the result of the blur and saturation operations. The
 alpha channel of this color determines how strong the
 tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
 Values less than 1.0 will desaturation the resulting image
 while values greater than 1.0 will have the opposite effect.
 0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
 defined by this mask.  This must be an image mask or it
 must meet the requirements of the mask parameter of
 CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
 enough memory).
 */
- (UIImage *)mt_imageByBlurRadius:(CGFloat)blurRadius
                        tintColor:(nullable UIColor *)tintColor
                         tintMode:(CGBlendMode)tintBlendMode
                       saturation:(CGFloat)saturation
                        maskImage:(nullable UIImage *)maskImage;

@end


NS_ASSUME_NONNULL_END
