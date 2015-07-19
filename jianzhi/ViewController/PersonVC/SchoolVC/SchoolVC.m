//
//  SchoolVC.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/29.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "SchoolVC.h"
#import "SchoolCell.h"
#import "SchoolModel.h"

@interface SchoolVC ()

@end

@implementation SchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.searchTield.delegate = self;
    self.navigationItem.titleView = [CommUtils navTittle:@"选择学校"];
    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
    self.schooleTbView.backgroundColor = [UIColor clearColor];
    self.schooleTbView.backgroundView = nil;
    self.schooleTbView.separatorStyle = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 543"]];
    
    [self.searchTield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _schMuArray = [NSMutableArray arrayWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction)name:UITextFieldTextDidChangeNotification object:nil];
    
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableString *muStr;
    if ([CommUtils readUser].college) {
        [NSMutableString stringWithString:[CommUtils readUser].college];
    }
    if (muStr.length != 0) {
        self.searchTield.placeholder = [CommUtils readUser].college;
    }
}

-(void)searchAction
{
    [self.searchTield resignFirstResponder];
}

-(void)infoAction
{
    [self getSchoolDate:self.searchTield.text];
}

-(void)backMethod
{
    LM_POP;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.schMuArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notice=@"SchoolCell";
    SchoolCell *cell=[tableView dequeueReusableCellWithIdentifier:notice];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"SchoolCell" owner:self options:nil] lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    SchoolModel *model = [self.schMuArray objectAtIndex:indexPath.row];
    cell.headLabel.text = model.name;
    
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchTield resignFirstResponder];
    return NO;
}

-(void)getSchoolDate:(NSString *)name
{
    NSDictionary *parameters = @{@"school_name":name,@"version":[CommUtils getVersion]};
    
    TLog(@"输出请求内容%@",parameters);
    
    [self.schMuArray removeAllObjects];
    
    __weak SchoolVC *bSelf = self;
    NSString *stringurl=[NSString stringWithFormat:@"%@%@",PartyAPI,kSchool];
    TLog(@"输出请求内容%@",stringurl);
    //[SVProgressHUD show];
    [AFService postMethod:stringurl andDict:parameters completion:^(NSDictionary *results,NSError *error){
        if (results) {
            TLog(@"results == %@",results);
            NSArray *array=[results objectForKey:@"school"];
            NSMutableArray *muArray=[Manager dataAnalysisArray:@"SchoolModel" andArray:array];
            TLog(@"输出modle数组%@",muArray);
            [bSelf.schMuArray addObjectsFromArray:muArray];
            TLog(@"输出modle数组%@",bSelf.schMuArray);
            
            [bSelf.schooleTbView reloadData];
        }else{
            TLog(@"error == %@",error);
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolModel *schModel = [self.schMuArray objectAtIndex:indexPath.row];
    [self.delegate schoolDetail:schModel.name];
    
    if ([[CommUtils readUser].college isEqualToString:schModel.name]) {
        ;
    }else{
        UserModel * userModel2 = [CommUtils readUser];
        userModel2.institute = @"";
        [CommUtils saveUserModel:userModel2];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    UserModel * userModel = [CommUtils readUser];
    userModel.college = schModel.name;
    [CommUtils saveUserModel:userModel];
}

@end
