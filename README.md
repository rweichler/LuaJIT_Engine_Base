This only works on Mac OS X and Linux. I tried getting it to work on Windows XP with MinGW, but I got frustrated and quit. It should be relatively easy to port if you know your way around building software for Windows, though. (Please!! Make a pull request if you do!!)

None of the libraries are provided. You'll need to run a command like this:

```bash
sudo apt-get install luajit opengl glfw assimp freetype
```

The OpenGL / GLFW bindings work out of the box. Just run `luajit main.lua`.

If you want GLMatrix, stb\_image, and/or qu3e, then you need to install [aite](https://github.com/rweichler/aite). Then `cd` into the c directory and run `aite`.

## License

Public domain. Do whatever you want with it, add whatever license you want. Feel free to not credit me. I don't care.
