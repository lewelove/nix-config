-- Config for default Vellum Web-App interface

local shader_dir = "~/.config/vellum/shaders/"
local interface_dir = "~/dev/vellum/interfaces/web-app"

vl.interfaces({ default = {

  directory = interface_dir,

  assets = {
    shader = shader_dir .. "mountain_eq.frag"
  },

  config = {

    shader = {
      order = "original",
      speed = 0.8,
      zoom = 0.2,
      blur = 0.8,
      grain = 1,
    },

    palette = {
      ["100"] = "#242424",
      ["200"] = "#323232",
      ["300"] = "#424242",
      ["400"] = "#CCCCCC",
      ["500"] = "#FFFFFF",
    },

    queue = {
      cover
    },

    album_grid = {

      spacing = { x = 20, y = 16, top = 20 },
      -- spacing = { x = 0, y = 0, top = 20 },

      album_card = {
        cover = {
          size = 200,
          filter = "catmullrom",
        },
        text = {
          -- enable = false,
          enable = true,
          title = { size = 14 },
          albumartist = { size = 12 },
          spacing = { top = 11, middle = 2 },
        }
      }
    }
  }

}})


