//
//  GLSLProgram.m
//  ParticleEmitterDemoES2+ARC
//
//  Created by Mike Daley on 05/06/2013.
//  Copyright (c) 2013 71Squared Ltd. All rights reserved.
//

@interface GLSLProgram : NSObject

- (id)initWithVertexShaderFilename:(NSString *)vShaderFilename fragmentShaderFilename:(NSString *)fShaderFilename;
- (void)addAttribute:(NSString *)attributeName;
- (GLuint)attributeIndex:(NSString *)attributeName;
- (GLuint)uniformIndex:(NSString *)uniformName;
- (BOOL)link;
- (void)use;
- (NSString *)vertexShaderLog;
- (NSString *)fragmentShaderLog;
- (NSString *)programLog;

@end
