#import <Foundation/Foundation.h>

@class FoodTruck;

@protocol FoodTruckDelegate <NSObject>

-(double)foodTruck:(FoodTruck *)truck priceForFood:(NSString *)food;

@end



@interface FoodTruck : NSObject{
  id<FoodTruckDelegate> delegate;
  float earnings;
  NSString *name;
  NSString *foodType;
}

@property (nonatomic, assign) id<FoodTruckDelegate> delegate;
@property (nonatomic, assign) float earnings;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *foodType;

-(instancetype)initWithName:(NSString *)pun andFoodType:(NSString *)foodType;

-(void)serve:(int)orders;
-(void)cashOut;

@end

@implementation FoodTruck

@synthesize delegate;
@synthesize earnings;
@synthesize name;
@synthesize foodType;


-(instancetype)initWithName:(NSString *)pun andFoodType:(NSString *)foodType {
    self = [super init];
    if (self) {
        self.name = pun;
        self.foodType = foodType;
    }
    return self;
}


-(void)serve:(int)orders {

  double price = [self.delegate foodTruck:self priceForFood:self.foodType];

  NSLog(@"Welcome to %@", self.name);
  NSLog(@"We serve %@ for $%0.2f", self.foodType, price);
  NSLog(@" ");

  self.earnings += orders * price;
}

-(void)cashOut {
  NSLog(@"%@ earned %0.2f today!", self.name, self.earnings);
}

@end

@interface Cook : NSObject<FoodTruckDelegate>
@end

@implementation Cook

-(double)foodTruck:(FoodTruck *)truck priceForFood:(NSString *)food {
  return 100.0;
}

@end

int main(int argc, const char * argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];


  FoodTruck *truckA = [[FoodTruck alloc] initWithName:@"Take a Bao" andFoodType:@"bao"];
  FoodTruck *truckB = [[FoodTruck alloc] initWithName:@"Tim Shortons" andFoodType:@"shortbread"];
  // create instances of your delegate class
  // set truckA and truckB's delegate to your new instance.
  truckA.delegate = [[Cook alloc] init];
  truckB.delegate = [[Cook alloc] init];

  [truckA serve:10];
  [truckB serve:5];

  [truckA cashOut];
  [truckB cashOut];

  [pool drain];
  return 0;
}
