import XMonad
import XMonad.Config.Kde (kdeConfig)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.StatusBar (statusBarProp, withSB)
import qualified XMonad.Hooks.StatusBar as StatusBar
import XMonad.Hooks.StatusBar.PP (xmobarPP)
import XMonad.Layout.Gaps (gaps)
import qualified XMonad.Layout.Gaps as Gaps
import qualified XMonad.Layout.LayoutModifier as LayoutModifier
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (spacingRaw)
import qualified XMonad.Layout.Spacing as Spacing
import XMonad.Util.EZConfig (additionalKeysP)

main :: IO ()
main = xmonad . ewmh . docks . withSB myStatusBar $ myConfig

myStatusBar :: StatusBar.StatusBarConfig
myStatusBar = statusBarProp "xmobar ~/.config/xmonad/xmobarrc.hs" (pure xmobarPP)

myTerminal :: String
myTerminal = "alacritty"

myKeys :: [([Char], X ())]
myKeys =
  [ ("M-<Return>", spawn myTerminal)
  , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
  , ("M-q", kill)
  , ("M-d", spawn "rofi -show drun")
  , ("M-b", spawn "brave")
  , ("M-f", spawn "dolphin")
  , ("M-r", spawn "emacsclient -c")
  , ("M-S-z", spawn "xset dpms force off")
  , ("M-<Print>", spawn "spectacle -r")
  , ("<Print>", spawn "spectacle")
  , ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 5%-")
  , ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 5%+")
  , ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
  ]

myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
  spawn "setxkbmap -layout us,ru  -option 'grp:alt_shift_toggle'"
  spawn "bash ~/.config/xmonad/scripts/autostart.sh"

mySpacing :: l a -> LayoutModifier.ModifiedLayout Spacing.Spacing l a
mySpacing =
  spacingRaw
    True -- False=Apply even when single window
    (Spacing.Border 0 5 5 5) -- Screen border size top bot rght lft
    True -- Enable screen border
    (Spacing.Border 3 3 3 3) -- Window border size
    True -- Enable window borders

myLayout = smartBorders . mySpacing . avoidStruts . gaps [(Gaps.U, 2)] $ layoutHook kdeConfig

myConfig =
  kdeConfig
    { terminal = myTerminal
    , modMask = mod4Mask
    , borderWidth = 2
    , focusedBorderColor = "#5e81ac"
    , layoutHook = myLayout
    , startupHook = myStartupHook
    , handleEventHook = handleEventHook . ewmhFullscreen $ kdeConfig
    }
    `additionalKeysP` myKeys
