mutations=0
hangs=0
crashes=0
seed=0
start=`date +%s`
while true
do
  radamsa -o fuzz/fuzz-%n -n 100 samples/* --seed $(( seed+=1 ))
  end=`date +%s`
  runtime=$((end-start))
  days=$((runtime / 86400)); hours=$(( (runtime / 3600) % 24)); minutes=$(( (runtime % 3600) / 60 )); seconds=$(( (runtime % 3600) % 60 )); echo "Generated mutations: "$(( mutations+=100 )) "\tRuntime: $days:$hours:$minutes:$seconds (dd:hh:mm:ss)"
  for f in ./fuzz/*; do
    timeout 1s ./wrapper/main "$f"
    ret=$?
    if [ $ret -gt 127 ] ; then
      echo "crash saved to /crashes/crash-"$(( crashes+=1 ))
      mv $f ./crashes/crash-$crashes
    fi
    if [ $ret -eq 124 ] ; then
      echo "hang saved to /hangs/hang-"$(( hangs+=1 ))
      mv $f ./hangs/hang-$hangs
    fi
  done
done

