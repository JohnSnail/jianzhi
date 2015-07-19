//
//  DisscussVC.m
//  jianzhi
//
//  Created by li on 15/4/15.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "DisscussVC.h"
#import "FaceBoard.h"
#import "NSObject+UIViewCate.h"
#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"
#import "DisscussCell.h"
@interface DisscussVC ()
{
    UITextField *messageTextField;
    FaceBoard *_faceBoard;
    UITextField *field;
    UIButton* imgbuttom;
    NSInteger pageNumber;
}

@end

@implementation DisscussVC
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
    LMNOTMAINSCREEN;
    [self example];
    self.disTableView.separatorStyle = NO;
    self.navigationItem.titleView = [CommUtils navTittle:@"评论"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle600"]];
    self.disTableView.backgroundView=nil;
    self.disTableView.backgroundColor=[UIColor clearColor];
    [self chatViewShow];
    [self setUpForDismissKeyboard];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
}
#pragma mark- 返回
-(void)backMethod
{
    LM_POP;
}
#pragma mark - 刷新方法
- (void)example
{
    //__weak typeof(self) weakSelf = self;
    
    [self.disTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
    // 隐藏时间
    //隐藏时间显示
    //self.businessTableview.header.updatedTimeHidden = YES;
    // 马上进入刷新状态
    [self.disTableView.header beginRefreshing];
    self.disTableView.header.hidden=YES;
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.disTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore:)];
}
-(void)loadMore:(id)my
{
    pageNumber++;
    [self getNetwork];
}
-(void)loadNewData:(id)mjrefresh
{
    pageNumber=0;
    [self getNetwork];
}
#pragma mark - 获取数据
-(void)getNetwork
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@job/comment",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"输出返回评论内容%@",results);
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                NSArray *array=[results objectForKey:@"comment"];
                NSMutableArray *muArray=[Manager dataAnalysisArray:@"CommentModel" andArray:array];
                [weakSelf.mutableArray addObjectsFromArray:muArray];
                [weakSelf noDateArray:array];
            }else
            {
                [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}
-(void)noDateArray:(NSArray *)array
{
    [self.disTableView.footer endRefreshing];
    [self.disTableView.header endRefreshing];
    [self.disTableView reloadData];
    if (array.count<20) {
        [self.disTableView.footer noticeNoMoreData];
    }
}
-(void)sendMessageToServer:(NSString *)message
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":[CommUtils getVersion],@"content":message};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@comment/job",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                pageNumber=0;
                [weakSelf.mutableArray removeAllObjects];
                [weakSelf getNetwork];
            }else
            {
                [Manager textNoSpace:[NSString stringWithFormat:@"%@",[results objectForKey:@"msg"]]];
            }
            
        }else
        {
            TLog(@"ERROR: %@", error);
        }
    }];
}
#pragma mark - 初始化视图 聊天界面
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
    
    messageTextField=[[UITextField alloc]initWithFrame:CGRectMake(35, 7, 200*VIEWWITH, 26)];
    messageTextField.delegate=self;
    UIImageView* preFie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Rectangle 14"]];
    preFie.frame=CGRectMake(0, 0, 200*VIEWWITH, 26);
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
#pragma mark 键盘弹出，弹下代理方法
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

-(void)sendMessage_Click:(id)sender
{
    [self sendMessageToServer:messageTextField.text];
    messageTextField.text=@"";
    messageTextField.inputView=nil;
    [field resignFirstResponder];
    [messageTextField resignFirstResponder];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#define MAX_WIDTH 220*VIEWWITH
-(UIView *)assembleMessageAtIndex : (NSString *) message
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
#pragma mark - tableView代理方法
#pragma mark - tableview代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model=[self.mutableArray objectAtIndex:indexPath.row];
    CGRect textRect = [[NSString stringWithFormat:@"%@",model.content] boundingRectWithSize:CGSizeMake(220.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HiraKakuProN-W3" size:14]} context:nil];
    TLog(@"输出评论高度%lf",textRect.size.height);
    return  textRect.size.height+50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"DisscussCell";
    DisscussCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"DisscussCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    CommentModel *model=[self.mutableArray objectAtIndex:indexPath.row];
    [cell showData:model];
    UIView *titleLable = [self assembleMessageAtIndex:[NSString stringWithFormat:@"%@",model.content]];
    titleLable.frame=CGRectMake(74*VIEWWITH, 32*VIEWWITH, mainscreenwidth-40, 60);
    titleLable.backgroundColor=[UIColor clearColor];
    [cell.titleView addSubview:titleLable];
    CGRect textRect = [[NSString stringWithFormat:@"%@",model.content] boundingRectWithSize:CGSizeMake(220.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HiraKakuProN-W3" size:14]} context:nil];
    TLog(@"输出评论高度%lf",textRect.size.height);
    cell.backGround.frame=CGRectMake(0, 0, mainscreenwidth, textRect.size.height+50);
    //UIView *chatView = [chatInfo objectForKey:@"view"];
    //[cell.contentView addSubview:chatView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
