builder.compiler = 'gcc'
builder.build_dir = 'build'

function stb()
    print(CYAN('Building stb'))
    local b = builder()
    b.src = {'deps/stb/stb.c'}
    b.output = b.build_dir..'/stb_image.dylib'
    b:link(b:compile())
end

function glmatrix()
    print(CYAN('Building glmatrix'))
    local b = builder()
    b.src = fs.scandir('deps/glmatrix/*.c')
    b.output = b.build_dir..'/glmatrix.dylib'
    b:link(b:compile())
end

function qu3e()
    print(CYAN('Building qu3e'))
    local b = builder()
    b.compiler = 'g++'
    b.src = fs.scandir('deps/qu3e/*/*.cpp')
    b.cflags = '-Wno-return-type-c-linkage -Wno-local-type-template-args'
    b.output = b.build_dir..'/qu3e.dylib'
    b:link(b:compile())
end

function default()
    qu3e()
    stb()
    glmatrix()
    fs.mkdir('lib')
    os.pexecute('cp '..builder.build_dir..'/*.dylib lib/')
end

function clean()
    os.pexecute('rm -rf .build lib')
end
