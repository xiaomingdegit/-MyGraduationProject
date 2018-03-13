//
//  ZSKRegisterViewController.m
//  SchoolAssistant
//
//  Created by  庄少坤 on 2018/3/8.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "ZSKRegisterViewController.h"
#import <Masonry.h>
#import "LWTabBarController.h"
#import "ZSKNetworkManager.h"
#import "ZSKLoginButton.h"
#import "lw.pch"
#import "ZSKLoginViewController.h"

@interface ZSKRegisterViewController ()<UITextFieldDelegate>


@property(nonatomic,strong)UIImageView *bgView;//background view
@property(nonatomic,strong)UIView *contentView;//内容视图

@property(nonatomic,strong)UIButton *buttonLogin;//登录按钮
@property(nonatomic,strong)UIButton *buttonRegister;//注册按钮
@property(nonatomic,strong)UIButton *buttonReset;//重新输入

@property(nonatomic,strong)UIButton *buttonLogo;// logo

@property(nonatomic,strong)UITextField *fieldAccount; //账号
@property(nonatomic,strong)UITextField *fieldPassword; //密码
@property(nonatomic,strong)UITextField *reFieldPassword;//确认密码

@property (nonatomic, strong) UIView *accountLine;
@property (nonatomic, strong) UIView *passwordLine;
@property(nonatomic,strong)UIView *rePasswordLine;

@end

@implementation ZSKRegisterViewController

//懒加载
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.userInteractionEnabled = YES;
        
    }
    return _bgView;
}


- (UIButton *)buttonLogo{
    if (!_buttonLogo) {
        _buttonLogo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonLogo setImage:[UIImage imageNamed:@"logoo"] forState:UIControlStateNormal];
        [_buttonLogo sizeToFit];
        
        _buttonLogo.enabled = NO;
    }
    return _buttonLogo;
}


- (UITextField *)fieldAccount{
    if (!_fieldAccount) {
        _fieldAccount = [[UITextField alloc] init];
    }
    return _fieldAccount;
}


- (UITextField *)fieldPassword{
    if (!_fieldPassword) {
        _fieldPassword = [[UITextField alloc] init];
    }
    return _fieldPassword;
}

-(UITextField *)reFieldPassword {
    if (!_reFieldPassword) {
        _reFieldPassword = [[UITextField alloc] init];
    }
    return _reFieldPassword;
}



- (UIButton *)buttonRegister{
    if (!_buttonRegister) {
        _buttonRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _buttonRegister;
}

-(UIButton *)buttonLogin {
    if (!_buttonLogin) {
        _buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _buttonLogin;
}

- (UIButton *)buttonReset{
    if (!_buttonReset) {
        _buttonReset = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _buttonReset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self.fieldAccount becomeFirstResponder];
    
    [self addObservers];
}

//初始化界面
-(void)initUI {
    //整个view
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    //背景图片
    [self.bgView setImage:[UIImage imageNamed:@"bgRegister.jpg"]];
    [self.view addSubview:self.bgView];
    
    //内容视图
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.contentView];
    
    //设置logo
    [self.contentView addSubview:self.buttonLogo];
    
    //账号输入框
    self.fieldAccount.placeholder = @"账号";
    self.fieldAccount.tintColor = [UIColor whiteColor];
    self.fieldAccount.textColor = [UIColor whiteColor];
    self.fieldAccount.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.fieldAccount.leftViewMode = UITextFieldViewModeAlways;
    self.fieldAccount.delegate = self;
    [self.fieldAccount setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    accountImageV.contentMode = UIViewContentModeLeft;
    accountImageV.image = [UIImage imageNamed:@"login_account"];
    self.fieldAccount.leftView = accountImageV;
    [self.contentView addSubview:self.fieldAccount];
    
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = [UIColor whiteColor];
    self.accountLine = accountLine;
    [self.fieldAccount addSubview:accountLine];
    
    //密码输入框
    UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    passwordImageV.contentMode = UIViewContentModeLeft;
    passwordImageV.image = [UIImage imageNamed:@"login_password"];
    self.fieldPassword.tintColor = [UIColor whiteColor];
    self.fieldPassword.textColor = [UIColor whiteColor];
    self.fieldPassword.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.fieldPassword.leftViewMode = UITextFieldViewModeAlways;
    self.fieldPassword.leftView = passwordImageV;
    self.fieldPassword.placeholder = @"密码";
    self.fieldPassword.delegate = self;
    [self.fieldPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:self.fieldPassword];
    
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = [UIColor whiteColor];
    self.passwordLine = passwordLine;
    [self.fieldPassword addSubview:passwordLine];
    
    
    //密码输入框
    UIImageView *rePasswordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    rePasswordImageV.contentMode = UIViewContentModeLeft;
    rePasswordImageV.image = [UIImage imageNamed:@"login_password"];
    self.reFieldPassword.tintColor = [UIColor whiteColor];
    self.reFieldPassword.textColor = [UIColor whiteColor];
    self.reFieldPassword.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.reFieldPassword.leftViewMode = UITextFieldViewModeAlways;
    self.reFieldPassword.leftView = rePasswordImageV;
    self.reFieldPassword.placeholder = @"确认密码";
    self.reFieldPassword.delegate = self;
    [self.reFieldPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:self.reFieldPassword];
    
    UIView *rePasswordLine = [[UIView alloc] init];
    rePasswordLine.backgroundColor = [UIColor whiteColor];
    self.rePasswordLine = rePasswordLine;
    [self.reFieldPassword addSubview:rePasswordLine];
    
    
    self.buttonLogin.layer.cornerRadius = 8.f;
    self.buttonLogin.layer.masksToBounds = YES;
    self.buttonLogin.layer.borderWidth = 1.f;
    self.buttonLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonLogin.titleLabel.font = [UIFont systemFontOfSize:kLoginFontSize];
    [self.buttonLogin addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonLogin setTitle:@"注册" forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.buttonLogin];
    
    //注册按钮
    self.buttonRegister.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.buttonRegister.titleLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    [self.buttonRegister setTitle:@"登录" forState:UIControlStateNormal];
    [self.buttonRegister addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buttonRegister];
    
    //重置按钮
    self.buttonReset.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.buttonReset.titleLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    [self.buttonReset addTarget:self action:@selector(resetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonReset setTitle:@"重置密码" forState:UIControlStateNormal];
    [self.contentView addSubview:self.buttonReset];
    
    //布局
    [self make_layout];
}

//布局
- (void)make_layout {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.buttonLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.reFieldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.center.mas_equalTo(self.contentView);
    }];
    
    [self.rePasswordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kTFLeftW);
        make.right.mas_equalTo(-2.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.fieldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.reFieldPassword.mas_top).with.offset(-kMarginY10);
    }];
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kTFLeftW);
        make.right.mas_equalTo(-2.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.fieldAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.fieldPassword.mas_top).with.offset(-kMarginY10);
