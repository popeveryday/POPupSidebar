//
//  POPupSidebar.m
//  Pods
//
//  Created by Trung Pham Hieu on 2/25/16.
//
//

#import "POPupSidebar.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <PureLayout/PureLayout.h>

#define profile_spacing 15
#define profile_imageSize CGSizeMake(75, 75)
#define profile_titleHeight 20
#define profile_detailHeight 20
#define profile_textSpacing 5

@interface POPupSidebarVC ()

@end

@implementation POPupSidebarVC{
    UIView* bg;
    NSString* sidebarState;
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture;
}

static POPupSidebarVC *sharedInstance = nil;
+ (POPupSidebarVC *)Instance{
    if (sharedInstance == nil) {
        sharedInstance = [[POPupSidebarVC alloc] init];
    }
    return sharedInstance;
}

+(void) InstanceDealloc{
    [sharedInstance cleanup];
    sharedInstance = nil;
    sharedInstance = [[POPupSidebarVC alloc] init];
}


//+ (POPupSidebarVC *)Instance
//{
//    static POPupSidebarVC *sharedInstance = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[POPupSidebarVC alloc] init];
//    });
//
//    return sharedInstance;
//}

//+(void) InstanceDealloc{
//    [sharedInstance cleanup];
//    sharedInstance = nil;
//    sharedInstance = [[POPupSidebarVC alloc] init];
//}

+(CGFloat) sidebarWidth
{
    //return GC_Device_IsIpad || [StringLib Contains:@"iphone6" inString:GC_MobileAds_Device] ? 300 : 260;
    return (GC_ScreenShort/2) * .8;
}

+(void) showMenu{
    [[POPupSidebarVC Instance] toggleSidebarMenu];
}

+(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image name:(NSString*)name detailText:(NSString*)detailText
{
    [[POPupSidebarVC Instance].sidebarViewController addMenuProfileWithKey:key image:image name:name detailText:detailText fontsize:0];
}

+(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image placeHolderImage:(NSString*)placeholderImage name:(NSString*)name detailText:(NSString*)detailText
{
    [[POPupSidebarVC Instance].sidebarViewController addMenuProfileWithKey:key image:image placeHolderImage:placeholderImage name:name detailText:detailText fontsize:0];
}

+(void) addMenuItemWithKey:(NSString*)key title:(NSString*)title image:(NSString*)image fontsize:(float)fontsize
{
    [[POPupSidebarVC Instance].sidebarViewController addMenuItemWithKey:key title:title image:image fontsize:fontsize];
}

+(void) addMenuActionChangeViewWithKey:(NSString*)key storyboardName:(NSString*) storyboardName storyboardID:(NSString*)storyboardID
{
    [[POPupSidebarVC Instance].sidebarViewController addMenuActionChangeViewWithKey:key storyboardName:storyboardName storyboardID:storyboardID displayStyle:DisplayStyleReplaceNavigationRootVC];
}

+(void) addMenuActionChangeViewWithKey:(NSString*)key storyboardName:(NSString*) storyboardName storyboardID:(NSString*)storyboardID displayStyle:(enum DisplayStyle) displayStyle
{
    [[POPupSidebarVC Instance].sidebarViewController addMenuActionChangeViewWithKey:key storyboardName:storyboardName storyboardID:storyboardID displayStyle:displayStyle];
}

+(void) addOptionWithKey:(NSString*)key hashkey:(NSString*)hashkey value:(NSString*)value{
    [[POPupSidebarVC Instance].sidebarViewController addOptionWithKey:key hashkey:hashkey value:value];
}

+(void) addImageWithKey:(NSString*)key image:(NSString*)image{
    [self addOptionWithKey:key hashkey:@"image" value:image];
}

+(void) addNotificationWithMenuKey:(NSString*)key notificationText:(NSString*)text
{
    [[POPupSidebarVC Instance].sidebarViewController addNotificationWithMenuKey:key notificationText:text];
}

+(void) addRoundCornerWithMenuKey:(NSString*)key cornerRadius:(CGFloat)cornerRadius
{
    [[POPupSidebarVC Instance].sidebarViewController addRoundCornerWithMenuKey:key cornerRadius:cornerRadius];
}

+(void) addSectionWithTitle:(NSString*)title{
    [[POPupSidebarVC Instance].sidebarViewController addSectionWithTitle:title];
}

+(void) addLineBreak{
    [[POPupSidebarVC Instance].sidebarViewController addLineBreak];
}


+(void) removeMenuItemWithKey:(NSString*)key{
    [[POPupSidebarVC Instance].sidebarViewController removeMenuItemWithKey:key];
}

+(void) reloadMenu{
    [[POPupSidebarVC Instance].sidebarViewController reloadMenu];
}

+(void) setSidebarNavigationItem:(UIView*)view position:(enum POPupSidebarNavigationPosition) position
{
    float maxWidth = [self sidebarWidth] - 10;
    
    if (view.frame.size.width > maxWidth) {
        view.frame = CGRectMake(0, 0, maxWidth, view.frame.size.height);
    }
    
    [[POPupSidebarVC Instance].sidebarViewController setNavigationItem:view position:position];
}

+(void) setSidebarNavigationTitle:(NSString*)title position:(enum POPupSidebarNavigationPosition) position
{
    UILabel* label;
    switch (position) {
        case POPupSidebarNavigationPositionCenter:
            [[POPupSidebarVC Instance].sidebarViewController setNavigationTitle:title];
            break;
        case POPupSidebarNavigationPositionLeft:
        case POPupSidebarNavigationPositionRight:
            label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 10, 10)];
            label.text = title;
            label.textAlignment = position == POPupSidebarNavigationPositionLeft ? NSTextAlignmentLeft : NSTextAlignmentRight;
            label.frame = CGRectMake(0, 0, [title sizeWithAttributes:@{NSFontAttributeName: label.font}].width , [title sizeWithAttributes:@{NSFontAttributeName: label.font}].height);
            [self setSidebarNavigationItem:label position:position];
            
            break;
    }
}

