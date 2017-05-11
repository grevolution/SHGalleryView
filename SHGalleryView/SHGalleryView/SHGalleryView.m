//
//  SHGalleryView.m
//  SHGalleryView
//
//  Created by Shan Ul Haq on 9/3/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHGalleryView.h"
#import "SHImageMediaItemViewController.h"
#import "SHVideoMediaItemViewController.h"
#import "SHMediaItem.h"
#import "SHMediaControlView.h"
#import "SHUtil.h"
#import "SHGalleryViewTheme.h"
#import "SHGalleryViewControllerChild.h"

@interface SHGalleryView () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, SHMediaControlViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) SHMediaControlView *mediaControlView;

@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSInteger nextIndex;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation SHGalleryView

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)setupGalleryView {
    _currentIndex = 0;

    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];

    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;

    [self addSubview:[_pageViewController view]];

    if (_showPageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.numberOfPages = [_dataSource numberOfItems];
        _pageControl.currentPage = _currentIndex;
        [self addSubview:_pageControl];
    }

    _mediaControlView = (SHMediaControlView *)[SHUtil viewFromNib:@"SHMediaControlView" bundle:[NSBundle bundleForClass:self.class]];
    _mediaControlView.delegate = self;
    _mediaControlView.showPageControl = _showPageControl;
    _mediaControlView.isDoneButtonForcedHidden = _isDoneButtonForcedHidden;

    [self addSubview:_mediaControlView];

    [self updateMediaControls];
    [self initializePageViewAtIndex:_currentIndex];

    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_tapGesture setDelegate:self];
    [self addGestureRecognizer:_tapGesture];

    // This is so that it doesn't break existing code that sets the theme
    // before calling setup.
    if (self.theme) {
        [self applyTheme];
    }
}

- (void)triggerPageControlAppearance {
    if (_theme.pageControlDotColor) {
        self.pageControl.pageIndicatorTintColor = _theme.pageControlDotColor;
    }
    if (_theme.pageControlCurrentDotColor) {
        self.pageControl.currentPageIndicatorTintColor = _theme.pageControlCurrentDotColor;
    }
    if (_theme.pageControlBackgroundColor) {
        self.pageControl.backgroundColor = _theme.pageControlBackgroundColor;
    }
}

#pragma mark - UIPageViewController Data Source methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController<SHGalleryViewControllerChild> *currentView = (UIViewController<SHGalleryViewControllerChild> *)viewController;
    UIViewController<SHGalleryViewControllerChild> *previousView = [self viewControllerAtIndex:currentView.pageIndex - 1];
    return previousView;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController<SHGalleryViewControllerChild> *currentView = (UIViewController<SHGalleryViewControllerChild> *)viewController;
    UIViewController<SHGalleryViewControllerChild> *nextView = [self viewControllerAtIndex:currentView.pageIndex + 1];
    return nextView;
}

#pragma mark - UIPageViewController Delegate methods

- (void)pageViewController:(UIPageViewController *)pageViewController
    willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    UIViewController<SHGalleryViewControllerChild> *controller = [pendingViewControllers firstObject];
    self.nextIndex = controller.pageIndex;

    if ([self.delegate respondsToSelector:@selector(galleryView:willDisplayItemAtIndex:)]) {
        [self.delegate galleryView:self willDisplayItemAtIndex:(int)self.nextIndex];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed) {
        self.currentIndex = self.nextIndex;
        [self updateMediaControls];

        if ([self.delegate respondsToSelector:@selector(galleryView:didDisplayItemAtIndex:)]) {
            [self.delegate galleryView:self didDisplayItemAtIndex:(int)self.currentIndex];
        }
    }

    _pageControl.currentPage = _currentIndex;
    self.nextIndex = 0;
}

#pragma mark - UIPageViewController helper methods

