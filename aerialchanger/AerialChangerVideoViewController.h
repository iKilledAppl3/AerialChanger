@import UIKit;
@import Foundation;
@import AVFoundation;

// Make sure our path is specified so our tweak knows where to store all of the settings :)
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.ikilledappl3.aerialchanger.plist"

@interface AerialChangerVideoViewController : UIViewController
@property (nonatomic, assign) AVQueuePlayer *player;
@property (nonatomic, assign) AVPlayerItem	*playerItem;
@property (nonatomic, assign) AVPlayerLooper *playerLooper;
@property (nonatomic, assign) AVPlayerLayer	*playerLayer;
@property (nonatomic, assign) NSString *chosenVideo;
-(void)viewDidLoad;
-(void)setupVideoLayer;
-(void)retrieveDictionaryInfo;
@end
