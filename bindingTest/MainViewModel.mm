//
//  MainViewModel.m
//  bindingTest
//
//  Created by David Ventura on 2017/05/29.
//  Copyright © 2017年 Propellerhead AB. All rights reserved.
//

#import "MainViewModel.h"
#import <Foundation/FoundationErrors.h>
#import "ViewModel.hpp"
#import <UIKit/UIKit.h>

@interface PHMainViewModel()
- (void)onChange:(NSString*)keyPath;
@end

static PHMainViewModel* gInstance = nil;

namespace {
	
class CViewModelListener : public IViewModelListener {
	
public: CViewModelListener(PHMainViewModel* iMainViewModel) :
	fMainViewModel(iMainViewModel)
	{
	}
	
public: void IViewModelListener_OnChange(const std::string& iPropertyName) {
	NSString* propertyName = [NSString stringWithUTF8String:iPropertyName.c_str()];
	
	NSString* firstChar = [[propertyName substringToIndex:1] lowercaseString];
	NSString* keyPath = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
	
	[fMainViewModel onChange:keyPath];
}
private: PHMainViewModel* fMainViewModel;
};

} // anonymous namespace


void CreateMainViewModelInstance() {
	NSCAssert(gInstance == nil, @"" );
	gInstance = [[PHMainViewModel alloc] init];
}

void DisposeMainViewModelInstance() {
	NSCAssert(gInstance != nil, @"" );
	gInstance = nil;
}

PHMainViewModel* GetMainViewModelInstance() {
	if ( gInstance == nil )
	{
		CreateMainViewModelInstance();
	}
	NSCAssert(gInstance != nil, @"" );
	return gInstance;
}
@implementation PHMainViewModel {
	std::unique_ptr<CViewModel> fViewModel;
	std::unique_ptr<CViewModelListener> fViewModelListener;
}
@synthesize sliderValue;
- (instancetype)init {
	self = [super init];
	if (self != nil) {
		fViewModelListener.reset(new CViewModelListener(self));
		fViewModel.reset(new CViewModel(*fViewModelListener));
		
		
	}
	return self;
}
-(NSNumber *)sliderValue
{
    return @(fViewModel->sliderValue);
}
- (void)setup
{
	
}

- (void)onChange:(NSString*)keyPath {
	[self willChangeValueForKey:keyPath];
	[self didChangeValueForKey:keyPath];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
}
- (void)applySliderValue:(NSInteger)valueFrom0to100;
{
    fViewModel->sliderValue = (int)valueFrom0to100;
    fViewModel->NotifyChange("sliderValue");
	NSLog( @"Slider changed to %ld", (long)valueFrom0to100 );
}

@end

