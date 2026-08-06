-- Config for default Vellum Web-App interface

local shader_dir = "~/.config/vellum/shaders/"
local interface_dir = "~/dev/vellum/interfaces/web-app"

local ok = {
  white = "oklch(1.00 0 0)",
  black = "oklch(0.00 0 0)",
}

local palette = {
  dark = {
    ok100 = "oklch(1.00 0 0)",
    ok200 = "oklch(0.29 0 0)",
    ok300 = "oklch(0.24 0 0)",
    ok400 = "oklch(0.21 0 0)",
    ok500 = "oklch(0.07 0 0)",
  },
  light = {
     ok100 = "oklch(0.00 0 0)",
     ok200 = ok.white,
     ok300 = "oklch(0.85 0 0)",
     ok400 = "oklch(0.80 0 0)",
     ok500 = "oklch(0.95 0 0)",
  }
}

local base_interface = {

  directory = interface_dir,

  assets = {
    shader = shader_dir .. "mountain_eq.frag"
  },

  config = {

    palette = palette.dark,

    -- palette = palette.light,

    shader = {
      order = "original",
      speed = 0.8,
      zoom = 0.2,
      zoom = 0.5,
      blur = 0.8,
      grain = 1.7,
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
}

vl.interfaces({
  default = {
    directory = base_interface.directory,
    run = interface_dir .. "/run_prod.sh",
    assets = base_interface.assets,
    config = base_interface.config,
  },
  dev = {
    directory = base_interface.directory,
    run = interface_dir .. "/run_dev.sh",
    assets = base_interface.assets,
    config = base_interface.config,
  },
  prod = {
    directory = base_interface.directory,
    run = interface_dir .. "/run_prod.sh",
    assets = base_interface.assets,
    config = base_interface.config,
  }
})
