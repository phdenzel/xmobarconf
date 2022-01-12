module XMobarConfGenerator
( Config   (..)
, Position (..)
, Align    (..)
, Border   (..)
, Command  (..)
, Run      (..)
, config
, export
) where

import Data.List

data Config = Config { font             :: String
                     , additionalFonts  :: [String]
                     , iconRoot         :: String
                     , wmClass          :: String
                     , wmName           :: String
                     , bgColor          :: String
                     , fgColor          :: String
                     , alpha            :: Int
                     , position         :: Position
                     , textOffset       :: Int
                     , textOffsets      :: [Int]
                     , iconOffset       :: Int
                     , border           :: Border
                     , borderColor      :: String
                     , borderWidth      :: Int
                     , lowerOnStart     :: Bool
                     , hideOnStart      :: Bool
                     , allDesktops      :: Bool
                     , overrideRedirect :: Bool
                     , pickBroadest     :: Bool
                     , persistent       :: Bool
                     , commands         :: [Run Command]
                     , sepChar          :: String
                     , alignSep         :: String
                     , template         :: String
                     }

cfgPairs :: [(String, (Config -> String))]
cfgPairs = [ ("font"             , show.font             )
           , ("additionalFonts"  , show.additionalFonts  )
           , ("iconRoot"         , show.iconRoot         )
           , ("wmClass"          , show.wmClass          )
           , ("wmName"           , show.wmName           )
           , ("bgColor"          , show.bgColor          )
           , ("fgColor"          , show.fgColor          )
           , ("alpha"            , show.alpha            )
           , ("position"         , show.position         )
           , ("textOffset"       , show.textOffset       )
           , ("textOffsets"      , show.textOffsets      )
           , ("iconOffset"       , show.iconOffset       )
           , ("border"           , show.border           )
           , ("borderColor"      , show.borderColor      )
           , ("borderWidth"      , show.borderWidth      )
           , ("lowerOnStart"     , show.lowerOnStart     )
           , ("hideOnStart"      , show.hideOnStart      )
           , ("allDesktops"      , show.allDesktops      )
           , ("overrideRedirect" , show.overrideRedirect ) 
           , ("pickBroadest"     , show.pickBroadest     )
           , ("persistent"       , show.persistent       )
           , ("commands"         , show.commands         )
           , ("sepChar"          , show.sepChar          )
           , ("alignSep"         , show.alignSep         )
           , ("template"         , show.template         )
           ]

config :: Config
config = Config {
  font               = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
  , additionalFonts  = []
  , iconRoot         = "."
  , wmClass          = "xmobar"
  , wmName           = "xmobar"
  , bgColor          = "black"
  , fgColor          = "grey"
  , alpha            = 255
  , position         = Top
  , textOffset       = 0
  , textOffsets      = []
  , iconOffset       = 0
  , border           = NoBorder
  , borderColor      = ""
  , borderWidth      = 0
  , lowerOnStart     = True --
  , hideOnStart      = False --
  , allDesktops      = True
  , overrideRedirect = True
  , pickBroadest     = False
  , persistent       = False
  , commands         = []
  , sepChar          = "%"
  , alignSep         = "}{"
  , template         = ""
  }

-- Must be rewritten, to remove unnecessary defaults
instance Show Config where
  showsPrec _ n s = "Config {" ++ e n ++ "}" ++ s
    where e x = intercalate ", " [g (fst y) | y <- f x, uncurry (/=) y]
          f x = zip (h x) (h config)
          g x = fst x ++ " = " ++ snd x
          h x = map (\y -> (fst y, snd y x)) cfgPairs

data Position = Top    | TopW    Align Int | TopSize    Align Int Int
              | Bottom | BottomW Align Int | BottomSize Align Int Int
              | Static { xpos  :: Int, ypos   :: Int
                       , width :: Int, height :: Int
                       } deriving Show

data Align = L | C | R deriving Show

data Border = TopB    | TopBM    Int
            | BottomB | BottomBM Int
            | FullB   | FullBM   Int
            | NoBorder deriving Show

data Command = Uptime                                [String] Int
             | Weather            String             [String] Int
             | Network            String             [String] Int
             | DynNetwork                            [String] Int
             | Wireless           String             [String] Int
             | Memory                                [String] Int
             | Swap                                  [String] Int
             | Cpu                                   [String] Int
             | MultiCpu                              [String] Int
             | Battery                               [String] Int
             | BatteryP           [String]           [String] Int
             | TopProc                               [String] Int
             | TopMem                                [String] Int
             | DiskU              [(String, String)] [String] Int
             | DiskIO             [(String, String)] [String] Int
             | ThermalZone        Int                [String] Int
             | Thermal            String             [String] Int
             | CpuFreq                               [String] Int
             | CoreTemp                              [String] Int
             | Volume             String String      [String] Int
             | MPD                                   [String] Int
             | Mpris1             String             [String] Int
             | Mpris2             String             [String] Int
             | Mail               [(String, String)] String
             | Mbox               [(String, String, String)] [String] String
             | XPropertyLog       String
             | NamedXPropertyLog  String String
             | Brightness         [String]                    Int
             | Kbd                [(String, String)]
             | Locks
             | Com                String [String] String      Int
             | StdinReader
             | UnsafeStdinReader
             | Date               String String               Int
             | DateZone           String String String String Int
             | CommandReader      String String
             | PipeReader         String String
             | BufferedPipeReader String [(Int, Bool, String)]
             | XMonadLog
             | UnsafeXMonadLog
             deriving Show

data Run a = Run a

-- Must be rewritten, as derived version inserts parens
instance Show a => Show (Run a) where
  showsPrec _ (Run x) s = "Run " ++ show x ++ s

export :: Config -> IO ()
export = writeFile ".xmobarrc".show

-- Example of Main module use:
-- main = export $ config { ... }
-- remember to put a "$" after every "Run"
-- otherwise, configure it the same as you would a normal .xmobarrc
