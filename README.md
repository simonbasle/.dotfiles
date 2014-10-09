#Dotfiles for Simon
*Based on Zsh, Oh-My-Zsh and Antigen*

clone into ~/.dotfiles/
    cd ~
    ln -s ~/.dotfiles/zshrc .zshrc

##Themes and Putty
 - Check "Allow selection of variable-pitch fonts"
 - Use font DejaVu Sans Mono size 10
 - Use cleartype
 - Set translation encoding to UTF-8

###Solarized dark theme on putty saved session
Create a .reg file with content below.
Replace PUTTYCONFIG by the name of the putty saved session you want to colorize:

    Windows Registry Editor Version 5.00
    
    [HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Raspberry]
    "Colour0"="131,148,150"
    "Colour1"="147,161,161"
    "Colour2"="0,43,54"
    "Colour3"="7,54,66"
    "Colour4"="0,43,54"
    "Colour5"="238,232,213"
    "Colour6"="7,54,66"
    "Colour7"="0,43,54"
    "Colour8"="220,50,47"
    "Colour9"="203,75,22"
    "Colour10"="133,153,0"
    "Colour11"="88,110,117"
    "Colour12"="181,137,0"
    "Colour13"="101,123,131"
    "Colour14"="38,139,210"
    "Colour15"="131,148,150"
    "Colour16"="211,54,130"
    "Colour17"="108,113,196"
    "Colour18"="42,161,152"
    "Colour19"="147,161,161"
    "Colour20"="238,232,213"
    "Colour21"="253,246,227"

That's the Solarized Dark theme as found on [Solarized github's putty section](https://github.com/altercation/solarized/tree/master/putty-colors-solarized).
