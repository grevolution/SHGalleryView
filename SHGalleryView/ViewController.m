//
//  ViewController.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/4/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import "ViewController.h"
#import "SHGalleryViewController.h"
#import "SHMediaItem.h"
#import "SHImageMediaItemViewController.h"
#import "SHMediaControlView.h"
#import "SHGalleryViewTheme.h"
#import "SHGalleryViewControllerDelegate.h"
#import "SHGalleryViewControllerDataSource.h"

@interface ViewController () <SHGalleryViewControllerDelegate, SHGalleryViewControllerDataSource>

@property (nonatomic, strong) SHGalleryViewController *galleryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SHGalleryViewTheme *theme = [[SHGalleryViewTheme alloc] init];
    theme.backgroundColor = [UIColor orangeColor];

    // deprecated values
    //    theme.captionTitleColor = [UIColor whiteColor];
    //    theme.timeLabelColor = [UIColor whiteColor];

    theme.captionBarBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    // deprecated values
    //    theme.captionTitleFont = [UIFont systemFontOfSize:15];
    //    theme.timeLabelFont = [UIFont systemFontOfSize:11];

    theme.captionTitleAtributes =
        @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]};

    theme.timeLabelAtributes =
        @{NSFontAttributeName : [UIFont systemFontOfSize:11], NSForegroundColorAttributeName : [UIColor whiteColor]};

    theme.sliderProgressColor = [UIColor redColor];
    theme.sliderTrackColor = [UIColor whiteColor];

    theme.playButtonImage = [UIImage imageNamed:@"btn_player_play"];
    theme.pauseButtonImage = [UIImage imageNamed:@"btn_pause"];
    theme.doneButtonImage = [UIImage imageNamed:@"btn_close"];
    theme.sliderThumbImage = [UIImage imageNamed:@"icn_scrubber"];

    theme.pageControlBackgroundColor = [UIColor clearColor];
    theme.pageControlDotColor = [UIColor greenColor];
    theme.pageControlCurrentDotColor = [UIColor blueColor];

    _galleryView = [[SHGalleryViewController alloc] init];
    _galleryView.theme = theme;
    _galleryView.delegate = self;
    _galleryView.dataSource = self;
    _galleryView.showPageControl = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    [self presentViewController:_galleryView animated:YES completion:nil];
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

- (void)galleryView:(SHGalleryViewController *)galleryView willDisplayItemAtIndex:(int)index {
}

- (void)galleryView:(SHGalleryViewController *)galleryView didDisplayItemAtIndex:(int)index {
}

- (void)doneClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
