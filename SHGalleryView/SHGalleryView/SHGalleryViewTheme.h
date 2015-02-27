//
//  SHMediaControlTheme.h
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/5/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHGalleryViewTheme : NSObject

// the background color of the gallery view
@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *pageControlCurrentDotColor;
@property (nonatomic, strong) UIColor *pageControlDotColor;
@property (nonatomic, strong) UIColor *pageControlBackgroundColor;

// following properties are for the media control

//caption title and time label attributes string attributes
@property (nonatomic, strong) NSDictionary *captionTitleAtributes;
@property (nonatomic, strong) NSDictionary *timeLabelAtributes;

//caption related colors

@property (nonatomic, strong) UIColor *captionBarBackgroundColor ;

//slider related colors
@property (nonatomic, strong) UIColor *sliderTrackColor ;
@property (nonatomic, strong) UIColor *sliderProgressColor ;

//button images
@property (nonatomic, strong) UIImage *playButtonImage ;
@property (nonatomic, strong) UIImage *pauseButtonImage ;
@property (nonatomic, strong) UIImage *doneButtonImage ;
@property (nonatomic, strong) UIImage *sliderThumbImage ;

//caption fonts

/**
 *  @deprecated this property is deprecated, Use `captionTitleAttributes` instead.
 */
@property (nonatomic, strong) UIColor *captionTitleColor DEPRECATED_ATTRIBUTE;

/**
 *  @deprecated this property is deprecated, Use `captionTitleAttributes` instead.
 */
@property (nonatomic, strong) UIFont *captionTitleFont DEPRECATED_ATTRIBUTE;

/**
 * @deprecated this property is deprecated, Use `timeLabelAtributes` instead.
 */
@property (nonatomic, strong) UIColor *timeLabelColor DEPRECATED_ATTRIBUTE;

/**
 *  @deprecated this property is deprecated, use `timeLabelAtributes` instead.
 */
@property (nonatomic, strong) UIFont *timeLabelFont DEPRECATED_ATTRIBUTE;

@end
