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

// following properties are for the media control

//caption related colors
@property (nonatomic, strong) UIColor *captionTitleColor ;
@property (nonatomic, strong) UIColor *timeLabelColor ;
@property (nonatomic, strong) UIColor *captionBarBackgroundColor ;

//slider related colors
@property (nonatomic, strong) UIColor *sliderTrackColor ;
@property (nonatomic, strong) UIColor *sliderProgressColor ;

//caption fonts
@property (nonatomic, strong) UIFont *captionTitleFont ;
@property (nonatomic, strong) UIFont *timeLabelFont ;

//button images
@property (nonatomic, strong) UIImage *playButtonImage ;
@property (nonatomic, strong) UIImage *pauseButtonImage ;
@property (nonatomic, strong) UIImage *doneButtonImage ;
@property (nonatomic, strong) UIImage *sliderThumbImage ;

@end
