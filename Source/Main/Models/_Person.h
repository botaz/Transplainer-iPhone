// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>



@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;



@property (nonatomic, retain) NSString *state;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *first_name;

//- (BOOL)validateFirst_name:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *person_id;

@property long long person_idValue;
- (long long)person_idValue;
- (void)setPerson_idValue:(long long)value_;

//- (BOOL)validatePerson_id:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *created_at;

//- (BOOL)validateCreated_at:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *last_name;

//- (BOOL)validateLast_name:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *post_code;

//- (BOOL)validatePost_code:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *modified_at;

//- (BOOL)validateModified_at:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *lastModified;

//- (BOOL)validateLastModified:(id*)value_ error:(NSError**)error_;




@end

@interface _Person (CoreDataGeneratedAccessors)

@end
