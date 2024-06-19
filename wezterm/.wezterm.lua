-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Sakura'

-- config.window_background_image = '/home/y4suyuki/Pictures/IMG_20191006_173302115-EFFECTS.jpg'

config.window_background_opacity = .7
config.text_background_opacity = .7

config.window_background_image_hsb = {

	brightness = 0.2,

	hue = 1.0,

	saturation = 1.0,
}

-- and finally, return the configuration to wezterm
return config
