# Adjust these as convenient:
N=16
M=1024
Aparam="-a=0.1"
Iparam=

echo "TRAINING..."
for class in `ls data/sequences/TRAIN/M${M}/`; do
  ecoz2 hmm learn -N=${N} $Aparam $Iparam data/sequences/TRAIN/M${M}/${class} &
done
wait
echo
echo "TRAINING COMPLETED.  N=$N  M=$M  Aparam=$Aparam  Iparam=$Iparam"

echo
echo "CLASSIFYING TRAINING SEQUENCES"
ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a0.3 --sequences data/sequences/TRAIN/M${M}

echo
echo "CLASSIFYING TEST SEQUENCES"
ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a0.3 --sequences data/sequences/TEST/M${M}

echo "** DONE **"