+(void) setSidebarMenuType:(enum POPupSidebarMenuType) type{
    [POPupSidebarVC Instance].sidebarType = type;
}

+(void) addSidebarWithViewController:(UIViewController*)view
{
    [[POPupSidebarVC Instance] addSidebarWithViewController:view];
}

+(void) removeSidebarWithViewController:(UIViewController*)view
{
    [[POPupSidebarVC Instance] removeSidebarWithViewController:view];
}

+(void) executeActionWithKey:(NSString*)key exceptLastKey:(BOOL)exceptLastKey
{
    [[POPupSidebarVC Instance] executeActionWithKey:key exceptLastKey:exceptLastKey];
}

+(NSString*) lastSelectedKey{
    return [POPupSidebarVC Instance].sidebarViewController.lastActionKey;
}

+(void) setLastSelectedKey:(NSString*)key{
    [POPupSidebarVC Instance].sidebarViewController.lastActionKey = key;
}

+(void)presentViewWithStorboardName:(NSString*)storyboardName storyboardViewID:(NSString*)viewID currentViewController:(UIViewController*)viewController displayStyle:(enum DisplayStyle) displayStyle
{
    [[POPupSidebarVC Instance].sidebarViewController presentViewWithStorboardName:storyboardName storyboardViewID:viewID currentViewController:viewController displayStyle:displayStyle];
}

//================================================================================================

-(id) init
{
    POPupMenuSidebarVC* view = [[POPupMenuSidebarVC alloc] init];
    
    self = [super initWithRootViewController: view ];
    if (self) {
        self.sidebarViewController = view;
        self.sidebarViewController.popUpSidebarDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void) addSidebarWithViewController:(UIViewController*)view
{
    if (leftEdgeGesture == nil) {
        leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
        leftEdgeGesture.edges = UIRectEdgeLeft;
        leftEdgeGesture.delegate = self;
    }
    
    [self initSidebarMenuButton];
    
    if (self.currentRootViewController != nil) {
        [self.currentRootViewController.view removeGestureRecognizer:leftEdgeGesture];
        self.currentRootViewController.navigationItem.leftBarButtonItem = nil;
    }
    
    view.navigationItem.leftBarButtonItem = self.sidebarMenuButton;
    [view.view addGestureRecognizer:leftEdgeGesture];
    self.currentRootViewController = view;
}

-(void) removeSidebarWithViewController:(UIViewController*)view
{
    if (self.currentRootViewController != nil && [view isEqual:self.currentRootViewController]) {
        [self.currentRootViewController.view removeGestureRecognizer:leftEdgeGesture];
        self.currentRootViewController.navigationItem.leftBarButtonItem = nil;
    }
}


- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    [self menuAction:nil];
}

-(void) initSidebarMenuButton
{
    sidebarState = nil;
    if (_sidebarMenuButton != nil) return;
    
    
    NSArray* buttonTypes = @[@"POPupSidebar.bundle/SidebarMenu", @"POPupSidebar.bundle/SidebarMenuCircle"];
    UIImage* icon = nil;
    
    if(self.customSidebarMenuButtonIcon){
        icon = self.customSidebarMenuButtonIcon;
    }else{
        icon = [UIImage imageNamed: buttonTypes[_sidebarType]];
    }
    
    _sidebarMenuButton = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStylePlain target:self action:@selector(menuAction:)];
}

