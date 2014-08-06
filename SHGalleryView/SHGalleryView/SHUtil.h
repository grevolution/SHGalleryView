//
//  Util.h
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/5/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHUtil : NSObject

+ (UIView *)viewFromNib:(NSString *)nibName bundle:(NSBundle *)bundle;
+ (void)constrainViewEqual:(UIView *)view toParent:(UIView *)parent;

@end
