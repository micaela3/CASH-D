# Return minutes and seconds remaining, zero-padded
def getTimerString(timer)
    (timer/(60*60)).floor.to_s.rjust(2, "0") + ":" + ((timer/60)%60).floor.to_s.rjust(2, "0")
end