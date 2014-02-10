//
//  SSViewController.m
//  ParticleEmitterDemoGLKit+ARC
//
//  Created by Tom Bradley on 28/01/2014.
//  Copyright (c) 2014 Tom Bradley. All rights reserved.
//

#import "SSViewController.h"
#import "ParticleEmitter.h"

@interface SSViewController () {
}

@property (strong, nonatomic) EAGLContext       *context;
@property (strong, nonatomic) GLKBaseEffect     *effect;
@property (strong, nonatomic) ParticleEmitter   *pe;
@property (strong, nonatomic) GLKBaseEffect     *particleEmitterEffect;
@property (strong, nonatomic) NSMutableArray    *particleEmitters;
@property (strong, nonatomic) NSEnumerator      *particleEnumerator;

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.preferredFramesPerSecond = 60;

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    // get screen bounds
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    // Create a list of emitters configs to load
    NSArray *configs = @[
                         @"Winner Stars.pex",
                         @"Comet.pex",
                         @"Foam.pex",
                         @"Blue Flame.pex",
                         @"Atomic Bubble.pex",
                         @"Crazy Blue.pex",
                         @"Plasma Glow.pex",
                         @"Meks Blood Spill.pex",
                         @"Into The Blue.pex",
                         @"JasonChoi_Flash.pex",
                         @"Real Popcorn.pex",
                         @"The Sun.pex",
                         @"Touch Up.pex",
                         @"Trippy.pex",
                         @"Electrons.pex",
                         @"Blue Galaxy.pex",
                         @"huo1.pex",
                         @"JasonChoi_rising up.pex",
                         @"JasonChoi_Swirl01.pex",
                         @"Shooting Fireball.pex",
                         @"wu1.pex"
                         ];
    
    // Create a new array
    _particleEmitters = [NSMutableArray new];
    
    // Cycle through all emitters configs loading them
    for (NSString *config in configs) {
        ParticleEmitter *particleEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:config effectShader:self.particleEmitterEffect];
        
        // Center the particle system
        particleEmitter.sourcePosition = GLKVector2Make(bounds.size.width/2, bounds.size.height/2);
        
        [_particleEmitters addObject:particleEmitter];
    }
    
    // Set the current emitter to the first in the list
    [self showNextEmitter];


    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glEnable(GL_BLEND);
    glDisable(GL_DEPTH_TEST);
}

- (void) showNextEmitter
{
    // If no enumerator exists or we've reached the last object in the enumerator, create a new enumerator
    if (!_particleEnumerator || _pe == [_particleEmitters lastObject])
        _particleEnumerator = [_particleEmitters objectEnumerator];
    
    // Get the next particle system from the enumerator and reset it
    _pe = [_particleEnumerator nextObject];
    [_pe reset];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    self.effect = nil;
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    // Update the current particle system according to the time passed since the last update
    [_pe updateWithDelta:self.timeSinceLastUpdate];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // Render the particle system
    [_pe renderParticles];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Show the next particle system
    [self showNextEmitter];
}

@end
