
local packages          = {"glfw", "glew", "fmt", "stb"}
local unittest_packages = {"doctest"}
local sandbox_packages  = {"doctest"}

set_project("Orion")
set_xmakever("2.8.6")

includes("xmake/**.lua")

option("examples", {description = "Build examples (xmake run <example_name>)",    default = false})
option("unittest", {description = "Build unittest (xmake run unittest)",          default = false})
option("sandbox",  {description = "Build dev sandbox (xmake run <sandbox_name>)", default = false})
option("nogpu",    {description = "To run unittest without gpu",                  default = false})
option("shared",   {description = "Build as shared library",                      default = false})

add_rules("mode.debug", "mode.release")

set_languages("c99", "c++23")

if is_mode("debug") then
    add_defines("ORION_DEBUG")
end

for _, pkg in ipairs(packages) do
    add_requires(pkg, { debug = is_mode("debug"), configs = { shared = has_config("shared") } })
end

target("orion")

    add_defines("ORION_BUILD")

    if has_config("shared") then
        set_kind("shared")
        add_defines("ORION_SHARED")
    else
        set_kind("static")
    end

    add_files("src/**/*.cpp")
    add_includedirs("include/", {public = true})
    add_headerfiles("include/*.h")
    add_headerfiles("include/(**/*.h)")

    for _, pkg in ipairs(packages) do
        add_packages(pkg, {public = true})
    end

    after_install(function (target)
        os.cp("$(projectdir)/resource", path.join(target:installdir(), "resource"))
    end)

    add_rules("resource.shader", "resource.texture", "resource.model")

target_end()

if has_config("unittest") then
    add_requires(table.unpack(unittest_packages))

    target("unittest")
        set_kind("binary")
        add_deps("orion")
        add_files("test/*.cpp")
        add_files("test/**/*.cpp")

        if has_config("nogpu", "y") then
            remove_files("test/graphics/*.cpp")
        end

        for _, pkg in ipairs(unittest_packages) do
            add_packages(pkg)
        end
    target_end()
end

if has_config("sandbox") then
    add_requires(table.unpack(sandbox_packages))

    target("sandbox")
        set_kind("binary")
        add_deps("orion")
        add_files("sandbox/*.cpp")

        for _, pkg in ipairs(sandbox_packages) do
            add_packages(pkg)
        end
    target_end()
end