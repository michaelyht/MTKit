//
//  UIImage+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MTExt)

/**
 *   纯色图片
 */
+ (UIImage *)mt_imageWithColor:(UIColor *)color;

/**
 *  根据颜色返回一张图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 背景图片
 */
+ (UIImage *)mt_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据块画一张图片
 
 @param size      The image size.
 @param drawBlock The draw block.
 
 @return The new image.
 */
+ (UIImage *)mt_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

/**
 *  Get cropped image at specified frame.
 *
 *  @param rect The specified frame that you use to crop.
 *
 *  @return Cropped image
 */
- (UIImage *)mt_imageByCroppedToRect:(CGRect)rect;

#pragma mark - Modify Image

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)mt_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;


/**
 Draws the entire image in the specified rectangle, content changed with
 the contentMode.
 
 @discussion This method draws the entire image in the current graphics context,
 respecting the image's orientation setting. In the default coordinate system,
 images are situated down and to the right of the origin of the specified
 rectangle. This method respects any transforms applied to the current graphics
 context, however.
 
 @param rect        The rectangle in which to draw the image.
 
 @param contentMode Draw content mode
 
 @param clips       A Boolean value that determines whether content are confined to the rect.
 */
- (void)mt_drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips;

/**
 Returns a new image which is scaled from this image.
 The image will be stretched as needed.
 
 @param size  The new size to be scaled, values should be positive.
 
 @return      The new image with the given size.
 */
- (UIImage *)mt_imageByResizeToSize:(CGSize)size;

/**
 Returns a new image which is scaled from this image.
 The image content will be changed with thencontentMode.
 
 @param size        The new size to be scaled, values should be positive.
 
 @param contentMode The content mode for image content.
 
 @return The new image with the given size.
 */
- (UIImage *)mt_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/**
 Rounds a new image with a given corner size.
 
 @param radius  The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to half
 the width or height.
 */
- (UIImage *)mt_imageByRoundCornerRadius:(CGFloat)radius;

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 */
- (UIImage *)mt_imageByRoundCornerRadius:(CGFloat)radius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(nullable UIColor *)borderColor;

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param corners      A bitmask value that identifies the corners that you want
 rounded. You can use this parameter to round only a subset
 of the corners of the rectangle.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 
 @param borderLineJoin The border line join.
 */
- (UIImage *)mt_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(nullable UIColor *)borderColor
                          borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 Returns a new rotated image (relative to the center).
 
 @param radians   Rotated radians in counterclockwise.⟲
 
 @param fitSize   YES: new image's size is extend to fit all content.
 NO: image's size will not change, content may be clipped.
 */
- (UIImage *)mt_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

/**
 Returns a new image rotated counterclockwise by a quarter‑turn (90°). ⤺
 The width and height will be exchanged.
 */
- (UIImage *)mt_imageByRotateLeft90;

/**
 Returns a new image rotated clockwise by a quarter‑turn (90°). ⤼
 The width and height will be exchanged.
 */
- (UIImage *)mt_imageByRotateRight90;

/**
 Returns a new image rotated 180° . ↻
 */
- (UIImage *)mt_imageByRotate180;

/**
 Returns a vertically flipped image. ⥯
 */
- (UIImage *)mt_imageByFlipVertical;

/**
 Returns a horizontally flipped image. ⇋
 */
- (UIImage *)mt_imageByFlipHorizontal;

@end

NS_ASSUME_NONNULL_END
