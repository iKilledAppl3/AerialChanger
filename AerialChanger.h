/*
	AerialChanger 
	Copyright 2020 J.K. Hayslip (@iKilledAppl3) & iKilledAppl3 LLC. All rights reserved.
*/


//headers we need! 
@import UIKit;
@import QuartzCore;

// check to see if the tweak is enabled or not
BOOL kEnabled;

NSString *kChosenScreensaver;

// Statically call items so we can call upon them at a later date.

// the PLIST path where all user settings are stored.
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.ikilledappl3.aerialchanger.plist"
// Load our screensavers with the Power of AirDrop and Ethereal!
#define kVideoPath [NSString stringWithFormat:@"/var/mobile/Documents/Ethereal/%@", kChosenScreensaver]


// For the idle screen stuff 

@interface TVPURLMediaItem : NSObject {

	NSURL* _url;
	NSSet* _traits;

}

@property (nonatomic,copy) NSURL * url;                
@property (nonatomic,copy) NSSet * traits;  
-(id)init;
-(NSURL *)url;
-(void)setUrl:(NSURL *)arg1 ;
-(void)setTraits:(NSSet *)arg1 ;
-(NSSet *)traits;
-(id)initWithURL:(id)arg1 traits:(id)arg2 ;
-(BOOL)isEqualToMediaItem:(id)arg1 ;
-(id)mediaItemURL;
-(BOOL)hasTrait:(id)arg1 ;
@end


@interface TVPVideoView : UIView
@end

@interface TVIBackgroundView : UIView
@property(readonly, nonatomic) TVPVideoView *videoView; 
@property(readonly, nonatomic) TVPURLMediaItem *currentMediaItem; 
@property(readonly, nonatomic) TVPURLMediaItem *nextMediaItem;
-(NSArray *)mediaItems;
- (void)didMoveToWindow;
-(id)initWithFrame:(CGRect)arg1;
@end

@interface TVIMainViewController : UIViewController
@property(readonly, nonatomic) TVIBackgroundView *backgroundView; 
-(void)loadView;
@end


 @interface TVILocationLabelView : UIView 
@property(retain, nonatomic) UILabel *subtitleLabel;
@property(retain, nonatomic) UILabel *titleLabel;
-(void)layoutSubviews;
 @end