//        make.top.equalTo(@20);
    }];
//
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kTFLeftW);
        make.right.mas_equalTo(-2.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.buttonLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.reFieldPassword.mas_bottom).with.offset(kMarginY20);
    }];
    
    [self.buttonRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.buttonLogin);
        make.top.mas_equalTo(self.buttonLogin.mas_bottom).with.offset(kMarginY10);
        make.height.mas_equalTo(kBtnH);
        make.width.mas_equalTo(kMaxW/2.f);
    }];
    
    
    [self.buttonReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.buttonLogin);
        make.top.mas_equalTo(self.buttonLogin.mas_bottom).with.offset(kMarginY10);
        make.height.mas_equalTo(kBtnH);
        make.width.mas_equalTo(kMaxW/2.f);
    }];
}

//重置密码
- (void)resetPasswordAction:(UIButton *)sender{
    self.fieldPassword.text = @"";
    
}

//登录按钮点击事件
- (void)loginAction:(UIButton *)sender{
    [self hideKeyboard];
    
        [UIApplication sharedApplication].keyWindow.rootViewController = [ZSKLoginViewController new];
}

//注册按钮点击事件
- (void)registAction:(UIButton *)sender{
    [self hideKeyboard];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [ZSKLoginViewController new];
}

//监听界面点击事件
- (void)tapAction{
    [self hideKeyboard];
    //    [self.fieldAccount resignFirstResponder];
}

//隐藏键盘
- (void)hideKeyboard{
    [self.view endEditing:YES];
}

- (void)addObservers{
    NSLog(@"aaaa");
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘将展示
- (void)keyboardWillShow:(NSNotification *)notif {
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    //    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect keyboardRect = [value CGRectValue];
    //    CGFloat height = keyboardRect.size.height;
    //    CGFloat passwordMaxY = CGRectGetMaxY(self.fieldPassword.frame);
    //    CGFloat bgMaxY = CGRectGetMaxY(self.bgView.frame);
    //    CGFloat subHeight = height - (bgMaxY - passwordMaxY);//10为缓冲距离
    ////    NSLog(@"%@",[self.buttonReset.ma);
    //    NSLog(@"%f--%f--%f",height,bgMaxY,passwordMaxY);
    
    //获取键盘动画时长
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //键盘遮挡才需上移
    [UIView animateWithDuration:dutation animations:^{
        self.bgView.transform = CGAffineTransformMakeTranslation(0,  -23);
    }];
    
}

//键盘将消失
- (void)keyboardWillHide:(NSNotification *)notif {
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:dutation animations:^{
        self.bgView.transform = CGAffineTransformIdentity;
    }];
}



-(void)dealloc {
    NSLog(@"%@ 销毁了。。。",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
