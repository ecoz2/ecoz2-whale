# Adjust these as convenient:
N=16
M=1024
Aval=0.3
Aparam="-a=${Aval}"
Iparam=

SECONDS=0
echo "TRAINING..."
for class in `ls data/sequences/TRAIN/M${M}/`; do
  ecoz2 hmm learn -N=${N} $Aparam $Iparam data/sequences/TRAIN/M${M}/${class} &
done
wait
duration=$SECONDS
echo
echo "TRAINING COMPLETED. ($((duration / 60))mins:$((duration % 60))secs)"
echo " N=$N  M=$M  Aparam=$Aparam  Iparam=$Iparam"

echo
echo "CLASSIFYING TRAINING SEQUENCES"
ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a${Aval} --sequences data/sequences/TRAIN/M${M}

echo
echo "CLASSIFYING TEST SEQUENCES"
ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a${Aval} --sequences data/sequences/TEST/M${M}

## the following as an exploration of those classes having at least 20 test instances:
#echo
#echo "CLASSIFYING A SUBSET OF THE TEST SEQUENCES"
#ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a${Aval}/{A,Bm,C,D,E,F,G2,H,I,I2,I3,P}.hmm --sequences data/sequences/TEST/M${M}/{A,Bm,C,D,E,F,G2,H,I,I2,I3,P}

duration=$SECONDS
echo "** DONE **  ($((duration / 60))mins:$((duration % 60))secs)"
echo " N=$N  M=$M  Aparam=$Aparam  Iparam=$Iparam"
echo
