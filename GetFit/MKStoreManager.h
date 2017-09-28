

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
//#import "./../Store/PurchaseSceneDelegate.h"
#import "MainViewController.h"

@interface MKStoreManager : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver> {

	NSMutableArray *purchasableObjects;
     int updatedCoins;
	
	id<MainViewContrllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *purchasableObjects;
@property (retain) id<MainViewContrllerDelegate> delegate;

- (void) requestProductData;

- (void) buyFeature0; // expose product buying functions, do not expose
- (void) buyFeature1; // your product ids. This will minimize changes when you change product ids later
- (void) buyFeature2;

- (void) buyFeatureCoin0;
- (void) buyFeatureCoin1;
- (void) buyFeatureCoin2;
- (void) buyFeatureCoin3;
- (void) buyFeatureCoin4;
- (void) buyFeatureCoin5;

- (void) buyFeatureBottle0;
- (void) buyFeatureBottle1;
- (void) buyFeatureBottle2;
- (void) buyFeatureBottle3;
- (void) buyFeatureBottle4;

// do not call this directly. This is like a private method
- (void) buyFeature:(NSString*) featureId;

//- (void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) provideContent: (NSString*) productIdentifier;

+ (MKStoreManager*)sharedManager;

+ (BOOL) feature0Purchased;
+ (BOOL) feature1Purchased;
+ (BOOL) feature2Purchased;

+ (BOOL) featureCoin0Purchased;
+ (BOOL) featureCoin1Purchased;
+ (BOOL) featureCoin2Purchased;
+ (BOOL) featureCoin3Purchased;
+ (BOOL) featureCoin4Purchased;
+ (BOOL) featureCoin5Purchased;

+ (BOOL) featureBottle0Purchased;
+ (BOOL) featureBottle1Purchased;
+ (BOOL) featureBottle2Purchased;
+ (BOOL) featureBottle3Purchased;
+ (BOOL) featureBottle4Purchased;

+(void) loadPurchases;
+(void) updatePurchases;
-(void)restorePurchase;
//-(void) setLockKey: (NSString*) productIdentifier;


// for store observer
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
//- (void) failedTransaction: (SKPaymentTransaction *)transaction;
//- (void) completeTransaction: (SKPaymentTransaction *)transaction;
//- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
//-(void) incompleteRestore ;

@end
