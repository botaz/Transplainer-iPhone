#import "PerformanceViewController.h"
#import "PerformanceServices.h"

@implementation PerformanceViewController

@synthesize xmlStartedAt=_xmlStartedAt;
@synthesize jsonStartedAt=_jsonStartedAt;
@synthesize plistStartedAt=_plistStartedAt;
@synthesize xmlController=_xmlController;
@synthesize jsonController=_jsonController;
@synthesize plistController=_plistController;
@synthesize scrollView=_scrollView;
@synthesize managedObjectContext=_managedObjectContext;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// JSON
	self.jsonController.view.frame = CGRectMake(0.0, 15.0, 320.0, 115.0);
	self.jsonController.formatLabel.text = @"JSON";
	[self.scrollView addSubview:self.jsonController.view];
	[self.jsonController viewDidLoad];
	
	
	// PLIST
	self.plistController.view.frame = CGRectMake(0.0, 130.0, 320.0, 115.0);
	self.plistController.formatLabel.text = @"PLIST";
	[self.scrollView addSubview:self.plistController.view];
	[self.plistController viewDidLoad];
	
	// XML
	self.xmlController.view.frame = CGRectMake(0.0, 245.0, 320.0, 115.0);
	self.xmlController.formatLabel.text = @"XML";
	[self.scrollView addSubview:self.xmlController.view];
	[self.xmlController viewDidLoad];
	
	
	
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(performanceFinishedDownloadingForFormat:) name:PerformanceFinishedDownloadingForFormat object:nil];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(performanceFinishedParsingForFormat:) name:PerformanceFinishedParsingForFormat object:nil];
	
	// add start button
	UIBarButtonItem *startButton = [[UIBarButtonItem alloc]initWithTitle:@"Start" 
																   style:UIBarButtonItemStylePlain
																  target:self 
																  action:@selector(startDownloading:)];
	self.navigationItem.rightBarButtonItem = startButton;
	[startButton release];
}

- (IBAction)startDownloading:(id)sender
{
	// JSON
	[self.jsonController resetView];
	
	// PLIST
	[self.plistController resetView];
	
	// XML
	[self.xmlController resetView];
	
	// JSON
	[PerformanceServices sharedPerformanceServices].managedObjectContext = self.managedObjectContext;
	[[PerformanceServices sharedPerformanceServices] downloadPeopleUsingFormat:JSONFormat];
}

- (void)performanceFinishedDownloadingForFormat:(id)sender
{
	NSString *format = [sender object];
	NSTimeInterval performanceTime = 0;
	if ([format isEqualToString:@"XML"]) {
		performanceTime = [[NSDate date] timeIntervalSinceDate:self.xmlStartedAt];
		NSInteger miliseconds = round(performanceTime*1000);
		self.xmlController.status = DownloadedStatus;
		self.xmlController.downloadLabel.text = [NSString stringWithFormat:@"%d ms", miliseconds];
		self.xmlStartedAt = [NSDate date];
	} else if ([format isEqualToString:@"JSON"]) {
		performanceTime = [[NSDate date] timeIntervalSinceDate:self.jsonStartedAt];
		NSInteger miliseconds = round(performanceTime*1000);
		self.jsonController.status = DownloadedStatus;
		self.jsonController.downloadLabel.text = [NSString stringWithFormat:@"%d ms", miliseconds];
		self.jsonStartedAt = [NSDate date];
	} else if ([format isEqualToString:@"PLIST"]) {
		performanceTime = [[NSDate date] timeIntervalSinceDate:self.plistStartedAt];
		NSInteger miliseconds = round(performanceTime*1000);
		self.plistController.status = DownloadedStatus;
		self.plistController.downloadLabel.text = [NSString stringWithFormat:@"%d ms", miliseconds];
		self.plistStartedAt = [NSDate date];
	}
	DLog(@"%@ performance finished downloading: %f", format, performanceTime);
}

- (void)performanceFinishedParsingForFormat:(id)sender
{
	NSString *format = [sender object];
	NSTimeInterval performanceTime = 0;
	if ([format isEqualToString:@"XML"]) {
		performanceTime = [[NSDate date] timeIntervalSinceDate:self.xmlStartedAt];
		NSInteger miliseconds = round(performanceTime*1000);
		self.xmlController.status = ParsedStatus;
		self.xmlController.parseLabel.text = [NSString stringWithFormat:@"%d ms", miliseconds];
	} else if ([format isEqualToString:@"JSON"]) {
		performanceTime = [[NSDate date] timeIntervalSinceDate:self.jsonStartedAt];
		self.jsonController.status = ParsedStatus;
		NSInteger miliseconds = round(performanceTime*1000);
		self.jsonController.parseLabel.text = [NSString stringWithFormat:@"%d ms", miliseconds];
		
		// PLIST
		[[PerformanceServices sharedPerformanceServices] downloadPeopleUsingFormat:PLISTFormat];
		self.plistController.status = StartedStatus;
		self.plistStartedAt = [NSDate date];
	} else if ([format isEqualToString:@"PLIST"]) {
		performanceTime = [[NSDate date] timeIntervalSinceDate:self.plistStartedAt];
		NSInteger miliseconds = round(performanceTime*1000);
		self.plistController.status = ParsedStatus;
		self.plistController.parseLabel.text = [NSString stringWithFormat:@"%d ms", miliseconds];
		
		// XML
		[[PerformanceServices sharedPerformanceServices] downloadPeopleUsingFormat:XMLFormat];
		self.xmlController.status = StartedStatus;
		self.xmlStartedAt = [NSDate date];
	}
	DLog(@"%@ performance finished parsing: %f", format, performanceTime);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
	[_managedObjectContext release];
	[_scrollView release];
	[_plistController release];
	[_xmlController release];
	[_jsonController release];
	[_xmlStartedAt release];
	[_jsonStartedAt release];
	[_plistStartedAt release];
	
    [super dealloc];
}


@end
