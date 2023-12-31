---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by alspin.
--- DateTime: 29/12/2023 17:22
---

rule("glsl")
    set_extensions(".glsl")
    on_build_files(function (target, sourcebatch, opt)
        for i, sourcefile in ipairs(sourcebatch["sourcefiles"]) do
            os.cp(sourcefile, path.join(target:targetdir(), "resource", "shader", path.basename(sourcefile) .. ".glsl"))
        end
    end)

rule("texture")
    set_extensions(".png")
    on_build_files(function (target, sourcebatch, opt)
        for i, sourcefile in ipairs(sourcebatch["sourcefiles"]) do
            os.cp(sourcefile, path.join(target:targetdir(), "resource", "texture", path.basename(sourcefile) .. path.extension(sourcefile)))
        end
    end)