-(void) menuAction:(id)sender{
    [POPupSidebarVC showMenu];
}

-(void) popUpDidSelectedItemWithKey:(NSString *)key currentViewController:(UIViewController *)view
{
    [self toggleSidebarMenuExecuteAfterHideWithKey:key];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addSidebar
{
    
    //    UIViewController *controller = [[UIApplication sharedApplication].windows[0] rootViewController];
    //    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    //    UIViewController *controller = _currentRootViewController;
    UIViewController *controller = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
    
    while (controller.presentedViewController != nil) {
        controller = controller.presentedViewController;
    }
    
    [self beginAppearanceTransition:YES animated:NO];
    //    [controller addChildViewController:self];
    
    if(bg != nil){
        [bg removeFromSuperview];
        bg = nil;
    }
    
    bg = [[UIView alloc] initWithFrame:controller.view.frame];
    //    bg = [[UIView alloc] initWithFrame:controller.navigationController.view.frame];
    bg.backgroundColor = [UIColor blackColor];
    bg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bg.alpha = 0;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [bg addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [bg addGestureRecognizer:swipeGesture];
    
    [controller.view addSubview:bg];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    self.view.frame = CGRectMake(-[POPupSidebarVC sidebarWidth], 0, [POPupSidebarVC sidebarWidth], controller.view.frame.size.height);
    
    [controller.view addSubview:self.view];
    //    [self didMoveToParentViewController:controller];
    [self endAppearanceTransition];
}

-(void) removeSidebar{
    [self beginAppearanceTransition:YES animated:NO];
    //    [self willMoveToParentViewController:nil];
    
    [self.view removeFromSuperview];
    [bg removeFromSuperview];
    bg = nil;
    
    //    [self removeFromParentViewController];
    [self endAppearanceTransition];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self toggleSidebarMenu];
}

-(void) toggleSidebarMenu{
    [self toggleSidebarMenuExecuteAfterHideWithKey:nil];
}

-(void) toggleSidebarMenuExecuteAfterHideWithKey:(NSString*)key
{
    
    float nextX = 0;
    
    if ([sidebarState isEqualToString:@"Hide"] || sidebarState == nil)
    {
        [self addSidebar];
        sidebarState = @"Moving-Show";
        nextX = 0;
    }else if ([sidebarState isEqualToString:@"Show"]) {
        sidebarState = @"Moving-Hide";
        nextX = -[POPupSidebarVC sidebarWidth];
    }else{
        return;
    }
    
    
    [UIView animateWithDuration:0.35 animations:^{
        bg.alpha = nextX == 0 ? 0.3 : 0;
        self.view.frame = CGRectMake(nextX, 0, [POPupSidebarVC sidebarWidth], self.view.frame.size.height);
    } completion:^(BOOL completed){
        sidebarState = [sidebarState stringByReplacingOccurrencesOfString:@"Moving-" withString:@""];
        if ([sidebarState isEqualToString:@"Hide"]) {
            [self removeSidebar];
            
            if ([StringLib isValid:key])
            {
                
                if (_popUpSidebarDelegate != nil && [_popUpSidebarDelegate respondsToSelector:@selector(popUpDidSelectedItemWithKey:currentViewController:)])
                {
                    [_popUpSidebarDelegate popUpDidSelectedItemWithKey:key currentViewController:_currentRootViewController];
                }
                
                [_sidebarViewController executeActionWithKey:key currentRootViewController:_currentRootViewController exceptLastKey: !_isAllowReloadLastAction ];
            }
        }
        
        
    }];
}

-(void) executeActionWithKey:(NSString*)key exceptLastKey:(BOOL)exceptLastKey
{
    
    if (_popUpSidebarDelegate != nil && [_popUpSidebarDelegate respondsToSelector:@selector(popUpDidSelectedItemWithKey:currentViewController:)])
    {
        [_popUpSidebarDelegate popUpDidSelectedItemWithKey:key currentViewController:_currentRootViewController];
    }
    
    [_sidebarViewController executeActionWithKey:key currentRootViewController:_currentRootViewController exceptLastKey:exceptLastKey];
}

-(void) cleanup
{
    [_sidebarViewController cleanup];
    
    _sidebarViewController = nil;
    _popUpSidebarDelegate = nil;
    _sidebarMenuButton = nil;
    _currentRootViewController = nil;
    bg = nil;
    sidebarState = nil;
}


@end


//============================================================================================================
//============================================================================================================
//============================================================================================================


#define Action_Storyboard @"[Storyboard]"
#define Action_Storyboard_name @"storyboardname"
#define Action_Storyboard_id @"storyboardid"
#define Action_Storyboard_ispush @"ispush"

@implementation POPupMenuSidebarVC{
    NSMutableArray* datasource;
    NSMutableArray* sections;
    Hashtable* actions;
    BOOL isNavigationBarVisible;
}

-(void) viewDidLoad
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    if ([POPupSidebarVC Instance].customMenuItemSeparatorColor != nil) {
        _tableView.separatorColor = [POPupSidebarVC Instance].customMenuItemSeparatorColor;
    }else{
        [POPupSidebarVC Instance].customMenuItemSeparatorColor = _tableView.separatorColor;
    }
    
    
    [self.navigationController setNavigationBarHidden: !isNavigationBarVisible];
    if (isNavigationBarVisible && [POPupSidebarVC Instance].customNavigationBarBgColor != nil) {
        [ViewLib setNavigationBarColor:[POPupSidebarVC Instance].customNavigationBarBgColor viewController:self];
    }
    
    if ([POPupSidebarVC Instance].customMenuBgImage != nil) {
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[POPupSidebarVC Instance].customMenuBgImage];
    }else if ([POPupSidebarVC Instance].customMenuBgColor != nil) {
        self.tableView.backgroundColor = [POPupSidebarVC Instance].customMenuBgColor;
    }else if ([POPupSidebarVC Instance].sidebarType == POPupSidebarMenuTypeFlat){
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"POPupSidebar.bundle/SidebarBg"]];
    }
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.frame = self.view.frame;
}

