import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Combo
--import XMonad.Layout.Accordion
import qualified XMonad.StackSet as W -- to shift and float windows
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Actions.PhysicalScreens
import XMonad.Hooks.ICCCMFocus
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig(additionalKeysP)
 
--myLayouts =  tiled ||| Mirror tiled ||| ThreeCol 1 (3/100) (1/2) ||| Full
myLayouts =  tiled ||| Mirror tiled ||| Full 
    where
        tiled = Tall 1 (3/100) (1/2)

main = xmonad $ gnomeConfig {
        -- modMask = mod4Mask,
        startupHook = setWMName "LG3D",
        logHook = takeTopFocus,
        borderWidth = 2,
        workspaces = ["1", "web", "3", "4", "5", "6", "7", "im", "email"],
--        keys       = myKeys,
        manageHook = manageHook gnomeConfig <+> myManageHook
--        layoutHook = myLayouts
    } 
    `additionalKeys` [((mod1Mask, xK_d), viewScreen 3)]
    where 
        myManageHook = composeAll 
           [ className =? "Thunderbird" --> doF (W.shift "email"),
                     className =? "Skype" --> doF (W.shift "im"),
                     className =? "Firefox" --> doF (W.shift "web"),
                     className =? "Do" --> doIgnore,
                     className =? "Gimp-2.8" --> doFloat,
                     isFullscreen --> doFullFloat]






