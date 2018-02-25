//
//  ViewController.m
//  iPodVisualizer
//
//  Created by Xinrong Guo on 13-3-23.
//  Copyright (c) 2013年 Xinrong Guo. All rights reserved.
//

#import "ViewController.h"
// 2)b. import AVFoundation
#import <AVFoundation/AVFoundation.h>

// 21)b.
//#import "VisualizerView.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) NSArray *playItems;
@property (strong, nonatomic) NSArray *pauseItems;
@property (strong, nonatomic) UIBarButtonItem *playBBI;
@property (strong, nonatomic) UIBarButtonItem *pauseBBI;

// 2)c. add a property to hold the audio player
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;



// 21)c. add a property to hold the visualizer
//@property (strong, nonatomic) VisualizerView *visualizer;


@end

@implementation ViewController {
    BOOL _isBarHide;
    BOOL _isPlaying;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBars];
    
    // 22) This creates a VisualizerView instance that will fill its parent view and adds it to _backgroundView.
   /*
    self.visualizer = [[VisualizerView alloc] initWithFrame:self.view.frame];
    [_visualizer setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_backgroundView addSubview:_visualizer];
    */
    // 23)a. looks cool, but doesn't "dance" with the music ... so let's add access to the music within the VizualizerView (start with .h file)
    
    
    // 3)b. load up the audio player
    [self configureAudioPlayer];
    // set up the audio player as soon as the view loads and so are able to press the play button on app start
    
    
    // 9)b. load up the audio session
    //[self configureAudioSession];
    
    // 10) Now you have to declare that your app supports background execution. Open iPodVisualizer-Info.plist, select the last line, and click the plus button to add a new item. Select "Required background modes" as the Key from the dropdown. Expand the item, set the value of Item0 to "App plays audio..." 
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self toggleBars];
}

// 3)a. configure audio player to load in DemoSong indefinitely
- (void)configureAudioPlayer {
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"DemoSong" withExtension:@"m4a"];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    [_audioPlayer setNumberOfLoops:-1]; // sets its numberOfLoops property to -1 to make the audio loop forever.
    
    // 24)b. turn on metering, and give a copy to Visualizer
    //[_audioPlayer setMeteringEnabled:YES];
    //[_visualizer setAudioPlayer:_audioPlayer];
}

- (void)configureBars {
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    CGRect frame = self.view.frame;
    
    self.backgroundView = [[UIView alloc] initWithFrame:frame];
    [_backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_backgroundView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:_backgroundView];
    
    // NavBar
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, -44, frame.size.width, 44)];
    [_navBar setBarStyle:UIBarStyleBlackTranslucent];
    [_navBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    UINavigationItem *navTitleItem = [[UINavigationItem alloc] initWithTitle:@"Music Visualizer"];
    [_navBar pushNavigationItem:navTitleItem animated:NO];
    
    [self.view addSubview:_navBar];
    
    // ToolBar
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 320, frame.size.width, 44)];
    [_toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [_toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    UIBarButtonItem *pickBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(pickSong)];
    
    self.playBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playPause)];
    
    self.pauseBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(playPause)];
    
    UIBarButtonItem *leftFlexBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightFlexBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.playItems = [NSArray arrayWithObjects:pickBBI, leftFlexBBI, _playBBI, rightFlexBBI, nil];
    self.pauseItems = [NSArray arrayWithObjects:pickBBI, leftFlexBBI, _pauseBBI, rightFlexBBI, nil];
    
    [_toolBar setItems:_playItems];
    
    [self.view addSubview:_toolBar];
    
    _isBarHide = YES;
    _isPlaying = NO;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    [_backgroundView addGestureRecognizer:tapGR];
}

- (void)toggleBars {
    CGFloat navBarDis = -44;
    CGFloat toolBarDis = 44;
    if (_isBarHide ) {
        navBarDis = -navBarDis;
        toolBarDis = -toolBarDis;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint navBarCenter = _navBar.center;
        navBarCenter.y += navBarDis;
        [_navBar setCenter:navBarCenter];
        
        CGPoint toolBarCenter = _toolBar.center;
        toolBarCenter.y += toolBarDis;
        [_toolBar setCenter:toolBarCenter];
    }];
    
    _isBarHide = !_isBarHide;
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tapGR {
    [self toggleBars];
}


#pragma mark - Music control

// Tapping the play/pause button calls playPause. The code you just added tells audioPlayer to play or pause according to its current state as defined by _isPlaying

- (void)playPause {
    if (_isPlaying) {
        // 4)a. add pausing functionality
        [_audioPlayer pause];
        
        [_toolBar setItems:_playItems];  // toggle play/pause button
    }
    else {
        // 4)b. and playing functionality
        [_audioPlayer play];

        [_toolBar setItems:_pauseItems]; // toggle play/pause button
    }
    // toggle isPlaying
    _isPlaying = !_isPlaying;
}

- (void)playURL:(NSURL *)url {
    if (_isPlaying)
    {
        [self playPause]; // Pause the previous audio player
    }

    // 5) instead of hardcoding the filename, create a new AVAudioPlayer instance with the URL passed into the method
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer setNumberOfLoops:-1];
    
    // 24)b. turn on metering, and give a copy to Visualizer
    //[_audioPlayer setMeteringEnabled:YES];
    //[_visualizer setAudioPlayer:_audioPlayer];
    
    [self playPause];   // Play 
}



#pragma mark - Media Picker

// 6) present a modal music picker subView
 /* This method is called when the user presses the magnifier button (because this selector was used to create the button in configureBars, defined earlier in this file). It displays a media picker screen to the user  */
- (void)pickSong {

    // configured to show only audio files.
    MPMediaPickerController *picker =[[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    
    // register self as delegate
    [picker setDelegate:self];
    [picker setAllowsPickingMultipleItems: NO];
    [self presentModalViewController:picker animated:YES];

}

#pragma mark - Media Picker Delegate

// 7) when the user selects a song, this callback is made
/* This method is called when the user chooses something from the media picker screen. It dismisses the media picker screen and plays the selected song.
 */
- (void)mediaPicker:(MPMediaPickerController *) mediaPicker didPickMediaItems:(MPMediaItemCollection *) collection {
  
    // remove the media picker screen
    [self dismissViewControllerAnimated:YES completion:NULL];

    // grab the first selection (media picker is capable of returning more than one selected item, but this app only deals with one song at a time)
    MPMediaItem *item = [[collection items] objectAtIndex:0];
    
    // get some meta-data
    NSString *title = [item valueForProperty:MPMediaItemPropertyTitle];
    [_navBar.topItem setTitle:title];
  
    // get a URL reference to the selected item
    NSURL *url = [item valueForProperty:MPMediaItemPropertyAssetURL];

    // pass the URL to playURL:, defined earlier in this file
    [self playURL:url];
}

/*
 * This method is called when the user cancels out of the media picker. It just dismisses the media picker screen.
 */
- (void)mediaPickerDidCancel:(MPMediaPickerController *) mediaPicker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


// 8) Now run the App, and play some music. press the home button, You’ll notice that your music is paused. This isn’t a very good experience for a music player application, if a music player is what you’re after.
// You can configure your app so that the music will continue to play even when the app enters the background.
// To play music in the background, you need to do two things: set the audio session category, then declare the app as supporting background execution.
// First, set the audio session category.
- (void)configureAudioSession {
    NSError *error;
    // grab the singleton pointer to the system's audio session
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    if (error) {
        NSLog(@"Error setting category: %@", [error description]);
    }
    
    // 9)a. now add a call to this method in ViewDidLoad
}

@end
