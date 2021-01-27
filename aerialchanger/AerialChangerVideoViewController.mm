#import "AerialChangerVideoViewController.h"

NSDictionary *dict;
NSMutableDictionary *mutableDict;

@implementation AerialChangerVideoViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    [self retrieveDictionaryInfo];
    [self setupVideoLayer];
}


-(void)retrieveDictionaryInfo {
  dict = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
  mutableDict = dict ? [[dict mutableCopy] autorelease] : [NSMutableDictionary dictionary];
  self.chosenVideo = ([mutableDict objectForKey:@"kChosenScreensaver"]);
}

-(void)setupVideoLayer {
  // this code is loosely based on Ballet by @Litteeen 
  if (self.playerLayer) return;

  // when user selects video from AirDropped location
  NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"/var/mobile/Documents/Ethereal/%@", self.chosenVideo]];

  self.playerItem = [AVPlayerItem playerItemWithURL:url];

  self.player = [AVQueuePlayer playerWithPlayerItem:self.playerItem];
  [self.player setPreventsDisplaySleepDuringVideoPlayback:NO];

  self.playerLooper = [AVPlayerLooper playerLooperWithPlayer:self.player templateItem:self.playerItem];

    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.playerLayer setFrame:self.view.frame];
    [[[self view] layer] insertSublayer:self.playerLayer atIndex:0];

  [self.player play];
}
@end