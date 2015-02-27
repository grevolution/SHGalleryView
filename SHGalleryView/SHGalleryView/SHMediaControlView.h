//
//  SHMediaControlView.h
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/4/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, kPlayPauseButtonState){
	kPlayPauseButtonStatePlay = 1,
	kPlayPauseButtonStatePause = 2
};

typedef NS_ENUM(int, kViewSate) {
    kViewStateHidden     = 0,
    kViewStateVisible    = 1
};

@protocol SHMediaControlViewDelegate;
@class SHGalleryViewTheme;
@class SHMediaItem;

@interface SHMediaControlView : UIView

@property (nonatomic, weak) id<SHMediaControlViewDelegate> delegate;
@property (nonatomic, getter = isControlShowing) BOOL controlShowing;
@property (nonatomic, strong) SHGalleryViewTheme *theme;
@property (nonatomic) BOOL isDoneButtonForcedHidden;
@property (nonatomic) BOOL showPageControl;

- (void)toggleDoneButtonState:(NSArray *)args;
- (void)toggleMediaControlsState:(NSArray *)args;
- (void)toggleGalleryControlState:(NSArray *)args;
- (void)toggleAllControls:(NSArray *)args;

- (void)changePlayPauseButtonState:(kPlayPauseButtonState)state;

- (UISlider *)mediaControlSlider;
- (void)setTimeLabel:(NSString *)time;

- (void)updateCaptions:(SHMediaItem *)item;

@end

@protocol SHMediaControlViewDelegate <NSObject>

//video related callbacks
- (void)mediaControlPlay;
- (void)mediaControlPause;
- (void)mediaControlSeekBarValueChanged;
- (void)mediaControlDone;

@end
