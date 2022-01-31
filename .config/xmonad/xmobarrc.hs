Config
        { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
        , borderColor = "#2F343F"
        , border = TopB
        , bgColor = "#2F343F"
        , fgColor = "grey"
        , position = TopW L 100
        , commands =
                [ Run Network "eno1" ["-L", "0", "-H", "32", "--normal", "green", "--high", "red"] 10
                , Run Cpu ["-L", "3", "-H", "50", "--normal", "green", "--high", "red"] 10
                , Run Memory ["-t", "Mem: <usedratio>%"] 30
                , Run Date "%a %b %_d %Y %H:%M:%S" "date" 2
                , Run Kbd [("ru", "RU"), ("us", "US")]
                , Run Com "/usr/bin/bash" ["/home/vova/.config/xmonad/scripts/volume"] "vol" 10
                , Run XMonadLog
                ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%XMonadLog%}{%kbd% | %vol% | %cpu% | %memory% | %eno1% | <fc=#ee9a00>%date%</fc> "
        }
