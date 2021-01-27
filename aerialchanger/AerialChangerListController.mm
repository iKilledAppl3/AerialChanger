#include "AerialChangerListController.h"
#import <objc/runtime.h>

@implementation AerialChangerListController

inline NSString *GetPrefVal(NSString *key){
    return [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key];
}

// Lets load our prefs!
- (id)loadSettingGroups {
    
    id facade = [[NSClassFromString(@"TVSettingsPreferenceFacade") alloc] initWithDomain:@"com.ikilledappl3.aerialchanger" notifyChanges:TRUE];

    directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/var/mobile/Documents/Ethereal/" error:NULL];

    NSMutableArray *_backingArray = [NSMutableArray new];
    
    kEnabled = [TSKSettingItem toggleItemWithTitle:@"Enable Tweak" description:@"Enable or disable the tweak. \n Custom Screensavers are awesome!" representedObject:facade keyPath:@"kEnabled" onTitle:@"Enabled" offTitle:@"Disabled"];

    /* this uses a method found in the TVSettingKit that's not yet documented but will be soon. It basically loads stuff from a certain directory and the user
     can select that item and it will write the value to the plist path specified. And will show the value of the selected item on the main view.
    */
    kScreensavers = [TSKSettingItem multiValueItemWithTitle:@"Custom Screen Savers" description:@"Choose your screen saver. \n You can AirDrop them to Ethereal and select them here." representedObject:facade keyPath:@"kChosenScreensaver" availableValues:directoryContent];

    // Respring Button here baby! No documenation found so I had to figure this one out myself :P
    kRespringButton = [TSKSettingItem actionItemWithTitle:@"Respring" description:@"Apply Changes with a respring! \n Copyright 2020 - 2021 J.K. Hayslip (iKilledAppl3) & iKilledAppl3 LLC. \n All rights reserved." representedObject:facade keyPath:PLIST_PATH target:self action:@selector(doAFancyRespring)];
    
    
    TSKSettingGroup *group = [TSKSettingGroup groupWithTitle:@"Enable Tweak" settingItems:@[kEnabled]];
    TSKSettingGroup *group2 = [TSKSettingGroup groupWithTitle:@"Screen Savers" settingItems:@[kScreensavers]];
    TSKSettingGroup *group3 = [TSKSettingGroup groupWithTitle:@"Apply Changes" settingItems:@[kRespringButton]];
    
    [_backingArray addObject:group];
    [_backingArray addObject:group2];
    [_backingArray addObject:group3];
    
    [self setValue:_backingArray forKey:@"_settingGroups"];
    
    return _backingArray;
    
}

-(void)doAFancyRespring {
    self.respringBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.respringEffectView = [[UIVisualEffectView alloc] initWithEffect:self.respringBlur];
    self.respringEffectView.frame = self.view.frame;
    [self.respringEffectView setAlpha:0.0];
    [[self view] addSubview:self.respringEffectView];

	 [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.respringEffectView setAlpha:1.0];
    } completion:^(BOOL finished) {
        [self respring];
    }];

}

-(void)respring {
    NSTask *task = [[[NSTask alloc] init] autorelease];
    [task setLaunchPath:@"/usr/bin/killall"];
    [task setArguments:[NSArray arrayWithObjects:@"PineBoard", nil]];
    [task launch];
    
}

// this is to make sure our preferences our loaded
- (TVSPreferences *)ourPreferences {
    return [TVSPreferences preferencesWithDomain:@"com.ikilledappl3.aerialchanger"];
}


// This is to show our preferences in the tweaks section of tvOS.
- (void)showViewController:(TSKSettingItem *)item {
    TSKTextInputViewController *testObject = [[TSKTextInputViewController alloc] init];
    
    testObject.headerText = @"AerialChanger";
    testObject.initialText = [[self ourPreferences] stringForKey:item.keyPath];

    [self.navigationController pushViewController:testObject animated:TRUE];
}

// This is to show our tweak's icon instead of the boring Apple TV logo :)
-(id)previewForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TSKPreviewViewController *item = [super previewForItemAtIndexPath:indexPath];

    AerialChangerVideoViewController *videoPreviewController = [[AerialChangerVideoViewController alloc] init];
    videoPreviewController.view.frame = self.view.frame;
    [item setContentView:videoPreviewController.view];
        
    
    return item;
    
}


@end
