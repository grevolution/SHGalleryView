//
//  EmbededViewController.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 28/2/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import "EmbededViewController.h"
#import "SHMediaItem.h"
#import "SHImageMediaItemViewController.h"
#import "SHMediaControlView.h"
#import "SHGalleryViewTheme.h"
#import "SHGalleryViewControllerDelegate.h"
#import "SHGalleryViewControllerDataSource.h"
#import "SHGalleryView.h"

@interface EmbededViewController () <SHGalleryViewControllerDelegate, SHGalleryViewControllerDataSource>

@property (weak, nonatomic) IBOutlet SHGalleryView *containerView;

@end

@implementation EmbededViewController

- (void)viewDidLoad {

    SHGalleryViewTheme *theme = [[SHGalleryViewTheme alloc] init];
    theme.backgroundColor = [UIColor orangeColor];
    theme.captionBarBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    theme.captionTitleAtributes =
        @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]};

    theme.timeLabelAtributes =
        @{NSFontAttributeName : [UIFont systemFontOfSize:11], NSForegroundColorAttributeName : [UIColor whiteColor]};

    theme.sliderProgressColor = [UIColor redColor];
    theme.sliderTrackColor = [UIColor whiteColor];

    theme.pageControlBackgroundColor = [UIColor clearColor];
    theme.pageControlDotColor = [UIColor greenColor];
    theme.pageControlCurrentDotColor = [UIColor blueColor];

    theme.playButtonImage = [UIImage imageNamed:@"btn_player_play"];
    theme.pauseButtonImage = [UIImage imageNamed:@"btn_pause"];
    theme.doneButtonImage = [UIImage imageNamed:@"btn_close"];
    theme.sliderThumbImage = [UIImage imageNamed:@"icn_scrubber"];

    _containerView.theme = theme;
    _containerView.delegate = self;
    _containerView.dataSource = self;
    _containerView.showPageControl = YES;
    _containerView.disablePinchAndZoomOnImages = YES;
    _containerView.isDoneButtonForcedHidden = YES;
    [_containerView setupGalleryView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueGalleryView"]) {
    }
}

- (CGFloat)numberOfItems {
    return 5;
}

- (SHMediaItem *)mediaItemIndex:(NSInteger)index {

    if (index % 2 == 0) {
        SHMediaItem *item = [[SHMediaItem alloc] init];
        item.mediaType = kMediaTypeImage;
        item.resourcePath = [[[NSBundle mainBundle] URLForResource:@"WeCanDoIt" withExtension:@"png"] absoluteString];
        item.captionTitle = @"This is a caption Title";
        return item;
    } else {
        SHMediaItem *item = [[SHMediaItem alloc] init];
        item.mediaType = kMediaTypeVideo;
        item.captionTitle = @"Big Buck Bunny is Awesome";
        item.resourcePath =
            [[[NSBundle mainBundle] URLForResource:@"big_buck_bunny" withExtension:@"mp4"] absoluteString];
        item.mediaThumbnailImagePath =
            [[[NSBundle mainBundle] URLForResource:@"thumb" withExtension:@"jpg"] absoluteString];
        return item;
    }
}

- (NSInteger)supportedOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)galleryView:(SHGalleryView *)galleryView willDisplayItemAtIndex:(int)index {
}

- (void)galleryView:(SHGalleryView *)galleryView didDisplayItemAtIndex:(int)index {
}

- (void)doneClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
