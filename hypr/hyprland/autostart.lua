-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function () 
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("elephant")
    hl.exec_cmd("walker --gapplication-service")
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    -- You can remove this line if you want since its only used for the first startup
    hl.exec_cmd("bash ~/.config/scripts/start_theme/first_login.sh")
    -- You can also remove the start_theme folder with the first_login.sh file in it, its not needed anymore
end)


