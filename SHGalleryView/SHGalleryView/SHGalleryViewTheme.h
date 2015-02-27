//
//  SHMediaControlTheme.h
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/5/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  `SHGalleryViewTheme` class is used to beauity and modify the look and feel of the `SHGalleryViewController`.
 *  create and instance of `SHGalleryViewTheme` and pass it to the gallery view.
 */
@interface SHGalleryViewTheme : NSObject

/**
 *  set the background of gallery view
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  set the page control's currently selected dot color. (if you have set YES to showPageControl property of `SHGalleryViewController`)
 */
@property (nonatomic, strong) UIColor *pageControlCurrentDotColor;
/**
 *  set the page control's normal dot color.
 */
@property (nonatomic, strong) UIColor *pageControlDotColor;

/**
 *  set the page control's backgound color
 */
@property (nonatomic, strong) UIColor *pageControlBackgroundColor;


// following properties are for the media control

/**
 *  media item's caption attributes for NSAttributedString
 */
@property (nonatomic, strong) NSDictionary *captionTitleAtributes;

/**
 *  media items's time label (for mediaItem type kMediaTypeVideo) attributes for NSAttributedString
 */
@property (nonatomic, strong) NSDictionary *timeLabelAtributes;

//caption related colors

/**
 *  background color of the caption bar
 */
@property (nonatomic, strong) UIColor *captionBarBackgroundColor;

//slider related colors

/**
 *  slider/time bar track color (media type kMediaTypeVideo)
 */
@property (nonatomic, strong) UIColor *sliderTrackColor ;

/**
 *  slider/time bar progress color (media type kMediaTypeVideo)
 */
@property (nonatomic, strong) UIColor *sliderProgressColor ;

/**
 *  slider thumb image
 */
@property (nonatomic, strong) UIImage *sliderThumbImage ;


//button images

/**
 *  play button image
 */
@property (nonatomic, strong) UIImage *playButtonImage ;

/**
 *  pause button image
 */
@property (nonatomic, strong) UIImage *pauseButtonImage ;

/**
 *  done button image
 */
@property (nonatomic, strong) UIImage *doneButtonImage ;


////// Deprecated Items /////////

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
