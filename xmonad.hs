import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Combo
--import XMonad.Layout.Accordion
import qualified XMonad.StackSet as W -- to shift and float windows
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
 
-- myLayouts = tiled ||| Mirror tiled ||| Mirror (ThreeCol 1 (3/100) (1/2)) ||| Full
myLayouts =  tiled ||| Mirror tiled ||| Full 
    where
        tiled = Tall 1 (3/100) (1/2)

main = xmonad $ gnomeConfig {
        modMask = mod4Mask,
        startupHook = setWMName "LG3D",
        borderWidth = 2,
        workspaces = ["1", "web", "3", "4", "5", "6", "7", "im", "email"],
        manageHook = manageHook gnomeConfig <+> myManageHook,
        logHook = takeTopFocus,
        layoutHook = desktopLayoutModifiers myLayouts,
        handleEventHook = fullscreenEventHook
    } `additionalKeys`
    [
        ((mod4Mask, xK_s), spawn "skype-activate")
    ]
    where 
        myManageHook = composeAll 
           [ className =? "Thunderbird" --> doF (W.shift "email"),
                     className =? "Skype" --> doF (W.shift "im"),
                     className =? "Empathy" --> doF (W.shift "im"),
                     className =? "emesene" --> doF (W.shift "im"),
                     className =? "Firefox" --> doF (W.shift "web"),
                     className =? "Do" --> doIgnore,
                     className =? "Gimp-2.6" --> doFloat,
                     isFullscreen --> doFullFloat]






