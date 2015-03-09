//
//  SHVideoMediaItemViewController.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/5/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHVideoMediaItemViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SHMediaControlView.h"
#import "SHUtil.h"
#import "SHMediaItem.h"
#import <UIImageView+AFNetworking.h>
#import "SHGalleryViewControllerChild.h"
#import "SHGalleryView.h"

@interface SHVideoMediaItemViewController () <SHGalleryViewControllerChild>

@property (nonatomic, strong) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (nonatomic) NSTimeInterval totalVideoTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgThumbnail;

@end

@implementation SHVideoMediaItemViewController

@synthesize mediaItem;
@synthesize pageIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    _player = [[MPMoviePlayerController alloc] init];
    _player.fullscreen = NO;
    _player.controlStyle = MPMovieControlStyleNone;
    _player.contentURL = [NSURL URLWithString:self.mediaItem.resourcePath];
    [self.view addSubview:_player.view];
    [SHUtil constrainViewEqual:_player.view toParent:self.view];

    [_imgThumbnail setImageWithURL:[NSURL URLWithString:self.mediaItem.mediaThumbnailImagePath]];
    [self.view bringSubviewToFront:_imgThumbnail];
}

- (void)viewDidAppear:(BOOL)animated {
    [self registerNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self deRegisterNotifications];
    [self resetControlView];

    [_player stop];
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(play:)
                                                 name:kNotificationMediaPlay
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pause:)
                                                 name:kNotificationMediaPause
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stop:)
                                                 name:kNotificationMediaStop
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sliderValueChanged:)
                                                 name:kNotificationMediaSliderValueChanged
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackDurationAvailable:)
                                                 name:MPMovieDurationAvailableNotification
                                               object:nil];
}

- (void)deRegisterNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMovieDurationAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationMediaPlay object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationMediaPause object:nil];
}

#pragma mark - notification methods

- (void)playbackStateChanged:(NSNotification *)notification {
    MPMoviePlaybackState state = _player.playbackState;
    switch (state) {
        case MPMoviePlaybackStateStopped: {
            [_mediaControlView changePlayPauseButtonState:kPlayPauseButtonStatePlay];
            [self.view bringSubviewToFront:_imgThumbnail];
            [self toggleLoading:YES];
        } break;
        case MPMoviePlaybackStatePlaying: {
            [_mediaControlView changePlayPauseButtonState:kPlayPauseButtonStatePause];
            [self monitorPlaybackTime];
            [self toggleLoading:NO];
        } break;
        case MPMoviePlaybackStatePaused: {
            [self toggleLoading:NO];
            [_mediaControlView changePlayPauseButtonState:kPlayPauseButtonStatePlay];
        } break;
        case MPMoviePlaybackStateInterrupted:
            break;
        case MPMoviePlaybackStateSeekingForward:
            [self toggleLoading:YES];
            if (_player.currentPlaybackRate == MPMoviePlaybackStatePaused) {
                [self toggleLoading:NO];
            }
            break;
        case MPMoviePlaybackStateSeekingBackward:
            [self toggleLoading:YES];
            if (_player.currentPlaybackRate == MPMoviePlaybackStatePaused) {
                [self toggleLoading:NO];
            }
            break;
        default:
            break;
    }
}

- (void)playbackDidFinish:(NSNotification *)notification {
    [self resetControlView];
}

- (void)playbackDurationAvailable:(NSNotification *)notification {
    [self setTotalVideoTimeDuration];
}

#pragma mark end -

- (void)monitorPlaybackTime {
    if (_player.currentPlaybackTime < 0 || isnan(_player.currentPlaybackTime)) {
        return;
    }

    [_mediaControlView mediaControlSlider].value = _player.currentPlaybackTime;
    [_mediaControlView setTimeLabel:[self stringFromTimeInterval:(_player.duration - _player.currentPlaybackTime)]];

    // keep checking for the end of video
    if (self.totalVideoTime != 0 && _player.currentPlaybackTime >= self.totalVideoTime) {
        [_player stop];
    } else {
        [self performSelector:@selector(monitorPlaybackTime) withObject:nil afterDelay:1];
    }
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}

- (void)setTotalVideoTimeDuration {
    self.totalVideoTime = _player.duration;
    [_mediaControlView mediaControlSlider].minimumValue = 0.0;
    [_mediaControlView mediaControlSlider].maximumValue = _player.duration;
    _player.currentPlaybackTime = 0.1;
}

- (void)resetControlView {
    [_mediaControlView changePlayPauseButtonState:kPlayPauseButtonStatePlay];
    [_mediaControlView mediaControlSlider].minimumValue = 0.0;
    [_mediaControlView mediaControlSlider].maximumValue = 0.0;
    [_mediaControlView setTimeLabel:@"00:00"];
}

- (void)toggleLoading:(BOOL)show {
    if (show) {
        _loading.hidden = NO;
        [_loading startAnimating];
    } else {
        _loading.hidden = YES;
        [_loading stopAnimating];
    }
}

#pragma mark - Media Callback methods

- (void)play:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    int currentIndex = [[userInfo objectForKey:@"currentIndex"] intValue];
    if (self.pageIndex == currentIndex) {
        [self.view sendSubviewToBack:_imgThumbnail];
        [_player play];
    }
}

- (void)pause:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    int currentIndex = [[userInfo objectForKey:@"currentIndex"] intValue];
    if (self.pageIndex == currentIndex) {
        [_player pause];
    }
}

- (void)stop:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    int currentIndex = [[userInfo objectForKey:@"currentIndex"] intValue];
    if (self.pageIndex == currentIndex) {
        [self.view bringSubviewToFront:_imgThumbnail];
        [_player stop];
    }
}

- (void)sliderValueChanged:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    int currentIndex = [[userInfo objectForKey:@"currentIndex"] intValue];
    if (self.pageIndex == currentIndex) {
        _player.currentPlaybackTime = [_mediaControlView mediaControlSlider].value;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
