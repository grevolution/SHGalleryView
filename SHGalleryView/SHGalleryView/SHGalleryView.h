//
//  SHGalleryView.h
//  SHGalleryView
//
//  Created by Shan Ul Haq on 9/3/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHGalleryViewControllerDataSource.h"
#import "SHGalleryViewControllerDelegate.h"

@class SHGalleryViewTheme;

static NSString *const kNotificationMediaPlay = @"kNotificationMediaPlay";
static NSString *const kNotificationMediaPause = @"kNotificationMediaPause";
static NSString *const kNotificationMediaStop = @"kNotificationMediaStop";
static NSString *const kNotificationMediaSliderValueChanged = @"kNotificationMediaSliderValueChanged";
static NSString *const kNotificationMediaDone = @"kNotificationMediaDone";

@interface SHGalleryView : UIView

/**
 *  data source for `SHGalleryViewController`
 */
@property (nonatomic, assign) id<SHGalleryViewControllerDataSource> dataSource;

/**
 *  delegate for `SHGalleryViewController`
 */
@property (nonatomic, assign) id<SHGalleryViewControllerDelegate> delegate;

/**
 *  theme for `SHGalleryViewController`.
 */
@property (nonatomic, strong) SHGalleryViewTheme *theme;

/**
 *  set this property if you want to show the UIPageControl at the bottom of your gallery view (overlayed).
 *  if this property is true, the caption bar of the gallery will be hidden.
 */
@property (nonatomic) BOOL showPageControl;

/**
 *  set this property to enable/disable the pinch/zoom functionality on images in the gallery view. by default NO.
 */
@property (nonatomic) BOOL disablePinchAndZoomOnImages;

/**
 *  hides the done button forcefully, set this to YES for the embedded views.
 */
@property (nonatomic) BOOL isDoneButtonForcedHidden;

/**
 *  call this method to reload your data source
 */
- (void)reloadData;

/**
 *  scrolls to a specific item specified
 *
 *  @param index the index to which you want to scroll.
 */
- (void)scrollToItemAtIndex:(int)index;

/**
 *  initialize the gallery view
 */
- (void)setupGalleryView;

@end
