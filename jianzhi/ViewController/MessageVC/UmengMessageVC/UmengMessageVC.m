//
//  UmengMessageVC.m
//  jianzhi
//
//  Created by li on 15/5/5.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "UmengMessageVC.h"
#import "FaceBoard.h"
#import "NSObject+UIViewCate.h"
#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"
#import "UmengCell.h"
@interface UmengMessageVC ()
{
    UITextField *messageTextField;
    FaceBoard *_faceBoard;
    UITextField *field;
    UIButton* imgbuttom;
}
@end

@implementation UmengMessageVC
-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray=[[NSMutableArray alloc] init];
    }
    return _mutableArray;
}
-(NSMutableArray *)chatArray
{
    if (!_chatArray) {
        _chatArray=[[NSMutableArray alloc] init];
    }
    return _chatArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle600"]];
    self.umTableView.backgroundView=nil;
    self.umTableView.backgroundColor=[UIColor clearColor];
    self.umTableView.separatorStyle = NO;
    [UMFeedback setAppkey:umAppKey];
    self.feedback = [UMFeedback sharedInstance];
    self.feedback.delegate = self;
    [self chatViewShow];
    self.navigationItem.titleView = [CommUtils navTittle:@"消息"];
//    [[UMFeedback sharedInstance] updateUserInfo:@{@"contact": @{@"qq": @"932993782",@"email": @"limeng@163.com",@"phone": @"13385336115",@"plain": @"very good"}}];
    
    //[self.feedback get];
    //UMFeedback *feedback = [UMFeedback sharedInstance];
    [_feedback get];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
}
#pragma mark- 返回
-(void)backMethod
{
    LM_POP;
}
#pragma mark - UMFeedback Delegate

- (void)getFinishedWithError:(NSError *)error {
    NSLog(@"%s", __func__);
    if (error != nil) {
        NSLog(@"%@", error);
    } else {
        [_mutableArray removeAllObjects];
        [_chatArray removeAllObjects];
        NSLog(@"%@", self.feedback.topicAndReplies);
        //_mutableArray=self.feedback.topicAndReplies;
        [_mutableArray addObjectsFromArray:self.feedback.topicAndReplies];
        for (NSDictionary *dict in _mutableArray){
            NSString *type=[dict objectForKey:@"type"];
            if ([type isEqualToString:@"dev_reply"]){
                NSLog(@"开发者回复");
                NSString *infor=[dict objectForKey:@"content"];
                UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@:%@",@"other", infor]
                                               from:NO];
                [self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:infor, @"text", @"other", @"speaker", chatView, @"view", nil]];
            }else{
                NSLog(@"用户回复");
                NSString *infor=[dict objectForKey:@"content"];
                UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@:%@", NSLocalizedString(@"me",nil), infor] from:YES];
                [self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:infor, @"text", @"self", @"speaker", chatView, @"view", nil]];
            }
        }
        [self.umTableView reloadData];
    }
}

