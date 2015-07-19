//
//  JoinerVC.m
//  jianzhi
//
//  Created by li on 15/6/1.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "JoinerVC.h"
#import "JoinerCell.h"
@interface JoinerVC ()
{
    NSInteger pageNumber;
}
@end

@implementation JoinerVC
-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray=[[NSMutableArray alloc] init];
    }
    return _mutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommUtils navTittle:@"小伙伴列表"];
    pageNumber=1;
    [self example];
    self.joinerTable.separatorStyle = NO;
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
    
    [self.joinerTable addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
    // 隐藏时间
    //隐藏时间显示
    //self.businessTableview.header.updatedTimeHidden = YES;
    // 马上进入刷新状态
    [self.joinerTable.header beginRefreshing];
    self.joinerTable.header.hidden=YES;
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.joinerTable addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore:)];
}
-(void)loadMore:(id)my
{
    pageNumber++;
    [self getNetworkData:pageNumber andSize:20];
}
-(void)loadNewData:(id)mjrefresh
{
    pageNumber=1;
    [self getNetworkData:pageNumber andSize:20];
}
#pragma mark - 加载数据
-(void)getNetworkData:(NSInteger)page andSize:(NSInteger)size
{
    //,@"user_token":[CommUtils getUserKey]
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"device_token":[CommUtils getMobileKey],@"user_token":[CommUtils getUserKey],@"job_id":_jobId,@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@job/apply_user",PartyAPI];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"输出modle数组%@",results);
            if ([[results objectForKey:@"code"] intValue]==0)
            {
                if (pageNumber==1) {
                    [weakSelf.mutableArray removeAllObjects];
                }
                NSArray *array=[results objectForKey:@"apply_user"];
                NSMutableArray *muArray=[Manager dataAnalysisArray:@"ApplyUserModel" andArray:array];
                
                [weakSelf.mutableArray addObjectsFromArray:muArray];
                TLog(@"输出modle数组%@",weakSelf.mutableArray);
                [weakSelf noDateArray:array];
            }
        }else
        {
            TLog(@"ERROR: %@", error);
            //[weakSelf noDateArray:nil];
        }
    }];
}
-(void)noDateArray:(NSArray *)array
{
    [self.joinerTable.footer endRefreshing];
    [self.joinerTable.header endRefreshing];
    [self.joinerTable reloadData];
    if (array.count<20) {
        [self.joinerTable.footer noticeNoMoreData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"JoinerCell";
    JoinerCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"JoinerCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    //cell.textLabel.text=@"显示数据";
    ApplyUserModel *model=[self.mutableArray objectAtIndex:indexPath.section];
    [cell showDate:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
