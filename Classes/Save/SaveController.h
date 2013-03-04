//
//  SaveController.h
//  candles
//
//  Created by Sergey Kopanev on 2/28/11.
//  Copyright 2011 Knees & Toads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveView.h"
#import "SavePageView.h"
#import "FBConnect.h"
#import "SmartImageView.h"
#import "S7FTPRequest.h"

#import <MobiGirl/MGAd.h>

@interface SaveController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate, FBSessionDelegate, FBRequestDelegate, FBDialogDelegate> {
	Facebook *facebook;
	SaveView *saveView;
	NSMutableArray *candleObjects;
	int currentIndex;
	NSMutableArray *views;
	UINavigationController *nav;
	SmartImageView *fbsi;
	
	id target;
	SEL logintToFaceSelector;
	
    MGAd *ad;
}

@property (nonatomic, retain) SmartImageView *fbsi;
@property (assign) SEL logintToFaceSelector;
@property (assign) id target;
@property (assign) Facebook *facebook;
@property (assign) UINavigationController *nav;
@property (nonatomic, retain) NSMutableArray *candleObjects;

- (void) addObjectToSave: (NSMutableDictionary*) d;
- (SavePageView*) createPageWithData: (NSMutableArray*) data;
@end
