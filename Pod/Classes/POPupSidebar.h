//
//  POPupSidebar.h
//  Pods
//
//  Created by Trung Pham Hieu on 2/25/16.
//
//

#import <UIKit/UIKit.h>
#import <POPLib/POPLib.h>

enum POPupSidebarMenuType
{
    POPupSidebarMenuTypeDefault,
    POPupSidebarMenuTypeFlat,
};

enum POPupSidebarNavigationPosition
{
    POPupSidebarNavigationPositionLeft,
    POPupSidebarNavigationPositionCenter,
    POPupSidebarNavigationPositionRight,
};

enum POPupSidebarProfileType{
    POPupSidebarProfileTypeWide,
    POPupSidebarProfileTypeTall,
};




@class POPupMenuSidebarVC;

@protocol POPupSidebarDelegate <NSObject>

-(void) popUpDidSelectedItemWithKey:(NSString*)key currentViewController:(UIViewController*)view;

@end

@interface POPupSidebarVC : UINavigationController <POPupSidebarDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) POPupMenuSidebarVC* sidebarViewController;
@property (nonatomic) id<POPupSidebarDelegate> popUpSidebarDelegate;
@property (nonatomic) UIBarButtonItem* sidebarMenuButton;
@property (nonatomic) enum POPupSidebarMenuType sidebarType;
@property (nonatomic) UIViewController* currentRootViewController;
@property (nonatomic) UIColor* customSectionBgColor;
@property (nonatomic) UIColor* customSectionTextColor;

@property (nonatomic) UIColor* customNavigationBarBgColor;
@property (nonatomic) UIImage* customSidebarMenuButtonIcon;

@property (nonatomic) UIColor* customMenuBgColor;
@property (nonatomic) UIImage* customMenuBgImage;

@property (nonatomic) UIColor* customMenuItemBgColor;
@property (nonatomic) UIColor* customMenuItemActiveBgColor;
@property (nonatomic) UIColor* customMenuItemTextColor;
@property (nonatomic) UIColor* customMenuItemActiveTextColor;
@property (nonatomic) UIColor* customMenuItemSeparatorColor;

@property (nonatomic) UIColor* customMenuNotificationTextColor;
@property (nonatomic) UIColor* customMenuNotificationBgColor;

@property (nonatomic) CGFloat customLineBreakHeight;
@property (nonatomic) UIColor* customLineBreakBgColor;
@property (nonatomic) CGFloat customMenuHeight;

@property (nonatomic) enum POPupSidebarProfileType profileType;
@property (nonatomic) CGFloat customProfileImageSize;
@property (nonatomic) CGFloat customProfileImageBorderWidth;
@property (nonatomic) UIColor* customProfileImageBorderColor;
@property (nonatomic) CGFloat customProfileSpacing;
@property (nonatomic) UIColor* customProfileTextColor;
@property (nonatomic) UIColor* customProfileDetailTextColor;
@property (nonatomic) UIImage* customProfileBgImage;

@property (nonatomic) BOOL isAllowReloadLastAction; //if execute action that are current display





+(void) setSidebarNavigationTitle:(NSString*)title position:(enum POPupSidebarNavigationPosition) position;
+(void) setSidebarNavigationItem:(UIView*)view position:(enum POPupSidebarNavigationPosition) position;

+(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image name:(NSString*)name detailText:(NSString*)detailText;
+(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image placeHolderImage:(NSString*)placeholderImage name:(NSString*)name detailText:(NSString*)detailText;

+(void) addMenuItemWithKey:(NSString*)key title:(NSString*)title image:(NSString*)image fontsize:(float)fontsize;
+(void) addMenuActionChangeViewWithKey:(NSString*)key storyboardName:(NSString*) storyboardName storyboardID:(NSString*)storyboardID;
+(void) addMenuActionChangeViewWithKey:(NSString*)key storyboardName:(NSString*) storyboardName storyboardID:(NSString*)storyboardID displayStyle:(enum DisplayStyle) displayStyle;
+(void) addImageWithKey:(NSString*)key image:(NSString*)image;
+(void) addNotificationWithMenuKey:(NSString*)key notificationText:(NSString*)text;
+(void) addOptionWithKey:(NSString*)key hashkey:(NSString*)hashkey value:(NSString*)value;
+(void) addRoundCornerWithMenuKey:(NSString*)key cornerRadius:(CGFloat)cornerRadius;
+(void) addSectionWithTitle:(NSString*)title;
+(void) addLineBreak;
+(void) showMenu;

+(void) setSidebarMenuType:(enum POPupSidebarMenuType) type;
+(void) addSidebarWithViewController:(UIViewController*)view;
+(void) removeMenuItemWithKey:(NSString*)key;
+(void) reloadMenu;
+(NSString*) lastSelectedKey;
+(void) setLastSelectedKey:(NSString*)key;
+(void)presentViewWithStorboardName:(NSString*)storyboardName storyboardViewID:(NSString*)viewID currentViewController:(UIViewController*)viewController displayStyle:(enum DisplayStyle) displayStyle;
+(CGFloat) sidebarWidth;
+(void) executeActionWithKey:(NSString*)key exceptLastKey:(BOOL)exceptLastKey;

+(POPupSidebarVC*)Instance;
+(void) InstanceDealloc;

@end

@interface POPupMenuSidebarVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) id<POPupSidebarDelegate> popUpSidebarDelegate;
@property (nonatomic) UITableView* tableView;
@property (nonatomic) NSString* lastActionKey;

-(void) setNavigationTitle:(NSString*)title;
-(void) setNavigationItem:(UIView*)view position:(enum POPupSidebarNavigationPosition) position;

-(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image name:(NSString*)name detailText:(NSString*)detailText fontsize:(float)fontsize;
-(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image placeHolderImage:(NSString*)imageplaceholder name:(NSString*)name detailText:(NSString*)detailText fontsize:(float)fontsize;

-(void) addMenuItemWithKey:(NSString*)key title:(NSString*)title image:(NSString*)image fontsize:(float)fontsize;
-(void) addMenuActionChangeViewWithKey:(NSString*)key storyboardName:(NSString*) storyboardName storyboardID:(NSString*)storyboardID displayStyle:(enum DisplayStyle) displayStyle;
-(void) addOptionWithKey:(NSString*)key hashkey:(NSString*)hashkey value:(NSString*)value;
-(void) addNotificationWithMenuKey:(NSString*)key notificationText:(NSString*)text;
-(void) addRoundCornerWithMenuKey:(NSString*)key cornerRadius:(CGFloat)cornerRadius;
-(void) addSectionWithTitle:(NSString*)title;
-(void) addLineBreak;
-(void) executeActionWithKey:(NSString*)key currentRootViewController:(UIViewController*)currentRootViewController exceptLastKey:(BOOL)exceptLastKey;
-(void) removeMenuItemWithKey:(NSString*)key;
-(void) reloadMenu;
-(void) cleanup;
-(void)presentViewWithStorboardName:(NSString*)storyboardName storyboardViewID:(NSString*)viewID currentViewController:(UIViewController*)viewController displayStyle:(enum DisplayStyle) displayStyle;
@end
