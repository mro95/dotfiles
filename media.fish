#!/usr/bin/fish

set volume (amixer sget Master | grep -oE '\[1?[0-9]{1,2}%\]' | \
            grep -oE '[0-9]+' | perl -e '$v = <>; print int($v / 10 + 0.5) * 10')

for i in $argv
    switch $i
        case 'toggle'
            mpc -h mpd toggle
        case 'next'
            mpc -h mpd next
        case 'prev'
            mpc -h mpd prev
        case 'up'
            amixer sset Master (math $volume + 10)'%'
        case 'down'
            amixer sset Master (math $volume - 10)'%'
        case 'rup'
            mpc -h mpd volume +4
        case 'rdown'
            mpc -h mpd volume -4
        case 'mute'
            amixer sset Master toggle
    end
end

touch /tmp/info_panel_update