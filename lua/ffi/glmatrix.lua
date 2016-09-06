local ffi = require 'ffi'

local lib = ffi.load('c/lib/glmatrix.dylib')
ffi.cdef(io.readfile('c/deps/glmatrix/funcs.h'))

local glm = {}
setmetatable(glm, {__index = lib})

local vec3 = ffi.typeof('GLMfloat[3]')
glm.vec3_t = vec3
function glm.vec3(x, y, z)
    local vec = vec3()
    if x then
        vec[0] = x
        vec[1] = y
        vec[2] = z
    end
    return vec
end

local vec4 = ffi.typeof('GLMfloat[4]')
glm.vec4_t = vec4
function glm.vec4(x, y, z, w)
    local vec = vec4()
    if x then
        vec[0] = x
        vec[1] = y
        vec[2] = z
        vec[3] = w
    end
    return vec
end

local mat3_identity = {
    1, 0, 0,
    0, 1, 0,
    0, 0, 1,
}

local mat3 = ffi.typeof('GLMfloat[9]')
glm.mat3_t = mat3
function glm.mat3(t)
    if t == false then
        return mat3()
    end
    return mat3(t or mat3_identity)
end

local mat4_identity = {
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1,
}
local mat4 = ffi.typeof('GLMfloat[16]')
glm.mat4_t = mat4
function glm.mat4(t)
    if t == false then
        return mat4()
    end
    return mat4(t or mat4_identity)
end

function glm.mat4_make_identity(m)
    for i=0,15 do
        m[i] = mat4_identity[i + 1]
    end
end

return glm
