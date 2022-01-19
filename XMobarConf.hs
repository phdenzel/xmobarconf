module Main (main) where

import XMobarConfGenerator
import Colors.PhDDark

main = export $ config {
  -- appearance
    font    = "xft:Source Code Pro:size=9:antialias=true"
  , additionalFonts =
      [ "xft:Hack:size=4:antialias=true"
      , "xft:Font Awesome 5 Free Solid:pixelsize=11:hinting=true"
      , "xft:Font Awesome 5 Free Solid:pixelsize=16:hinting=true"
      , "xft:Font Awesome 5 Brands Regular:pixelsize=16:hinting=true"
      , "xft:Font Awesome 5 Brands Regular:pixelsize=24:hinting=true"
      , "xft:Weather Icons:pixelsize=16:hinting=true"]
  , iconRoot     = ".config/xmonad/xpm/"
  , bgColor      = colorBack
  , fgColor      = colorFore
  , borderColor  = color08
  , alpha        = 255

  -- layout
  , position     = TopSize L 100 23
  , border       = BottomB

  -- general behavior
  , wmClass = "xmobar"
  , wmName  = "xmobar"
  , lowerOnStart = True   -- send to bottom of window stack on start
  , hideOnStart  = False  -- start with window unmapped (hidden)
  , allDesktops  = True   -- show on all desktops
  , pickBroadest = False  -- choose widest display (multi-monitor)
  , persistent   = True   -- enable/disable hiding (True=disabled) 

  -- plugins
  , commands =
    -- Icons
    [ Run $ Com "echo" ["<fn=5>\xf3dc</fn>"] "phoenix" 360000
    --, Run $ Com "echo" ["<fn=5>\xf17c</fn>"] "penguin" 360000
    --, Run $ Com "echo" ["<fn=5>\xf520</fn>"] "raven"   360000
    --, Run $ Com "echo" ["<fn=5>\xf514</fn>"] "wolf"    360000
    --, Run $ Com "echo" ["<fn=5>\xf3f8</fn>"] "harpy"   360000
    --, Run $ Com "echo" ["<fn=5>\xf535</fn>"] "kiwi"    360000

    -- weather monitor
    , Run $ Com "xmobar_wttr" [] "wttr" 9000

    -- cpu activity monitors
    , Run $ Com "echo" ["<fn=2>\xf2db</fn>"] "cpuicon" 36000
    , Run $ Cpu      [ "-t" , "<fn=1> </fn><total>%"
                     , "-L" , "25"  -- units: %
                     , "-H" , "85"  -- units: %
                     , "-l" , color07
                     , "-n" , color11
                     , "-h" , color09
                     , "-p" , "2"
                     ] 30
    -- , Run $ CoreTemp [ "-t" , "<fn=1> </fn><core0>°C|<core1>°C"
    --                  , "-L" , "70"  -- units: °C
    --                  , "-H" , "80"  -- units: °C
    --                  , "-l" , color07
    --                  , "-n" , color11
    --                  , "-h" , color09
    --                  ] 50
    , Run $ Com "echo" ["<fn=2>\xf538</fn>"] "memoryicon" 36000
    , Run $ Memory   [ "-t" ,"<fn=1> </fn><usedratio>%"
                     , "-L" , "50"  -- units: %
                     , "-H" , "90"  -- units: %
                     , "-l" , color07
                     , "-n" , color11
                     , "-h" , color09
                     , "-p" , "2"
                     ] 10
    , Run $ Com "echo" ["<fn=2>\xf0a0</fn>"] "diskuicon" 36000
    , Run $ DiskU    [ ("/"  , "<fn=1> </fn><free><fn=1> </fn>")
                       -- , ("/"  , "<fn=1> </fn><used>/<size>")
                       -- , ("sda1"  , "<fn=1> </fn><usedp>")
                       -- , ("sdb2"  , "<fn=1> </fn><usedp>")
                       -- , ("sdc1"  , "<fn=1> </fn><usedp>")
                       -- , ("sdd1"  , "<fn=1> </fn><usedp>")
                     ] [ "-L" , "50"  -- units: %
                       , "-H" , "75"  -- units: %
                       , "-l" , color07
                       , "-n" , color11
                       , "-h" , color09
                       , "-m" , "3"
                       , "-p" , "3"
                       , "-S" , "true"
                       ] 600
    , Run $ DiskIO [ ("/"  , "<fn=1> </fn>@<fn=1> </fn>R:<read><fn=1> </fn>W:<write>")
                     -- , ("sda1"  , "<fn=1> </fn><usedp>")
                     -- , ("sdb2"  , "<fn=1> </fn><usedp>")
                     -- , ("sdc1"  , "<fn=1> </fn><usedp>")
                     -- , ("sdd1"  , "<fn=1> </fn><usedp>")
                   ] [ "-L" , "10000"  -- units: b/s
                     , "-H" , "100000" -- units: b/s
                     , "-l" , color07
                     , "-n" , color11
                     , "-h" , color09
                     , "-m" , "3"
                     , "-p" , "3"
                     , "-S" , "true"
                     ] 10

    -- network activity monitor
    , Run $ Com "echo" ["<fn=2>\xf6ff</fn>"] "dynnetworkicon" 36000
    , Run $ DynNetwork [ "-t" , "<fn=1> </fn>U:<tx><fn=1> </fn>D:<rx>"
                       , "-S" , "true"
                       , "-L" , "10000"  -- units: B/s
                       , "-H" , "100000" -- units: B/s
                       , "-l" , color07
                       , "-n" , color11
                       , "-h" , color09
                       , "-m" , "6"
                       ] 30

    -- uptime
    , Run $ Uptime [ "-t" , "<hours>h:<minutes>min"] 600

    -- time and date indicator
    , Run $ Date "%a<fn=1> </fn>%b<fn=1> </fn>%d %H:%M" "date" 10

    -- audio controle
    -- , Run Alsa

    -- keyboard layout indicator
    , Run $ Kbd [("us" , "US")]

    -- Trayer padding
    , Run $ Com "trayer_padding" [] "trayerpad" 20

    -- read IO & Logs
    , Run $ XPropertyLog "_XMONAD_LOG_1"
    , Run $ UnsafeStdinReader
    -- , Run $ UnsafeXMonadLog
    ]
  -- Plugins:
  -- (icons)    phoenix, penguin, raven, fenrir, harpy, kiwi
  --            for plugin icons: [plugin-name]icon
  -- (cpu)      cpu, multicpu, cpufreq, coretemp
  -- (ram+disk) memory, disku, diskio
  -- (gpu)      TODO: nvidia-smi --query-gpu=utilization.memory,memory.used,memory.total --format=csv[,noheader,nounits]
  -- (info)     kbd, UnsafeStdinReader
  , sepChar  = "%"
  , alignSep = "}{"
  , template = (" %trayerpad% "
                ++ "<fc=" ++ color05 ++ ">%phoenix%</fc> "
                ++ "%_XMONAD_LOG_1% "
                ++"| "
                ++ "%cpuicon%%cpu% "
                ++ "%memoryicon%%memory% "
                ++ "%diskuicon%%disku%%diskio% "
                ++ "%dynnetworkicon%%dynnetwork% "
                ++"}{ "
                ++ "<action=`xmobar_wttr`>%wttr%</action> "
                ++ "| "
                ++"%date% "
               )
  }
