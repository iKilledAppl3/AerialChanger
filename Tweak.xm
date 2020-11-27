/*
	AerialChanger 
	Copyright 2020 J.K. Hayslip (@iKilledAppl3) & iKilledAppl3 LLC. All rights reserved.
*/


#import "AerialChanger.h"

%hook TVPURLMediaItem 

-(NSURL *)url {
	if (kEnabled) {
		return [NSURL fileURLWithPath:kVideoPath];
	}

	else {
		return %orig;
	}
	
}
%end

%hook TVILocationLabelView
-(void)layoutSubviews {
	if (kEnabled) {
		self.hidden = YES;
	}

	else {
		%orig;
	}
}
%end

// tvOS 14
%hook TVISAerialAsset
-(NSURL *)localAssetURL {
	if (kEnabled) {
		if (@available(tvOS 14, *)) {
			return [NSURL fileURLWithPath:kVideoPath];
		}

		else {
			return %orig;
		}
	}

	else {
		return %orig;
	}
}
%end

%hook IdleScreenUILabel 
-(void)layoutSubviews {
	if (kEnabled) {
		[self removeFromSuperview];
	}

	else {
		%orig;
	}
}
%end

// Load preferences to make sure changes are written to the plist
static void loadPrefs() {

  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
  
    //our preference values that write to a plist file when a user selects somethings
  kEnabled = [([prefs objectForKey:@"kEnabled"] ?: @(NO)) boolValue];
  kChosenScreensaver = [prefs objectForKey:@"kChosenScreensaver"];
}

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) loadPrefs, CFSTR("com.ikilledappl3.aerialchanger.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  loadPrefs();

  // Nice try Apple #checkm8
    %init(IdleScreenUILabel=objc_getClass("IdleScreenUI.AerialLocationLabelUIView"));

 }