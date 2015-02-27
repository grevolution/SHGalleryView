//
//  SHMediaControlView.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/4/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHMediaControlView.h"
#import "SHGalleryViewTheme.h"
#import "SHMediaItem.h"

#define TAG_PLAY 2324545
#define TAG_PAUSE 2333645

#define ANIMATION_DURATION 0.2

@interface SHMediaControlView()

//done button
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

//gallery control objects
@property (weak, nonatomic) IBOutlet UIView *viewGalleryControl;
@property (weak, nonatomic) IBOutlet UILabel *lblCaptionTitle;

//media control objects
@property (weak, nonatomic) IBOutlet UIView *viewMediaControl;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation SHMediaControlView {
    BOOL _doneShowing;
    BOOL _mediaShowing;
    BOOL _galleryShowing;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - NIB Initialization

- (void)setIsDoneButtonForcedHidden:(BOOL)isDoneButtonForcedHidden {
    _isDoneButtonForcedHidden = isDoneButtonForcedHidden;
    _btnDone.hidden = _isDoneButtonForcedHidden;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    [self applyDefaultValues];
    
}

- (void)applyDefaultValues {
    _btnPlay.tag = TAG_PLAY;
    _slider.value = 0.0;
    _slider.continuous = NO;
    _controlShowing = YES;
    _galleryShowing = YES;
    _mediaShowing = YES;
    _doneShowing = YES;
    
    [self applyThemeValues];
}

- (void)updateCaptions:(SHMediaItem *)item {
    if(_theme.captionTitleAtributes && item.captionTitle) {
        _lblCaptionTitle.attributedText = [[NSAttributedString alloc] initWithString:item.captionTitle attributes:_theme.captionTitleAtributes];
    } else {
        _lblCaptionTitle.text = item.captionTitle;
    }
    _viewGalleryControl.hidden = (item.captionTitle.length == 0) || _showPageControl;
}

#pragma mark - Theme methods

- (void)setTheme:(SHGalleryViewTheme *)theme {
    _theme = theme;
    [self applyThemeValues];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

- (void)applyThemeValues {
    _lblCaptionTitle.textColor = _theme.captionTitleColor;
    _lblCaptionTitle.font = _theme.captionTitleFont;
    
    _lblTime.textColor = _theme.timeLabelColor;
    _lblTime.font = _theme.timeLabelFont;
    
    if(_theme && _theme.timeLabelAtributes) {
        _lblTime.attributedText = [[NSAttributedString alloc] initWithString:@"00:00" attributes:_theme.timeLabelAtributes];
    } else {
        _lblTime.text = @"00:00";
    }
    
    _viewGalleryControl.backgroundColor = _theme.captionBarBackgroundColor;
    _viewMediaControl.backgroundColor = _theme.captionBarBackgroundColor;
    
    [_btnPlay setImage:_theme.playButtonImage forState:UIControlStateNormal];
    [_btnDone setImage:_theme.doneButtonImage forState:UIControlStateNormal];
    
    _slider.minimumTrackTintColor = _theme.sliderProgressColor;
    _slider.maximumTrackTintColor = _theme.sliderTrackColor;
    [_slider setThumbImage:_theme.sliderThumbImage forState:UIControlStateNormal];
}

#pragma GCC diagnostic pop


- (void)changePlayPauseButtonState:(kPlayPauseButtonState)state {
	if(state == kPlayPauseButtonStatePlay) {
		_btnPlay.tag = TAG_PLAY;
		[_btnPlay setImage:_theme.playButtonImage forState:UIControlStateNormal];
		
	} else {
		_btnPlay.tag = TAG_PAUSE;
		[_btnPlay setImage:_theme.pauseButtonImage forState:UIControlStateNormal];
	}
}

- (UISlider *)mediaControlSlider {
    return _slider;
}

- (void)setTimeLabel:(NSString *)time {
    if(_theme.timeLabelAtributes && time) {
        _lblTime.attributedText = [[NSAttributedString alloc] initWithString:time attributes:_theme.timeLabelAtributes];
    } else {
        _lblTime.text = time;
    }
}


#pragma mark - Visibility methods

- (void)toggleDoneButtonState:(NSArray *)args {
    if([[args firstObject] intValue] == kViewStateHidden) {
        if(_isDoneButtonForcedHidden){
            [self hideViewWithAlpha:_btnDone animated:NO];
        } else {
            [self hideViewWithAlpha:_btnDone animated:[[args lastObject] boolValue]];
        }
        _doneShowing = NO;
    } else {
        if(!_isDoneButtonForcedHidden) {
            [self showViewWithAlpha:_btnDone animated:[[args lastObject] boolValue]];
        }
        _doneShowing = YES;
    }
}

- (void)toggleMediaControlsState:(NSArray *)args {
    if([[args firstObject] intValue] == kViewStateHidden) {
        if(!_mediaShowing) {
            return;
        }
        [self hideViewWithAlpha:_btnPlay animated:[[args lastObject] boolValue]];
        [self hideViewWithAlpha:_viewMediaControl animated:[[args lastObject] boolValue]];
        _mediaShowing = NO;
    } else {
        if(_mediaShowing){
            return;
        }
        [self showViewWithAlpha:_btnPlay animated:[[args lastObject] boolValue]];
        [self showViewWithAlpha:_viewMediaControl animated:[[args lastObject] boolValue]];
        _mediaShowing = YES;
    }
}

- (void)toggleGalleryControlState:(NSArray *)args {
    if([[args firstObject] intValue] == kViewStateHidden) {
        if(!_galleryShowing){
            return;
        }
        if(_showPageControl){
            [self hideViewWithAlpha:_viewGalleryControl animated:NO];
        } else {
            [self hideViewWithAlpha:_viewGalleryControl animated:[[args lastObject] boolValue]];
        }

        _galleryShowing = NO;
    } else {
        if(_galleryShowing){
            return;
        }
        if(!_showPageControl) {
            [self showViewWithAlpha:_viewGalleryControl animated:[[args lastObject] boolValue]];
        }
        _galleryShowing = YES;
    }
}

- (void)toggleAllControls:(NSArray *)args {
    if([[args firstObject] intValue] == kViewStateHidden) {
        if(_doneShowing) {
            if(_isDoneButtonForcedHidden){
                [self hideViewWithAlpha:_btnDone animated:NO];
            } else {
                [self hideViewWithAlpha:_btnDone animated:[[args lastObject] boolValue]];
            }
        }
        if(_mediaShowing){
            [self hideViewWithAlpha:_btnPlay animated:[[args lastObject] boolValue]];
            [self hideViewWithAlpha:_viewMediaControl animated:[[args lastObject] boolValue]];
        }
        if(_galleryShowing){
            if(_showPageControl){
                [self hideViewWithAlpha:_viewGalleryControl animated:NO];
            } else {
                [self hideViewWithAlpha:_viewGalleryControl animated:[[args lastObject] boolValue]];
            }

        }
        _doneShowing = _mediaShowing = _galleryShowing = NO;
    } else {
        if(!_doneShowing){
            if(!_isDoneButtonForcedHidden) {
                [self showViewWithAlpha:_btnDone animated:[[args lastObject] boolValue]];
            }
        }
        
        if(!_mediaShowing){
            [self showViewWithAlpha:_btnPlay animated:[[args lastObject] boolValue]];
            [self showViewWithAlpha:_viewMediaControl animated:[[args lastObject] boolValue]];
        }
        
        if(!_galleryShowing){
            if(!_showPageControl){
                [self showViewWithAlpha:_viewGalleryControl animated:[[args lastObject] boolValue]];
            }
        }
        _doneShowing = _mediaShowing = _galleryShowing = YES;
    }
}

- (BOOL)isControlShowing {
    if(_doneShowing || _galleryShowing) {
        return YES;
    } else {
        return NO;
    }
}

- (void)hideViewWithAlpha:(UIView *)view animated:(BOOL)animated {
    if(animated) {
        view.hidden = NO;
        view.alpha = 1.0;
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
        }];
    } else {
        view.hidden = YES;
    }
}