-(void) viewDidLayoutSubviews{
    self.tableView.frame = self.view.frame;
}

-(void) setNavigationTitle:(NSString*)title
{
    self.title = title;
    isNavigationBarVisible = YES;
}

-(void) setNavigationItem:(UIView*)view position:(enum POPupSidebarNavigationPosition) position
{
    switch (position) {
        case POPupSidebarNavigationPositionLeft:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
            break;
        case POPupSidebarNavigationPositionRight:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
            break;
        case POPupSidebarNavigationPositionCenter:
            self.navigationItem.titleView = view;
            break;
    }
    
    isNavigationBarVisible = YES;
}

-(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image name:(NSString*)name detailText:(NSString*)detailText fontsize:(float)fontsize
{
    [self addMenuItemWithKey:key title:name image:image fontsize:fontsize];
    [self addOptionWithKey:key hashkey:@"type" value:@"profile"];
    [self addOptionWithKey:key hashkey:@"detailtext" value:detailText];
}

-(void) addMenuProfileWithKey:(NSString*)key image:(NSString*)image placeHolderImage:(NSString*)imageplaceholder name:(NSString*)name detailText:(NSString*)detailText fontsize:(float)fontsize
{
    [self addMenuItemWithKey:key title:name image:image fontsize:fontsize];
    [self addOptionWithKey:key hashkey:@"type" value:@"profile"];
    [self addOptionWithKey:key hashkey:@"detailtext" value:detailText];
    [self addOptionWithKey:key hashkey:@"imageplaceholder" value:imageplaceholder];
}

-(void) addMenuItemWithKey:(NSString*)key title:(NSString*)title image:(NSString*)image fontsize:(float)fontsize
{
    if (datasource == nil) {
        datasource = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray* ds = sections == nil ? datasource : [datasource objectAtIndex:sections.count-1];
    
    Hashtable* hashtable = [Hashtable new];
    NSInteger existedID = -1;
    
    for (int i = 0; i < ds.count; i++)
    {
        Hashtable* hash = [StringLib deparseString:ds[i]];
        if ([[hash hashtable_GetValueForKey:@"key"] isEqualToString:key])
        {
            existedID = i;
            hashtable = hash;
            break;
        }
    }
    
    [hashtable hashtable_AddValue:[title stringByReplacingOccurrencesOfString:@"&" withString:@"[AnD]"] forKey:@"title"];
    [hashtable hashtable_AddValue:image forKey:@"image"];
    [hashtable hashtable_AddValue:[NSString stringWithFormat:@"%f", fontsize] forKey:@"fontsize"];
    
    if (existedID >= 0) {
        ds[existedID] = [StringLib parseString: hashtable];
    }else{
        [hashtable hashtable_AddValue:key forKey:@"key"];
        [hashtable hashtable_AddValue:@"menu" forKey:@"type"];
        [ds addObject:[StringLib parseString: hashtable]];
    }
}

-(void) addMenuActionChangeViewWithKey:(NSString*)key storyboardName:(NSString*) storyboardName storyboardID:(NSString*)storyboardID displayStyle:(enum DisplayStyle) displayStyle
{
    if (actions == nil)
    {
        actions = [[Hashtable alloc] init];
    }
    
    if (!_lastActionKey) {
        _lastActionKey = key;
    }
    
    [actions hashtable_AddValue:[NSString stringWithFormat:@"action=%@&%@=%@&%@=%@&%@=%d", Action_Storyboard, Action_Storyboard_name, storyboardName, Action_Storyboard_id, storyboardID, Action_Storyboard_ispush, (int)displayStyle] forKey:key];
}

-(void) addLineBreak{
    [self addMenuItemWithKey:[FileLib getNewName:nil suffix:nil] title:@"[LINEBREAK]" image:@"" fontsize:0];
}

-(void) addSectionWithTitle:(NSString*)title
{
    if (sections == nil) {
        sections = [[NSMutableArray alloc] init];
    }
    
    if (datasource == nil) {
        datasource = [[NSMutableArray alloc] init];
    }
    
    [sections addObject:title];
    [datasource addObject:[[NSMutableArray alloc] init]];
}

-(NSIndexPath*) getMenuIndexWithKey:(NSString*)key
{
    NSInteger i = 0, j = 0;
    if (sections == nil) {
        for (NSString* item in datasource) {
            Hashtable* data = [StringLib deparseString:item];
            if ([[data hashtable_GetValueForKey:@"key"] isEqualToString:key]) {
                return [NSIndexPath indexPathForRow:i inSection:-1];
                break;
            }
            i++;
        }
    }else{
        for (NSMutableArray* ds in datasource) {
            i = 0;
            for (NSString* item in ds) {
                Hashtable* data = [StringLib deparseString:item];
                if ([[data hashtable_GetValueForKey:@"key"] isEqualToString:key]) {
                    
                    return [NSIndexPath indexPathForRow:i inSection:j];
                    
                    break;
                }
                i++;
            }
            j++;
        }
    }
    
    return [NSIndexPath indexPathForRow:-1 inSection:-1];
}


-(void) addNotificationWithMenuKey:(NSString*)key notificationText:(NSString*)text
{
    [self addOptionWithKey:key hashkey:@"notification" value:text];
}

-(void) addRoundCornerWithMenuKey:(NSString*)key cornerRadius:(CGFloat)cornerRadius
{
    [self addOptionWithKey:key hashkey:@"cornerRadius" value: [NSString stringWithFormat:@"%f", cornerRadius] ];
}

-(void) addOptionWithKey:(NSString*)key hashkey:(NSString*)hashkey value:(NSString*)value
{
    if (value == nil) value = @"";
    
    NSIndexPath* index = [self getMenuIndexWithKey:key];
    if (index.section == -1 && index.row == -1) return;
    
    if (index.section == -1){
        
        Hashtable* data = [StringLib deparseString: datasource[index.row]];
        [data hashtable_AddValue:value forKey:hashkey];
        
        datasource[index.row] = [StringLib parseString:data];
        return;
    }
    
    NSMutableArray* ds = [datasource objectAtIndex:index.section];
    
    Hashtable* data = [StringLib deparseString: ds[index.row]];
    [data hashtable_AddValue:value forKey:hashkey];
    
    ds[index.row] = [StringLib parseString:data];
}



-(void) removeMenuItemWithKey:(NSString*)key
{
    NSIndexPath* index = [self getMenuIndexWithKey:key];
    if (index.section == -1 && index.row == -1) return;
    
    if (index.section == -1){
        [datasource removeObjectAtIndex:index.row];
        return;
    }
    
    NSMutableArray* ds = [datasource objectAtIndex:index.section];
    [ds removeObjectAtIndex:index.row];
}


-(void) reloadMenu{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections == nil ? 1 : sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sections == nil ? datasource.count : [((NSMutableArray*)[datasource objectAtIndex:section]) count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    Hashtable* item = [StringLib deparseString: sections == nil ? datasource[indexPath.row] : datasource[indexPath.section][indexPath.row] ];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [POPupSidebarVC Instance].customMenuItemBgColor != nil ? [POPupSidebarVC Instance].customMenuItemBgColor : [UIColor clearColor];
    
    if ([[item hashtable_GetValueForKey:@"type"] isEqualToString:@"profile"])
    {
        NSString* imagePath = [item hashtable_GetValueForKey:@"image"];
        UIImageView* profileimage;
        
        if ([imagePath.lowercaseString hasPrefix:@"http"]) {
            profileimage = [UIImageView new];
            
            NSString* imageplaceholder = [item hashtable_GetValueForKey:@"imageplaceholder"];
            
            if ([StringLib isValid:imageplaceholder]) {
                
                [profileimage setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:imageplaceholder]];
            }else{
                [profileimage setImageWithURL:[NSURL URLWithString:imagePath]];
            }
            
        }else{
            profileimage = [FileLib checkPathExisted:imagePath] ? ImageViewWithPath(imagePath) : ImageViewWithImagename(imagePath);
        }
        
        CGFloat spacing = [POPupSidebarVC Instance].customProfileSpacing > 0 ? [POPupSidebarVC Instance].customProfileSpacing : profile_spacing;
        CGSize profilesize = [POPupSidebarVC Instance].customProfileImageSize > 0 ? CGSizeMake([POPupSidebarVC Instance].customProfileImageSize, [POPupSidebarVC Instance].customProfileImageSize) : profile_imageSize;
        
        if ([POPupSidebarVC Instance].customProfileBgImage != nil) {
            cell.backgroundView = ImageViewWithImage([POPupSidebarVC Instance].customProfileBgImage);
            ((UIImageView*)cell.backgroundView).contentMode = UIViewContentModeScaleToFill;
            ((UIImageView*)cell.backgroundView).frame = cell.frame;
        }
        
        
        profileimage.frame = CGRectMake( spacing , spacing, profilesize.width, profilesize.height);
        profileimage.clipsToBounds = YES;
        profileimage.layer.cornerRadius = profilesize.width/2;
        profileimage.layer.borderWidth = [POPupSidebarVC Instance].customProfileImageBorderWidth > 0 ? [POPupSidebarVC Instance].customProfileImageBorderWidth: 4;
        profileimage.layer.borderColor = [POPupSidebarVC Instance].customProfileImageBorderColor != nil ? [[POPupSidebarVC Instance].customProfileImageBorderColor CGColor] : [[CommonLib colorFromHexString:@"FFFFFF" alpha:.5] CGColor];
        [cell addSubview:profileimage];
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(spacing, profileimage.frame.origin.y + profileimage.frame.size.height + profile_textSpacing, [POPupSidebarVC sidebarWidth], profile_titleHeight)];
        title.text = [item hashtable_GetValueForKey:@"title"];
        title.textColor = [POPupSidebarVC Instance].customProfileTextColor != nil ? [POPupSidebarVC Instance].customProfileTextColor : [UIColor grayColor];
        [title setFont:[UIFont boldSystemFontOfSize:title.font.pointSize]];
        [cell addSubview:title];
        
        if ( [StringLib isValid:[item hashtable_GetValueForKey:@"detailtext"]]) {
            UILabel* detail = [[UILabel alloc] initWithFrame:CGRectMake(spacing, title.frame.origin.y + title.frame.size.height + profile_textSpacing, [POPupSidebarVC sidebarWidth], profile_detailHeight)];
            detail.text = [item hashtable_GetValueForKey:@"detailtext"];
            detail.textColor = [POPupSidebarVC Instance].customProfileDetailTextColor != nil ? [POPupSidebarVC Instance].customProfileDetailTextColor : [UIColor grayColor];
            [cell addSubview:detail];
        }
        
        return cell;
    }
    
    if ([[item hashtable_GetValueForKey:@"title"] isEqualToString:@"[LINEBREAK]"])
    {
        cell.backgroundColor = [POPupSidebarVC Instance].customLineBreakBgColor == nil ? [UIColor grayColor] : [POPupSidebarVC Instance].customLineBreakBgColor;
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        return cell;
    }
    
    //for hide row before
    //    Hashtable* nextitem = [StringLib deparseString: sections == nil ? (datasource.count > indexPath.row + 1 ? datasource[indexPath.row + 1] : nil) : ( [datasource[indexPath.section] count] > indexPath.row+1 ? datasource[indexPath.section][indexPath.row+1] : nil) ];
    //    if(nextitem == nil || (nextitem != nil && nextitem.count > 0 && [[nextitem hashtable_GetValueForKey:@"title"] isEqualToString:@"[LINEBREAK]"]))
    //    {
    //        cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 1000);
    //    }
    
    if ([POPupSidebarVC Instance].sidebarType == POPupSidebarMenuTypeFlat) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [POPupSidebarVC Instance].customMenuItemTextColor != nil ? [POPupSidebarVC Instance].customMenuItemTextColor : [CommonLib colorFromHexString:@"606366" alpha:1];
        
        if ([_lastActionKey isEqualToString:[item hashtable_GetValueForKey:@"key"]])
        {
            cell.backgroundColor = [POPupSidebarVC Instance].customMenuItemActiveBgColor != nil ? [POPupSidebarVC Instance].customMenuItemActiveBgColor : [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = [POPupSidebarVC Instance].customMenuItemActiveTextColor != nil ? [POPupSidebarVC Instance].customMenuItemActiveTextColor : [UIColor blackColor];
        }
    }
    
    
    //custom icon and title
    UIView* iconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GC_ScreenWidth, 100)];
    [cell.contentView addSubview:iconContainer];
    [iconContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:[POPupSidebarVC Instance].customMenuItemIconPaddingLeft];
    [iconContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [iconContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [iconContainer autoSetDimension:ALDimensionWidth toSize:[POPupSidebarVC Instance].customMenuItemIconContainerWidth > 0 ? [POPupSidebarVC Instance].customMenuItemIconContainerWidth : cell.frame.size.height];
    
    UIImageView* iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GC_ScreenWidth, 100)];
    [iconContainer addSubview:iconView];
    [iconView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [iconView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    NSString* image = [item hashtable_GetValueForKey:@"image"];
    if ([StringLib isValid:image]){
        
        if ([FileLib checkPathExisted:image]) {
            iconView.image = [UIImage imageWithContentsOfFile:image];
        }else{
            iconView.image = [UIImage imageNamed:image];
        }
        
        if ([item.keys containsObject:@"cornerRadius"]) {
            iconView.clipsToBounds = YES;
            iconView.layer.cornerRadius = [[item hashtable_GetValueForKey:@"cornerRadius"] floatValue];
        }
        [iconView autoSetDimensionsToSize:iconView.image.size];
    }
    else iconView.image = nil;
    
    
    UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GC_ScreenWidth, 100)];
    [cell.contentView addSubview:titleView];
    [titleView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [titleView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [titleView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [titleView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconContainer withOffset:[POPupSidebarVC Instance].customMenuItemTitlePaddingLeft];
    
    NSString* fontsize = [item hashtable_GetValueForKey:@"fontsize"];
    if ([StringLib isValid:fontsize] && [fontsize floatValue] > 0) {
        titleView.font = [UIFont fontWithName:titleView.font.fontName size:[fontsize floatValue] ];
    }
    
    titleView.text = LocalizedText([[item hashtable_GetValueForKey:@"title"] stringByReplacingOccurrencesOfString:@"[AnD]" withString:@"&"],nil);
    
    
    
    
    
    
    
    UILabel* notificationLabel = cell.accessoryView == nil ? nil : (UILabel*)cell.accessoryView;
    if ([item.keys containsObject:@"notification"])
    {
        if (cell.accessoryView == nil)
        {
            notificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
            notificationLabel.backgroundColor = [POPupSidebarVC Instance].customMenuNotificationBgColor != nil ? [POPupSidebarVC Instance].customMenuNotificationBgColor : [UIColor whiteColor];
            notificationLabel.textColor = [POPupSidebarVC Instance].customMenuNotificationTextColor != nil ? [POPupSidebarVC Instance].customMenuNotificationTextColor : [UIColor blackColor];
            notificationLabel.textAlignment = NSTextAlignmentCenter;
            notificationLabel.font = cell.textLabel.font;
            notificationLabel.layer.masksToBounds = YES;
            notificationLabel.layer.cornerRadius = 12.5;
            cell.accessoryView = notificationLabel;
        }
        
        
        
        [notificationLabel setHidden:NO];
        notificationLabel.text = [item hashtable_GetValueForKey:@"notification"];
        if (notificationLabel.text.length > 2) {
            notificationLabel.frame = CGRectMake(0, 0, 25 + ((notificationLabel.text.length-2) * 10) , 25);
        }
        
        if(notificationLabel.text.integerValue == 0) notificationLabel.hidden = YES;
    }
    else if(notificationLabel != nil)
    {
        [notificationLabel setHidden:YES];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //for hide row before
    Hashtable* nextitem = [StringLib deparseString: sections == nil ? (datasource.count > indexPath.row + 1 ? datasource[indexPath.row + 1] : nil) : ( [datasource[indexPath.section] count] > indexPath.row+1 ? datasource[indexPath.section][indexPath.row+1] : nil) ];
    if(nextitem == nil || (nextitem != nil && nextitem.count > 0 && [[nextitem hashtable_GetValueForKey:@"title"] isEqualToString:@"[LINEBREAK]"]))
    {
        tableView.separatorColor = [POPupSidebarVC Instance].customMenuItemSeparatorColor;
    }else{
        tableView.separatorColor = [UIColor clearColor];
    }
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hashtable* item = [StringLib deparseString: sections == nil ? datasource[indexPath.row] : datasource[indexPath.section][indexPath.row] ];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* key = [item hashtable_GetValueForKey:@"key"];
    
    if (![StringLib isValid:key]) {
        return;
    }
    
    if (_popUpSidebarDelegate != nil && [_popUpSidebarDelegate respondsToSelector:@selector(popUpDidSelectedItemWithKey:currentViewController:)])
    {
        [_popUpSidebarDelegate popUpDidSelectedItemWithKey: key currentViewController: nil ];
    }
}


-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (sections == nil) return nil;
    
    UILabel* lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
    lb.backgroundColor = [POPupSidebarVC Instance].customSectionBgColor == nil ? [UIColor grayColor] : [POPupSidebarVC Instance].customSectionBgColor;
    lb.textColor = [POPupSidebarVC Instance].customSectionTextColor == nil ? [UIColor blackColor] : [POPupSidebarVC Instance].customSectionTextColor;
    [lb setText:sections[section]];
    return lb;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (sections == nil) return 0;
    if ([StringLib isValid:sections[section]])
    {
        if ([sections[section] isEqualToString:@"[DISABLE]"]) {
            return 0;
        }
        
        return [POPupSidebarVC Instance].customMenuHeight > 0 ? [POPupSidebarVC Instance].customMenuHeight : 40;
    }
    return [POPupSidebarVC Instance].customLineBreakHeight > 0 ? [POPupSidebarVC Instance].customLineBreakHeight : 5;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hashtable* item = [StringLib deparseString: sections == nil ? datasource[indexPath.row] : datasource[indexPath.section][indexPath.row] ];
    
    if ([[item hashtable_GetValueForKey:@"title"] isEqualToString:@"[LINEBREAK]"])
    {
        return [POPupSidebarVC Instance].customLineBreakHeight > 0 ? [POPupSidebarVC Instance].customLineBreakHeight : 5;
    }
    
    if ([[item hashtable_GetValueForKey:@"type"] isEqualToString:@"profile"])
    {
        CGFloat spacing = [POPupSidebarVC Instance].customProfileSpacing > 0 ? [POPupSidebarVC Instance].customProfileSpacing : profile_spacing;
        CGSize profilesize = [POPupSidebarVC Instance].customProfileImageSize > 0 ? CGSizeMake([POPupSidebarVC Instance].customProfileImageSize, [POPupSidebarVC Instance].customProfileImageSize) : profile_imageSize;
        
        if ( [StringLib isValid:[item hashtable_GetValueForKey:@"detailtext"]]) {
            return profilesize.height + (spacing*2) + profile_titleHeight + profile_detailHeight + (profile_textSpacing*2);
        }
        
        return profilesize.height + (spacing*2) + profile_titleHeight + profile_textSpacing;
    }
    
    return [POPupSidebarVC Instance].customMenuHeight > 0 ? [POPupSidebarVC Instance].customMenuHeight : 40;
}


-(void) executeActionWithKey:(NSString*)key currentRootViewController:(UIViewController*)currentRootViewController exceptLastKey:(BOOL)exceptLastKey
{
    if (exceptLastKey && [_lastActionKey isEqualToString:key]) {
        return;
    }
    
    NSString* value = [actions hashtable_GetValueForKey:key];
    if(value == nil) return;
    Hashtable* action_hash = [StringLib deparseString:value];
    
    NSString* action = [action_hash hashtable_GetValueForKey:@"action"];
    
    if (![StringLib isValid:action]) {
        return;
    }
    
    enum DisplayStyle displayStyle = (enum DisplayStyle)[[action_hash hashtable_GetValueForKey:Action_Storyboard_ispush] integerValue];
    
    if ([action isEqualToString:Action_Storyboard])
    {
        [self presentViewWithStorboardName:[action_hash hashtable_GetValueForKey:Action_Storyboard_name] storyboardViewID:[action_hash hashtable_GetValueForKey:Action_Storyboard_id] currentViewController:currentRootViewController displayStyle:displayStyle];
    }
    
    if(displayStyle == DisplayStyleReplaceNavigationRootVC || displayStyle == DisplayStyleReplaceWindowRootVC) _lastActionKey = key;
}


-(void)presentViewWithStorboardName:(NSString*)storyboardName storyboardViewID:(NSString*)viewID currentViewController:(UIViewController*)viewController displayStyle:(enum DisplayStyle) displayStyle
{
    [ViewLib presentViewWithStorboardName:storyboardName storyboardViewID:viewID currentViewController:viewController displayStyle:displayStyle prepareBlock:nil completeBlock:^{
        if(displayStyle == DisplayStyleReplaceNavigationRootVC || displayStyle == DisplayStyleReplaceWindowRootVC) [self reloadMenu];
    }];
}

-(void) cleanup{
    _popUpSidebarDelegate = nil;
    _tableView = nil;
    _lastActionKey = nil;
    
    datasource = nil;
    sections = nil;
    actions = nil;
}



@end





