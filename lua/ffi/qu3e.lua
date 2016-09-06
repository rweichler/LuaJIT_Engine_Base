local ffi = require 'ffi'

local function generate_funcs()
    local result = {}
    local f = io.open('lua/ffi/q3_c.h')
    for line in f:lines() do
        local prefix = string.sub(line, 2, #'EXPOSE1')
        if prefix == 'XPOSE0' then
            local _, _, q3, ret, func = string.find(line, "[EP]XPOSE%d%((.*),[ ]*(.*),[ ]*(.*)%);")
            table.insert(result, ret..' '..q3..func..'('..q3..' *);')
        elseif prefix == 'XPOSE1' then
            local _, _, q3, ret, func, arg1 = string.find(line, "[EP]XPOSE%d%((.*),[ ]*(.*),[ ]*(.*),[ ]*(.*)%);")
            table.insert(result, ret..' '..q3..func..'('..q3..' *, '..arg1..');')
        elseif prefix == 'XPOSE2' then
            local _, _, q3, ret, func, arg1, arg2 = string.find(line, "[EP]XPOSE%d%((.*),[ ]*(.*),[ ]*(.*),[ ]*(.*),[ ]*(.*)%);")
            table.insert(result, ret..' '..q3..func..'('..q3..' *, '..arg1..', '..arg2..');')
        elseif prefix == 'XPOSE3' then
            local _, _, q3, ret, func, arg1, arg2, arg3 = string.find(line, "[EP]XPOSE%d%((.*),[ ]*(.*),[ ]*(.*),[ ]*(.*),[ ]*(.*),[ ]*(.*)%);")
            table.insert(result, ret..' '..q3..func..'('..q3..' *, '..arg1..', '..arg2..', '..arg3..');')
        end
    end
    return table.concat(result, '\n')
end


local lib = ffi.load('c/lib/qu3e.dylib')
ffi.cdef([[
// bootstrapped types

typedef void q3Body;
typedef void q3Scene;
typedef void q3BoxDef;
typedef void q3Quaternion;
typedef void q3ContactListener;
typedef void q3Render;
typedef void FILE;

// types

typedef float r32;
typedef double r64;
typedef float f32;
typedef double f64;
typedef signed char	i8;
typedef signed short i16;
typedef signed int i32;
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

// q3Math

typedef struct q3Vec3
{
	r32 x;
	r32 y;
	r32 z;
} q3Vec3;

typedef struct q3Mat3
{
	q3Vec3 ex;
	q3Vec3 ey;
	q3Vec3 ez;
} q3Mat3;

typedef struct q3Transform
{
	q3Vec3 position;
	q3Mat3 rotation;
} q3Transform;

// common

typedef struct q3AABB
{
	q3Vec3 min;
	q3Vec3 max;
} q3AABB;

typedef struct q3HalfSpace
{
	q3Vec3 normal;
	r32 distance;
} q3HalfSpace;

typedef struct q3RaycastData
{
	q3Vec3 start;	// Beginning point of the ray
	q3Vec3 dir;		// Direction of the ray (normalized)
	r32 t;			// Time specifying ray endpoint

	r32 toi;		// Solved time of impact
	q3Vec3 normal;	// Surface normal at impact
} q3RaycastData;

// q3Body

enum q3BodyType
{
	eStaticBody,
	eDynamicBody,
	eKinematicBody
};

typedef struct q3BodyDef
{
	q3Vec3 axis;			// Initial world transformation.
	r32 angle;				// Initial world transformation. Radians.
	q3Vec3 position;		// Initial world transformation.
	q3Vec3 linearVelocity;	// Initial linear velocity in world space.
	q3Vec3 angularVelocity;	// Initial angular velocity in world space.
	r32 gravityScale;		// Convenient scale values for gravity x, y and z directions.
	i32 layers;				// Bitmask of collision layers. Bodies matching at least one layer can collide.
	void* userData;			// Use to store application specific data.

	r32 linearDamping;
	r32 angularDamping;

	// Static, dynamic or kinematic. Dynamic bodies with zero mass are defaulted
	// to a mass of 1. Static bodies never move or integrate, and are very CPU
	// efficient. Static bodies have infinite mass. Kinematic bodies have
	// infinite mass, but *do* integrate and move around. Kinematic bodies do not
	// resolve any collisions.
	enum q3BodyType bodyType;

	bool allowSleep;	// Sleeping lets a body assume a non-moving state. Greatly reduces CPU usage.
	bool awake;			// Initial sleep state. True means awake.
	bool active;		// A body can start out inactive and just sits in memory.
	bool lockAxisX;		// Locked rotation on the x axis.
	bool lockAxisY;		// Locked rotation on the y axis.
	bool lockAxisZ;		// Locked rotation on the z axis.
} q3BodyDef;

// q3Box

typedef struct q3MassData
{
	q3Mat3 inertia;
	q3Vec3 center;
	r32 mass;
} q3MassData;

typedef struct q3Box
{
	q3Transform local;
	q3Vec3 e;

	struct q3Box* next;
	q3Body* body;
	r32 friction;
	r32 restitution;
	r32 density;
	i32 broadPhaseIndex;
	void* userData;
	bool sensor;
} q3Box;

q3Scene * q3SceneCreate(r32 dt);
q3BoxDef * q3BoxDefCreate();
]]..generate_funcs())

return lib
