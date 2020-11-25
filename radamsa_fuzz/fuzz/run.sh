hangs=0
crashes=0
while true
do
  radamsa -o fuzz/fuzz-%n -n 100 samples/*
  for f in ./fuzz/*; do
    timeout 0.1s ./wrapper/main "$f"
    ret=$?
    if [ $ret -gt 127 ] ; then
      echo "$f caused a crash"
      echo crash-$(( crashes+=1 ))
      mv $f ./crashes/crash-$crashes
    fi
    if [ $ret -eq 124 ] ; then
      echo "$f caused a hang"
      echo hang-$(( hangs+=1 ))
      mv $f ./hangs/hang-$hangs
    fi
  done
done
