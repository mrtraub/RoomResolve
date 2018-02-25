//
//  FilterDemoViewController.m
//  AudioUnitV3Example
//
//  Created by ALICIA JACKSON on 3/3/16.
//
//

#import "FilterDemoViewController.h"

@interface FilterDemoViewController ()
{

    __weak IBOutlet UILabel *gainLabel;

    __weak IBOutlet UISlider *gainSlider;

    __weak IBOutlet UISlider *panSlider;

    __weak IBOutlet UILabel *panLabel;
}
- (IBAction)gainSliderDidChange:(UISlider *)sender;

@end

@implementation FilterDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.audioUnit==nil)
        return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beginRequestWithExtensionContext:(NSExtensionContext*)context
{
    [super beginRequestWithExtensionContext:context];
}


-(AUAudioUnit*) createAudioUnitWithComponentDescription:(AudioComponentDescription)componentDescription error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    self.audioUnit = [[AUv3FilterDemo alloc] initWithComponentDescription:componentDescription error:error];
    
    return _audioUnit;
}

- (IBAction)panSliderDidChange {
    [self.audioUnit setPanValue:panSlider.value];
    [panLabel setText:[NSString stringWithFormat:@"%f", panSlider.value]];
}

- (IBAction)gainSliderDidChange:(UISlider *)sender {
    [self.audioUnit setGainValue:gainSlider.value];
    [gainLabel setText:[NSString stringWithFormat:@"%f",gainSlider.value]];
                        
}
@end