- (void)showViewWithAlpha:(UIView *)view animated:(BOOL)animated {
    if(animated) {
        view.hidden = NO;
        view.alpha = 0;
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.alpha = 1.0;
        } completion:nil];
    } else {
        view.hidden = NO;
        view.alpha = 1.0;
    }
}


#pragma mark - IBActions

- (IBAction)doneButtonClicked:(id)sender {
    if(_delegate && [_delegate conformsToProtocol:@protocol(SHMediaControlViewDelegate)]) {
        [_delegate mediaControlDone];
    }
}

- (IBAction)playButtonClicked:(id)sender {
	UIButton *btn = (UIButton *)sender;
	if(btn == _btnPlay) {
		if(btn.tag == TAG_PLAY) {
			btn.tag = TAG_PAUSE;
            [_btnPlay setImage:_theme.pauseButtonImage forState:UIControlStateNormal];
            if(_delegate && [_delegate conformsToProtocol:@protocol(SHMediaControlViewDelegate)]) {
                [_delegate mediaControlPlay];
            }
		} else {
			btn.tag = TAG_PLAY;
            [_btnPlay setImage:_theme.playButtonImage forState:UIControlStateNormal];
            if(_delegate && [_delegate conformsToProtocol:@protocol(SHMediaControlViewDelegate)]) {
                [_delegate mediaControlPause];
            }
		}
	}
}

- (IBAction)sliderValueChanged:(id)sender {
    if(_delegate && [_delegate conformsToProtocol:@protocol(SHMediaControlViewDelegate)]) {
        [_delegate mediaControlSeekBarValueChanged];
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (!view.hidden && view.alpha > 0 && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}
@end
