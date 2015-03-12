#! /bin/zsh

typeset -Ag FX FG BG

FX=(
                                        none                         "\e[00m"
                                        normal                       "\e[22m"
    bold                      "\e[01m"  no-bold                      "\e[22m"
    faint                     "\e[02m"  no-faint                     "\e[22m"
    standout                  "\e[03m"  no-standout                  "\e[23m"
    underline                 "\e[04m"  no-underline                 "\e[24m"
    blink                     "\e[05m"  no-blink                     "\e[25m"
    fast-blink                "\e[06m"  no-fast-blink                "\e[25m"
    reverse                   "\e[07m"  no-reverse                   "\e[27m"
    conceal                   "\e[08m"  no-conceal                   "\e[28m"
    strikethrough             "\e[09m"  no-strikethrough             "\e[29m"
    gothic                    "\e[20m"  no-gothic                    "\e[22m"
    double-underline          "\e[21m"  no-double-underline          "\e[22m"
    proportional              "\e[26m"  no-proportional              "\e[50m"
    overline                  "\e[53m"  no-overline                  "\e[55m"

                                        no-border                    "\e[54m"
    border-rectangle          "\e[51m"  no-border-rectangle          "\e[54m"
    border-circle             "\e[52m"  no-border-circle             "\e[54m"

                                        no-ideogram-marking          "\e[65m"
    underline-or-right        "\e[60m"  no-underline-or-right        "\e[65m"
    double-underline-or-right "\e[61m"  no-double-underline-or-right "\e[65m"
    overline-or-left          "\e[62m"  no-overline-or-left          "\e[65m"
    double-overline-or-left   "\e[63m"  no-double-overline-or-left   "\e[65m"
    stress                    "\e[64m"  no-stress                    "\e[65m"

                                        font-default                 "\e[10m"
    font-first                "\e[11m"  no-font-first                "\e[10m"
    font-second               "\e[12m"  no-font-second               "\e[10m"
    font-third                "\e[13m"  no-font-third                "\e[10m"
    font-fourth               "\e[14m"  no-font-fourth               "\e[10m"
    font-fifth                "\e[15m"  no-font-fifth                "\e[10m"
    font-sixth                "\e[16m"  no-font-sixth                "\e[10m"
    font-seventh              "\e[17m"  no-font-seventh              "\e[10m"
    font-eigth                "\e[18m"  no-font-eigth                "\e[10m"
    font-ninth                "\e[19m"  no-font-ninth                "\e[10m"
)

colors=(black red green yellow blue magenta cyan white)
for color in {0..255}; do
  if (( $color >= 0 )) && (( $color < $#colors )); then
    index=$(( $color + 1 ))
    FG[$colors[$index]]="\e[38;5;${color}m"
    BG[$colors[$index]]="\e[48;5;${color}m"
  fi

  FG[$color]="\e[38;5;${color}m"
  BG[$color]="\e[48;5;${color}m"
done
unset color{s,} index

FG[none]="$FX[none]"
BG[none]="$FX[none]"
FG[reset]="$FX[reset-fg]"
BG[reset]="$FX[reset-fg]"
FG[default]="$FX[reset-fg]"
BG[default]="$FX[reset-fg]"

function rgb-to-color () {
    red=$1
    green=$2
    blue=$3
    color=$(( 16 + ${red} * 36 + ${green} * 6 + ${blue} ))
    print "${color}: \033[48;05;${color}m  \033[0m"
}

function print-color-grid () {
    print
    print "System colors:\n"
    print -n "  "
    for color ({0..7}); do
        print -n "\033[48;05;${color}m  "
    done
        print -n "\033[0m\n  "
    for color ({8..15}); do
        print -n "\033[48;05;${color}m  "
    done
    print -n "\033[0m\n\n"

    print "Color cube, 6x6x6:\n"
    for green ({0..6}); do
        if [[ ${green} < 6 ]]; then
            print -n "G ${green}"
        else
            print -n "B  "
        fi

        for red ({0..5}); do
            for blue ({0..5}); do
                if [[ ${green} < 6 ]]; then
                    (( color =  16 + $red * 36 + $green * 6 + $blue ))
                    print -n "\033[48;5;${color}m  "
                else
                    print -n " ${blue}"
                fi
             done
            print -n "\033[0m "
        done
        print
    done

    print
    print "Grayscale ramp:\n";
    print -n "  "
    for color ({232..255}); do
        print -n "\033[48;5;${color}m  "
    done
    print -n "\033[0m\n"
    print
}
