local ffi = require 'ffi'

local lib = ffi.load('c/lib/stb_image.dylib')
ffi.cdef[[
typedef unsigned char stbi_uc;
stbi_uc *stbi_load               (char              const *filename,           int *x, int *y, int *comp, int req_comp);
stbi_uc *stbi_load_from_memory   (stbi_uc           const *buffer, int len   , int *x, int *y, int *comp, int req_comp);
const char *stbi_failure_reason  (void);
void     stbi_image_free      (void *retval_from_stbi_load);
]]

local stb = {}
stb.image = setmetatable({}, {
    __index = function(t, k)
        return lib['stbi_'..k]
    end,
})


return stb