- (void)initializePageViewAtIndex:(NSInteger)index {
    UIViewController *initialViewController = [self viewControllerAtIndex:index];
    if (nil != initialViewController) {
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        [_pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    }
}

- (void)reloadData {
    _currentIndex = 0;
    _pageControl.numberOfPages = [_dataSource numberOfItems];
    [self initializePageViewAtIndex:_currentIndex];
    [self updateMediaControls];
}

- (void)scrollToItemAtIndex:(int)index {
    UIPageViewControllerNavigationDirection direction;
    if (index > _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }

    _currentIndex = index;
    [self initializePageViewAtIndex:_currentIndex];
    [self updateMediaControls];
}

- (UIViewController<SHGalleryViewControllerChild> *)viewControllerAtIndex:(NSInteger)index {
    if ([_dataSource numberOfItems] == 0) {
        return nil;
    }

    if (index < 0 || index >= [_dataSource numberOfItems]) {
        return nil;
    }

    SHMediaItem *item = [_dataSource mediaItemIndex:index];
    UIViewController<SHGalleryViewControllerChild> *viewController;
    // check for item, if it is nil, trigger the assert.
    NSAssert(item != nil, @"");
    if (item.mediaType == kMediaTypeVideo) {
        // video
        viewController = (SHVideoMediaItemViewController<SHGalleryViewControllerChild> *)[[SHVideoMediaItemViewController alloc] initWithNibName:@"SHVideoMediaItemViewController" bundle:[NSBundle bundleForClass:self.class]];
        viewController.mediaItem = item;
        viewController.pageIndex = index;
        ((SHVideoMediaItemViewController *)viewController).mediaControlView = _mediaControlView;
    } else {
        // image
        viewController = (SHImageMediaItemViewController<SHGalleryViewControllerChild> *)[[SHImageMediaItemViewController alloc] initWithNibName:@"SHImageMediaItemViewController" bundle:[NSBundle bundleForClass:self.class]];
        viewController.mediaItem = item;
        viewController.pageIndex = index;
        ((SHImageMediaItemViewController *)viewController).disablePinchAndZoomOnImage = _disablePinchAndZoomOnImages;
    }
    return viewController;
}

- (void)updateMediaControls {
    SHMediaItem *mediaItem = [_dataSource mediaItemIndex:self.currentIndex];
    if (mediaItem.mediaType == kMediaTypeImage) {
        [_mediaControlView toggleMediaControlsState:@[ @(kViewStateHidden), @YES ]];
    } else {
        [_mediaControlView toggleAllControls:@[ @(kViewStateVisible), @YES ]];
    }
    [_mediaControlView updateCaptions:mediaItem];
}

#pragma mark - SHMediaControlViewDelegate methods

// video related callbacks
- (void)mediaControlPlay {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaPlay
                                                        object:nil
                                                      userInfo:@{
                                                          @"currentIndex" : @(_currentIndex)
                                                      }];
}

- (void)mediaControlPause {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaPause
                                                        object:nil
                                                      userInfo:@{
                                                          @"currentIndex" : @(_currentIndex)
                                                      }];
}

- (void)mediaControlSeekBarValueChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaSliderValueChanged
                                                        object:nil
                                                      userInfo:@{
                                                          @"currentIndex" : @(_currentIndex)
                                                      }];
}

- (void)mediaControlDone {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaStop
                                                        object:nil
                                                      userInfo:@{
                                                          @"currentIndex" : @(_currentIndex)
                                                      }];
    if (_delegate && [_delegate conformsToProtocol:@protocol(SHGalleryViewControllerDelegate)]) {
        [_delegate doneClicked];
    }
}

- (void)applyTheme {
    if (_theme && _theme.backgroundColor) {
        self.backgroundColor = _theme.backgroundColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }

    [self triggerPageControlAppearance];
    _mediaControlView.theme = _theme;
}

#pragma mark - Property methods

- (void)setIsDoneButtonForcedHidden:(BOOL)isDoneButtonForcedHidden {
    _isDoneButtonForcedHidden = isDoneButtonForcedHidden;
    _mediaControlView.isDoneButtonForcedHidden = _isDoneButtonForcedHidden;
}

- (void)setTheme:(SHGalleryViewTheme *)theme {
    _theme = theme;

    [self applyTheme];
}

#pragma mark - UITapGestureRecognizer methods

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer;
{
    if (_mediaControlView.isControlShowing == NO) {
        SHMediaItem *mediaItem = [_dataSource mediaItemIndex:self.currentIndex];
        if (mediaItem.mediaType == kMediaTypeImage) {
            [_mediaControlView toggleDoneButtonState:@[ @(kViewStateVisible), @YES ]];
            [_mediaControlView toggleGalleryControlState:@[ @(kViewStateVisible), @YES ]];
        } else {
            [_mediaControlView toggleAllControls:@[ @(kViewStateVisible), @YES ]];
        }
    } else if (_mediaControlView.isControlShowing == YES) {
        SHMediaItem *mediaItem = [_dataSource mediaItemIndex:self.currentIndex];
        if (mediaItem.mediaType == kMediaTypeImage) {
            [_mediaControlView toggleDoneButtonState:@[ @(kViewStateHidden), @YES ]];
            [_mediaControlView toggleGalleryControlState:@[ @(kViewStateHidden), @YES ]];
        } else {
            [_mediaControlView toggleAllControls:@[ @(kViewStateHidden), @YES ]];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the
// gesture recognizer from seeing this touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIControl class]]) {
        return NO;
    }
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [[_pageViewController view] setFrame:[self bounds]];
    CGSize recommendedSize = [_pageControl sizeForNumberOfPages:[_dataSource numberOfItems]];
    CGFloat x = CGRectGetMidX(_pageViewController.view.bounds);
    _pageControl.frame = CGRectMake(0, _pageViewController.view.bounds.size.height - recommendedSize.height, recommendedSize.width, recommendedSize.height);
    _pageControl.center = CGPointMake(x, _pageControl.center.y);

    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];

    [SHUtil constrainViewEqual:_pageViewController.view toParent:self];
    [SHUtil constrainViewEqual:_mediaControlView toParent:self];
}

@end
