-- Autostarting necessary processes for my custom made desktop environment

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("awww-daemon")
end)
