//
//  SHGalleryViewController.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/4/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHGalleryViewController.h"
#import "SHImageMediaItemViewController.h"
#import "SHVideoMediaItemViewController.h"
#import "SHMediaItem.h"
#import "SHMediaControlView.h"
#import "SHUtil.h"

@interface SHGalleryViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, SHMediaControlViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) SHMediaControlView *mediaControlView;

@property (nonatomic) int totalNumberOfItems;
@property (nonatomic) int currentIndex;
@property (nonatomic) int nextIndex;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation SHGalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _totalNumberOfItems = [_dataSource numberOfItems];
    _currentIndex = 0;
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if(_totalNumberOfItems > 0){
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
    [[_pageViewController view] setFrame:[self.view bounds]];
	[self addChildViewController:_pageViewController];
	[[self view] addSubview:[_pageViewController view]];
	[_pageViewController didMoveToParentViewController:self];
    
    _mediaControlView = (SHMediaControlView *)[SHUtil viewFromNib:@"SHMediaControlView" bundle:nil];
    _mediaControlView.delegate = self;
    _mediaControlView.theme = _theme;
    [self.view addSubview:_mediaControlView];
    
    [self updateMediaControls];
    [self initializePageView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_tapGesture setDelegate:self];
    [self.view addGestureRecognizer:_tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController Data Source methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController<SHGalleryViewControllerChild> *currentView = (UIViewController<SHGalleryViewControllerChild> *)viewController;
    UIViewController<SHGalleryViewControllerChild> *previousView = [self viewControllerAtIndex:currentView.pageIndex - 1];
    return previousView;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController<SHGalleryViewControllerChild> *currentView = (UIViewController<SHGalleryViewControllerChild> *)viewController;
    UIViewController<SHGalleryViewControllerChild> *nextView = [self viewControllerAtIndex:currentView.pageIndex + 1];
    return nextView;
}

#pragma mark - UIPageViewController Delegate methods

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    UIViewController<SHGalleryViewControllerChild>* controller = [pendingViewControllers firstObject];
    self.nextIndex = controller.pageIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if(completed){
        self.currentIndex = self.nextIndex;
        [self updateMediaControls];
    }
    self.nextIndex = 0;
}

#pragma mark - UIPageViewController helper methods

- (void)initializePageView {
    UIViewController *initialViewController = [self viewControllerAtIndex:0];
    if(nil != initialViewController) {
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}
- (void)reloadData {
    _totalNumberOfItems = [_dataSource numberOfItems];
    _currentIndex = 0;
    [self initializePageView];
    [self updateMediaControls];
}

- (void)scrollToItemAtIndex:(int)index {
    UIPageViewControllerNavigationDirection direction;
    if(index > _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    _currentIndex = index;
    [self initializePageView];
    [self updateMediaControls];
}

- (UIViewController<SHGalleryViewControllerChild> *)viewControllerAtIndex:(int)index {
    if(_totalNumberOfItems == 0){
        return nil;
    }
    
    if(index < 0 || index >= _totalNumberOfItems) {
        return nil;
    }
    
    SHMediaItem *item = [_dataSource mediaItemIndex:index];
    UIViewController<SHGalleryViewControllerChild> *viewController;
    //check for item, if it is nil, trigger the assert.
    NSAssert(item != nil, @"");
    if (item.mediaType == kMediaTypeVideo) {
        //video
        viewController = (SHVideoMediaItemViewController<SHGalleryViewControllerChild> *)[[SHVideoMediaItemViewController alloc] init];
        viewController.mediaItem = item;
        viewController.pageIndex = index;
        ((SHVideoMediaItemViewController *)viewController).mediaControlView = _mediaControlView;
    } else {
        //image
        viewController = (SHImageMediaItemViewController<SHGalleryViewControllerChild> *)[[SHImageMediaItemViewController alloc] init];
        viewController.mediaItem = item;
        viewController.pageIndex = index;
    }
    return viewController;
}

- (void)updateMediaControls {
    SHMediaItem *mediaItem = [_dataSource mediaItemIndex:self.currentIndex];
    if(mediaItem.mediaType == kMediaTypeImage) {
        [_mediaControlView toggleMediaControlsState:kViewStateHidden animated:YES];
    } else {
        [_mediaControlView toggleAllControls:kViewStateVisible animated:YES];
    }
    [_mediaControlView updateCaptions:mediaItem];
}

#pragma mark - SHMediaControlViewDelegate methods

//video related callbacks
- (void)mediaControlPlay {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaPlay object:nil userInfo:@{@"currentIndex" : @(_currentIndex)}];
}

- (void)mediaControlPause {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaPause object:nil userInfo:@{@"currentIndex" : @(_currentIndex)}];
}

- (void)mediaControlSeekBarValueChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaSliderValueChanged object:nil userInfo:@{@"currentIndex" : @(_currentIndex)}];
}

- (void)mediaControlDone {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMediaStop object:nil userInfo:@{@"currentIndex" : @(_currentIndex)}];
    if(_delegate && [_delegate conformsToProtocol:@protocol(SHGalleryViewControllerDelegate)]) {
        [_delegate doneClicked];
    }
}

#pragma mark - UITapGestureRecognizer methods

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer; {
	if(_mediaControlView.isControlShowing == NO){
        SHMediaItem *mediaItem = [_dataSource mediaItemIndex:self.currentIndex];
        if(mediaItem.mediaType == kMediaTypeImage) {
            [_mediaControlView toggleDoneButtonState:kViewStateVisible animated:YES];
            [_mediaControlView toggleGalleryControlState:kViewStateVisible animated:YES];
        } else {
            [_mediaControlView toggleAllControls:kViewStateVisible animated:YES];
        }
	} else if(_mediaControlView.isControlShowing == YES) {
        SHMediaItem *mediaItem = [_dataSource mediaItemIndex:self.currentIndex];
        if(mediaItem.mediaType == kMediaTypeImage) {
            [_mediaControlView toggleDoneButtonState:kViewStateHidden animated:YES];
            [_mediaControlView toggleGalleryControlState:kViewStateHidden animated:YES];
        } else {
            [_mediaControlView toggleAllControls:kViewStateHidden animated:YES];
        }
	}
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return YES;
}

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if([touch.view isKindOfClass:[UIControl class]]) {
		return NO;
	}
	return YES;
}

#pragma mark - Orientation Methods

- (BOOL)shouldAutorotate {
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
