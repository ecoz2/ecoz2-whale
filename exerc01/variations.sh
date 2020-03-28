# Adjust these as needed:
N=100
M=2048

echo "TRAINING..."
for class in `ls data/sequences/TRAIN/M${M}/`; do
  ecoz2 hmm learn -N ${N} data/sequences/TRAIN/M${M}/$class &
done
wait
echo "TRAININGS COMPLETED.  N=$N  M=$M"


echo "CLASSIFYING TRAINING SEQUENCES"
ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a0.3 --sequences data/sequences/TRAIN/M${M}

echo "CLASSIFYING TEST SEQUENCES"
ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a0.3 --sequences data/sequences/TEST/M${M}

echo "** DONE **"
