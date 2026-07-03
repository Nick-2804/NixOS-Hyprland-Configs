------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.00",
})

--hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
--hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
--hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
--hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
--hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })


hl.workspace_rule({ workspace = "1", persistent = true })
hl.workspace_rule({ workspace = "2", persistent = true })
hl.workspace_rule({ workspace = "3", persistent = true })
hl.workspace_rule({ workspace = "4", persistent = true })
hl.workspace_rule({ workspace = "5", persistent = true })

