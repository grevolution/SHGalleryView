//
//  SHMediaItemViewController.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/4/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHImageMediaItemViewController.h"
#import "SHMediaControlView.h"
#import "SHMediaItem.h"
#import <UIImageView+AFNetworking.h>
#import "SHGalleryViewControllerChild.h"

#define ZOOM_VIEW_TAG 100

@interface SHImageMediaItemViewController () <SHGalleryViewControllerChild, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SHImageMediaItemViewController

@synthesize pageIndex;
@synthesize mediaItem;

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
    [_imageView setImageWithURL:[NSURL URLWithString:self.mediaItem.resourcePath] placeholderImage:nil];
    [_imageScrollView setDelegate:self];
    [_imageScrollView setBouncesZoom:YES];

    [_imageView setTag:ZOOM_VIEW_TAG];
    [_imageScrollView setContentSize:[_imageView frame].size];

    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [_imageScrollView frame].size.width / [_imageView frame].size.width;
    [_imageScrollView setMinimumZoomScale:minimumScale];
    [_imageScrollView setZoomScale:minimumScale];

    if (_disablePinchAndZoomOnImage) {
        [_imageScrollView setMaximumZoomScale:minimumScale];
    }
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [_imageScrollView viewWithTag:ZOOM_VIEW_TAG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
