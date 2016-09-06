#!/usr/bin/env luajit

FULL_SCREEN = arg[1] == 'fullscreen'


package.path = package.path..';./lua/?.lua;./lua/?/init.lua'
package.path = package.path..';./lua/inc/?.lua;./lua/inc/?/init.lua'


local glfw = require 'ffi.glfw'
local opengl = require 'ffi.opengl'

local GLFW = glfw.const
local gl = opengl.gl
local GL = opengl.GL

opengl.loader = glfw.GetProcAddress

if glfw.Init() == 0 then
    error('fuck')
end


glfw.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL.TRUE)
glfw.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
glfw.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
glfw.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
glfw.WindowHint(GLFW.RESIZABLE, GL.FALSE)

local monitor
if FULL_SCREEN then
    monitor = glfw.GetPrimaryMonitor()
    local video_mode = glfw.GetVideoMode(monitor)

    SCREEN_WIDTH = video_mode.width
    SCREEN_HEIGHT = video_mode.height
else
    SCREEN_WIDTH = 1100
    SCREEN_HEIGHT = 700
end

G_WINDOW = glfw.CreateWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "", monitor)
if G_WINDOW == 0 then
    error('fuck')
end

glfw.MakeContextCurrent(G_WINDOW)
--glfw.SwapInterval(0)


local last_time = glfw.GetTime()
local function get_dt()
    local this_time = glfw.GetTime()
    local dt = this_time - last_time
    last_time = this_time
    return dt
end
while glfw.WindowShouldClose(G_WINDOW) == 0 do
    glfw.PollEvents()
    local dt = get_dt()
    -- do your rendering here
    glfw.SwapBuffers(G_WINDOW)
end

glfw.Terminate()
