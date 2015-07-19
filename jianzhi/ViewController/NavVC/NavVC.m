//
//  NavVC.m
//  jianzhi
//
//  Created by li on 15/4/9.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "NavVC.h"
#import "CommendCell.h"
#import "DropDownListView.h"
#import "DetailVC.h"

#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@interface NavVC ()
{
    NSInteger count;
    NSInteger pageNumber;
    NSMutableArray *chooseArray ;
    int dAreaId;
    int dTypeId;
    int dSmartId;
}
@end

@implementation NavVC

-(NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        count=0;
        pageNumber=1;dAreaId=0;dTypeId=0;dSmartId=0;
        _mutableArray=[[NSMutableArray alloc] init];
    }
    return _mutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [CommUtils navTittle:@"发现"];
    _mutableArray=[[NSMutableArray alloc] init];
    [self example];
    [self showHeaderView];
    [self getlocation];
    self.navigationItem.leftBarButtonItem=[LocolData setCityTitle:@"北京" Action:@selector(cityMethod) Target:self];
}
-(void)cityMethod
{
    
}

-(void)showHeaderView
{
    //[@"全城",@"东城区",@"西城区",@"崇文区",@"宣武区",@"朝阳区",@"丰台区",@"石景山区",@"海淀区",@"门头沟区",@"房山区",@"通州区",@"顺义区",@"昌平区",@"大兴区",@"怀柔区",@"平谷区",@"密云县",@"延庆县"]
    
    __weak typeof(self) weakSelf = self;
    [ClassManager getCityArearesponse:^(NSArray *array){
        chooseArray = [NSMutableArray arrayWithArray:@[array,@[@"全部类型",@"客服",@"演出",@"家教",@"模特",@"派单",@"文员",@"设计",@"校内",@"临时工",@"服务员",@"促销",@"安保",@"翻译",@"礼仪",@"销售",@"其他"],@[@"智能排序",@"离我最近",@"工资最高",@"周末兼职",@"只看日结"]]];
        DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, mainscreenwidth, 40) dataSource:weakSelf delegate:weakSelf];
        dropDownView.mSuperView = self.view;
        [weakSelf.view addSubview:dropDownView];
        
    }];
    
}

#pragma mark - 加载数据
-(void)getNetworkData:(NSInteger)page andSize:(NSInteger)size andAreaid:(int)areaid andJobType:(int)type andSmart:(int)smart
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters = @{@"page_size":@(size),@"page":@(page),@"device_token":[CommUtils getMobileKey],@"city_id":[ClassModel LMAppModel].city_id,@"version":@"1.0",@"area_id":@(areaid),@"type_id":@(type),@"smart_id":@(smart),@"lat":[NSString stringWithFormat:@"%f",self.lat],@"lng":[NSString stringWithFormat:@"%f",self.lng],@"version":[CommUtils getVersion]};
    TLog(@"输出请求内容%@",parameters);
    NSString *stringurl=[NSString stringWithFormat:@"%@job/search",PartyAPI];
    TLog(@"输出请求url地址%@",stringurl);
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"输出返回内容%@",results);
            NSDictionary *dict=[results objectForKey:@"data"];
            if ((NSNull *)dict != [NSNull null])
            {
                if ([[results objectForKey:@"code"] intValue]==0) {
                    NSArray *array=[results objectForKey:@"jobs"];
                    if(pageNumber==1){
                        [weakSelf.mutableArray removeAllObjects];
                    }
                    NSMutableArray *muArray=[Manager dataAnalysisArray:@"JobListModel" andArray:array];
                    TLog(@"输出modle数组%@",muArray);
                    [weakSelf.mutableArray addObjectsFromArray:muArray];
                    TLog(@"输出modle数组%@",weakSelf.mutableArray);
                    [weakSelf noDataArray:array];
                }
            }
        }else
        {
            [weakSelf noDataArray:nil];
            TLog(@"ERROR: %@", error);
        }
        
    }];
}
-(void)noDataArray:(NSArray *)array
{
    [self.commendTable.footer endRefreshing];
    [self.commendTable.header endRefreshing];
    [self.commendTable reloadData];
    if (array.count<20) {
        [self.commendTable.footer noticeNoMoreData];
    }
}
#pragma mark - 刷新方法
- (void)example
{
    //__weak typeof(self) weakSelf = self;
    
    [self.commendTable addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
    // 隐藏时间
    //self.businessTableview.header.updatedTimeHidden = YES;
    // 马上进入刷新状态
    [self.commendTable.header beginRefreshing];
    //self.commendTable.header.hidden=YES;
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.commendTable addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore:)];
}
-(void)loadMore:(id)my
{
    pageNumber++;
    [self getNetworkData:pageNumber andSize:20 andAreaid:dAreaId andJobType:dTypeId andSmart:dSmartId];
}
-(void)loadNewData:(id)mjrefresh
{
    pageNumber=1;
    [self getNetworkData:pageNumber andSize:20 andAreaid:dAreaId andJobType:dTypeId andSmart:dSmartId];
}
#pragma mark - 定位城市
-(void)getlocation
{
    _locationmanager = [[CLLocationManager alloc]init];
    
    //设置精度
    /*
     kCLLocationAccuracyBest
     kCLLocationAccuracyNearestTenMeters
     kCLLocationAccuracyHundredMeters
     kCLLocationAccuracyHundredMeters
     kCLLocationAccuracyKilometer
     kCLLocationAccuracyThreeKilometers
     */
    //设置定位的精度
    [_locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    //实现协议
    _locationmanager.delegate = self;
    //TLog(@"开始定位");
    //开始定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationmanager requestWhenInUseAuthorization];
    [_locationmanager startUpdatingLocation];
}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    // NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    if (((int)self.lat==0)&&((int)self.lng==0)) {
        self.lat=coordinate.latitude;
        self.lng=coordinate.longitude;
        [self loadNewData:nil];
    }else
    {
        self.lat=coordinate.latitude;
        self.lng=coordinate.longitude;
    }
    [_locationmanager stopUpdatingLocation];
}

#pragma mark - tableview代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    TLog(@"输出modle数组%lu",(unsigned long)self.mutableArray.count);
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
    static NSString *notice=@"CommendCell";
    CommendCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"CommendCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JobListModel *model=[self.mutableArray objectAtIndex:indexPath.section];
    [cell showData:model];
    //    BureauListModel *model=[self.mutableArray objectAtIndex:indexPath.section];
    //    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobListModel *model=[self.mutableArray objectAtIndex:indexPath.section];
    if (model.id.integerValue != 0) {
        DetailVC *vc=LM_CREATE_OBJECT(DetailVC);
        vc.hidesBottomBarWhenPushed=YES;
        vc.jobId=model.id;
        LM_PUSH;
    }
}
#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%ld ,index:%ld",(long)section,(long)index);

    switch (section) {
        case 0:
            dAreaId=[[ClassModel LMAppModel].city_id intValue]+(int)index;
            if(index==0){
                dAreaId=0;
            }
            break;
        case 1:
            dTypeId=(int)index;
            break;
        case 2:
            dSmartId=(int)index;
            break;
            
        default:
            break;
    }
    pageNumber=1;
    [self getNetworkData:pageNumber andSize:20 andAreaid:dAreaId andJobType:dTypeId andSmart:dSmartId];
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
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