- (void)postFinishedWithError:(NSError *)error {
    NSLog(@"%s", __func__);
    if (error != nil) {
        NSLog(@"%@", error);
    } else {
        NSLog(@"%@", self.feedback.topicAndReplies);
//        [_mutableArray removeAllObjects];
        [_chatArray removeAllObjects];
        _mutableArray=self.feedback.topicAndReplies;
        for (NSDictionary *dict in _mutableArray){
            NSString *type=[dict objectForKey:@"type"];
            if ([type isEqualToString:@"dev_reply"]){
                NSLog(@"开发者回复");
                NSString *infor=[dict objectForKey:@"content"];
                UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@:%@",@"other", infor]
                                               from:NO];
                [self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:infor, @"text", @"other", @"speaker", chatView, @"view", nil]];
            }else{
                NSLog(@"用户回复");
                NSString *infor=[dict objectForKey:@"content"];
                UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@:%@", NSLocalizedString(@"me",nil), infor] from:YES];
                [self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:infor, @"text", @"self", @"speaker", chatView, @"view", nil]];
            }
        }
        [self.umTableView reloadData];
    }
}
#pragma mark - tableView代理方法
#pragma mark - tableview代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *chatView = [[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"view"];
    return chatView.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"UmengCell";
    UmengCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"UmengCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *chatInfo = [self.chatArray objectAtIndex:[indexPath row]];
    UIView *chatView = [chatInfo objectForKey:@"view"];
    [cell.contentView addSubview:chatView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 加载自定义聊天
-(void)chatViewShow
{
    //监听键盘高度的变换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 键盘高度变化通知，ios5.0新增的
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
    //============
    UIToolbar* toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, mainscreenhight-105, 320*VIEWWITH, 44)];
    [toolbar setBackgroundImage:[UIImage imageNamed:@"Rectangle 586"] forToolbarPosition:0 barMetrics:0];
    [self.view addSubview:toolbar];
    //[toolbar setBarStyle:UIBarStyleBlackOpaque];
    toolbar.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin;
    imgbuttom=[UIButton buttonWithType:UIButtonTypeCustom];
    imgbuttom.frame=CGRectMake(0,7, 25, 25);
    [imgbuttom setImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    [imgbuttom setImage:[UIImage imageNamed:@"face"] forState:UIControlStateSelected];
    [imgbuttom setSelected:YES];
    [imgbuttom addTarget:self action:@selector(showPhraseInfo:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* imgItem=[[UIBarButtonItem alloc]initWithCustomView:imgbuttom];
    
    messageTextField=[[UITextField alloc]initWithFrame:CGRectMake(35*VIEWWITH, 7, 210*VIEWWITH, 26)];
    messageTextField.delegate=self;
    messageTextField.textColor=[UIColor whiteColor];
    UIImageView* preFie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Rectangle 14"]];
    preFie.frame=CGRectMake(0, 0, 210*VIEWWITH, 26);
    [messageTextField addSubview:preFie];
    [messageTextField setBorderStyle:UITextBorderStyleRoundedRect];
    UIBarButtonItem* fieldItem=[[UIBarButtonItem alloc]initWithCustomView:messageTextField];
    UIButton* sendbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [sendbutton setImage:[UIImage imageNamed:@"Qsent"] forState:UIControlStateNormal];
    sendbutton.frame=CGRectMake(240*VIEWWITH, 7, 51, 26);
    [sendbutton addTarget:self action:@selector(sendMessage_Click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* sendItem=[[UIBarButtonItem alloc]initWithCustomView:sendbutton];
    [toolbar setItems:[NSArray arrayWithObjects:imgItem,fieldItem,sendItem, nil]];
    _faceBoard = [[FaceBoard alloc]init];
    field=[[UITextField alloc] init];
    [self.view addSubview:field];
}
#pragma mark - 发送消息
-(void)sendMessage_Click:(id)sender
{
    [messageTextField resignFirstResponder];
    NSDictionary *postContent = @{@"content":messageTextField.text,
                                  @"gender":@"1",
                                  @"age_group":@"3",
                                  @"type": @"user_reply",
                                  };
    [[UMFeedback sharedInstance] post:postContent];
    messageTextField.text=@"";
}
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.view animateView:YES withMovement:keyBoardFrame.size.height-65];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.view animateView:NO withMovement:65];
}
//选择系统表情
#pragma mark - 选择系统表情
-(void)showPhraseInfo:(id)sender
{
    UIButton* button=(UIButton*)sender;
    if (button.selected) {
        [button setSelected:NO];
        [messageTextField resignFirstResponder];
        [self keyboardDidHide:nil];
    }
    else
    {
        [button setSelected:YES];
        [messageTextField becomeFirstResponder];
    }
}
- (void)keyboardDidHide:(NSNotification*)notification {
    _faceBoard.inputTextView =(UITextView*)messageTextField;
    
    field.inputView = _faceBoard;
    [field becomeFirstResponder];
}
/*
 生成泡泡UIView
 */
#pragma mark -
#pragma mark Table view methods
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf {
    // build single chat bubble cell with given text
    UIView *returnView =  [self assembleMessageAtIndex:text from:fromSelf];
    returnView.backgroundColor = [UIColor clearColor];
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor clearColor];
    
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"MessageRight":@"MessageLeft" ofType:@"png"]];
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:fromSelf?[bubble stretchableImageWithLeftCapWidth:10 topCapHeight:5]:[bubble stretchableImageWithLeftCapWidth:15 topCapHeight:10]];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    
    if(fromSelf){
        [headImageView setImage:[UIImage imageNamed:@"face_test.png"]];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[CommUtils readUser].figure_url]] placeholderImage:[UIImage imageNamed:@""]];
        returnView.frame= CGRectMake(9.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height);
        bubbleImageView.frame = CGRectMake(0.0f, 14.0f, returnView.frame.size.width+24.0f*VIEWWITH, returnView.frame.size.height+24.0f );
        cellView.frame = CGRectMake(255.0f*VIEWWITH-bubbleImageView.frame.size.width, 0.0f,bubbleImageView.frame.size.width+50.0f, bubbleImageView.frame.size.height+30.0f);
        headImageView.frame = CGRectMake(bubbleImageView.frame.size.width+10*VIEWWITH, cellView.frame.size.height-40.0f, 35.0f, 35.0f);
    }
    else{
        [headImageView setImage:[UIImage imageNamed:@"jianzhijiejie"]];
        returnView.frame= CGRectMake(65.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height);
        bubbleImageView.frame = CGRectMake(50.0f, 14.0f, returnView.frame.size.width+24.0f, returnView.frame.size.height+24.0f);
        cellView.frame = CGRectMake(0.0f, 0.0f, bubbleImageView.frame.size.width+30.0f,bubbleImageView.frame.size.height+30.0f);
        headImageView.frame = CGRectMake(10.0f*VIEWWITH, cellView.frame.size.height-40.0f, 35.0f, 35.0f);
    }
    
    
    
    [cellView addSubview:bubbleImageView];
    [cellView addSubview:headImageView];
    [cellView addSubview:returnView];
    
    return cellView;
    
}
#pragma mark - 图文混排
//图文混排

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [array addObject:message];
    }
}

#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH 150*VIEWWITH
-(UIView *)assembleMessageAtIndex : (NSString *) message from:(BOOL)fromself
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            NSLog(@"str--->%@",str);
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = 150;
                    Y = upY;
                }
                NSLog(@"str(image)---->%@",str);
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                upX=KFacialSizeWidth+upX;
                if (X<150) X = upX;
                
                
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MAX_WIDTH)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = 150;
                        Y =upY;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(150, 40)];
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:la];
                    upX=upX+size.width;
                    if (X<150) {
                        X = upX;
                    }
                }
            }
        }
    }
    returnView.frame = CGRectMake(15.0f,1.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    NSLog(@"%.1f %.1f", X, Y);
    return returnView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
