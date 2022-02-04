module Main (main) where

import XMobarConfGenerator
import Colors.PhDDark


main = export $ config {
  -- appearance
    font    = "xft:Source Code Pro:size=6:antialias=true"
  , additionalFonts =
      [ "xft:Hack:size=6:antialias=true"
      , "xft:Font Awesome 5 Free Solid:pixelsize=20:hinting=true"
      , "xft:Font Awesome 5 Free Solid:pixelsize=24:hinting=true"
      , "xft:Font Awesome 5 Brands Regular:pixelsize=22:hinting=true"
      , "xft:Font Awesome 5 Brands Regular:pixelsize=30:hinting=true"
      , "xft:Weather Icons:pixelsize=22:hinting=true"]
  , iconRoot     = ".config/xmonad/icons"
  , bgColor      = colorBack
  , fgColor      = colorFore
  , borderColor  = color08
  , alpha        = 255

  -- layout
  , position     = TopSize L 100 36
  , border       = BottomB

  -- general behavior
  , wmClass = "xmobar"
  , wmName  = "xmobar"
  , lowerOnStart = True   -- send to bottom of window stack on start
  , hideOnStart  = False  -- start with window unmapped (hidden)
  , allDesktops  = True   -- show on all desktops
  , pickBroadest = False  -- choose widest display (multi-monitor)
  , persistent   = True   -- enable/disable hiding (True=disabled) 

  , commands = [
    -- icons
    Run $ Com "echo"   [phoenixIcon] "phoenix" 360000
    -- , Run $ Com "echo" [penguinIcon] "penguin" 360000
    -- , Run $ Com "echo" [ravenIcon]   "raven"   360000
    , Run $ Com "echo" [wolfIcon]    "wolf"    360000
    -- , Run $ Com "echo" [harpyIcon]   "harpy"   360000
    -- , Run $ Com "echo" [kiwiIcon]    "kiwi"    360000

    -- weather monitor
    , Run $ Com "xmobar_wttr" [] "wttr" 9000

    -- cpu activity monitors
    , Run $ Com "echo" [cpuIcon] "cpuicon" 36000
    , Run $ Cpu      [ "-t" , hwrap "<total>%"
                     , "-L" , "25"  -- units: %
                     , "-H" , "85"  -- units: %
                     , "-l" , color07
                     , "-n" , color11
                     , "-h" , color09
                     , "-p" , "2"
                     ] 30
    -- , Run $ CoreTemp [ "-t" , hair++"<core0>°C|<core1>°C"
    --                  , "-L" , "70"  -- units: °C
    --                  , "-H" , "80"  -- units: °C
    --                  , "-l" , color07
    --                  , "-n" , color11
    --                  , "-h" , color09
    --                  ] 50

    -- memory monitor
    , Run $ Com "echo" [hwrap memoryIcon] "memoryicon" 36000
    , Run $ Memory   [ "-t" , "<usedratio>%"++hair
                     , "-L" , "50"  -- units: %
                     , "-H" , "90"  -- units: %
                     , "-l" , color07
                     , "-n" , color11
                     , "-h" , color09
                     , "-p" , "2"
                     ] 10

    -- disk monitors
    , Run $ Com "echo" [hwrap diskUIcon] "diskuicon" 36000
    , Run $ DiskU    [ ("/"  , "<free>"++hair)
                       -- , ("/"  , hair++"<used>/<size>")
                       -- , ("sda1"  , hair++"<usedp>")
                       -- , ("sdb2"  , hair++"<usedp>")
                       -- , ("sdc1"  , hair++"<usedp>")
                       -- , ("sdd1"  , hair++"<usedp>")
                     ] [ "-L" , "15"  -- units: %
                       , "-H" , "85"  -- units: %
                       , "-l" , color09
                       , "-n" , color07
                       , "-h" , color07
                       , "-m" , "3"
                       , "-p" , "3"
                       , "-S" , "true"
                       ] 600
    , Run $ Com "echo" [hwrap diskIOIcon] "diskioicon" 36000
    , Run $ DiskIO [ ("/"  , (fn 1 "R")++"<read>"++(hwrap "/")++(fn 1 "W")++"<write>"++hair)
                     -- , ("sda1"  , hair++"<usedp>")
                     -- , ("sdb2"  , hair++"<usedp>")
                     -- , ("sdc1"  , hair++"<usedp>")
                     -- , ("sdd1"  , hair++"<usedp>")
                   ] [ "-L" , "10000"  -- units: b/s
                     , "-H" , "100000" -- units: b/s
                     , "-l" , color07
                     , "-n" , color11
                     , "-h" , color09
                     , "-m" , "4"
                     , "-p" , "3"
                     , "-S" , "true"
                     ] 10

    -- network activity monitor
    , Run $ Com "echo" [hwrap dynNetworkIcon] "dynnetworkicon" 36000
    , Run $ DynNetwork [ "-t" ,  netDownIcon++hair++"<rx>"++(hwrap netUpIcon)++"<tx>"++hair
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
    , Run $ Date ("%a"++(hwrap "%b")++"%d %H:%M") "date" 10

    -- battery
    , Run $ Com "echo" [hwrap batteryIcon] "batteryicon" 36000
    , Run $ BatteryP ["BAT0"] ["-t", "<acstatus>"
                              , "-L", "10"
                              , "-H", "80"
                              , "-l", color09
                              , "-h", color07
                              , "-p", "3"
                              , "--"
                              , "-O", boltIcon ++ "<left>%"
                              , "-i", boltIcon ++ "<left>%"
                              , "-o", "<left>%"
                              ] 100

    -- audio controle
    -- , Run $ Alsa

    -- keyboard layout indicator
    , Run $ Kbd [("us" , "US")]

    -- trayer padding
    , Run $ Com "trayer_padding" [] "trayerpad" 20

    -- read IO & Logs
    , Run $ UnsafeXPropertyLog "_XMONAD_LOG_1"
    , Run $ UnsafeStdinReader
    ]

  -- Plugins:
  -- (icons)    phoenix, penguin, raven, wolf, harpy, kiwi
  --            for plugin icons: [plugin-id]icon
  -- (cpu)      cpu, multicpu, cpufreq, coretemp
  -- (ram+disk) memory, disku, diskio
  -- (gpu)      TODO: nvidia-smi --query-gpu=utilization.memory,memory.used,memory.total --format=csv[,noheader,nounits]
  -- (info)     kbd, UnsafeXPropertyLog UnsafeStdinReader
  , sepChar  = "%"
  , alignSep = "}{"
  , template = (cwrap color05 " %wolf% "
                ++ "%_XMONAD_LOG_1%"
                ++ sep
                ++ (cwrap color04 "%cpuicon%") ++ "%cpu%"
                ++ greySep
                ++ (cwrap color05 "%memoryicon%") ++ "%memory%"
                ++ greySep
                ++ (cwrap color11 "%diskuicon%") ++ "%disku%"
                ++ greySep
                ++ (cwrap color11 "%diskioicon%") ++ "%diskio%"
                ++ greySep
                ++ (cwrap color14 "%dynnetworkicon%") ++ "%dynnetwork%"
                ++ "}{"
                ++ "<action=`xmobar_wttr`>%wttr%</action>"
                ++ sep
                ++ (cwrap color10 "%batteryicon%") ++ "%battery%"
                ++ sep
                ++"%date%"
                ++ " <icon=arch_20.xpm/>"
                ++ "%trayerpad% "
               )
  }

  where
    fn :: Integer -> String -> String
    fn n c = "<fn=" ++ show n ++ ">" ++ c ++ "</fn>"
    cwrap :: String -> String -> String
    cwrap c s = "<fc=" ++ c ++ ">" ++ s ++ "</fc>"
    greySep :: String
    greySep = cwrap color08 (fn 1 "|")
    sep :: String
    sep = cwrap color00 " | "
    hair :: String
    hair = fn 1 " "
    hwrap :: String -> String
    hwrap s = hair ++ s ++ hair

    phoenixIcon, penguinIcon, ravenIcon, wolfIcon, harpyIcon, kiwiIcon :: String
    phoenixIcon = fn 5 "\xf3dc"
    penguinIcon = fn 5 "\xf17c"
    ravenIcon = fn 5 "\xf520"
    wolfIcon = fn 5 "\xf514"
    harpyIcon = fn 5 "\xf3f8"
    kiwiIcon = fn 5 "\xf535"
    cpuIcon, memoryIcon, diskUIcon, diskIOIcon, dynNetworkIcon, netUpIcon, netDownIcon, batteryIcon, boltIcon :: String
    cpuIcon = fn 2 "\xf2db"
    memoryIcon = fn 2 "\xf538"
    diskUIcon = fn 2 "\xf0a0"
    diskIOIcon = fn 2 "\xf1ce"
    dynNetworkIcon = fn 2 "\xf6ff"
    netUpIcon = fn 2 "\xf102"  -- fn 2 "\xf0d8"
    netDownIcon = fn 2 "\xf103"  -- fn 2 "\xf0d7"
    batteryIcon = fn 2 "\xf240"
    boltIcon = fn 2 "\xf0e7"
    
