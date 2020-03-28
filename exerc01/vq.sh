# Adjust these as convenient:
P=36
e=0.0005

echo "TRAINING..."
for class in `ls data/predictors/TRAIN/`; do
  ecoz2 vq learn -P $P -e $e -w "$class" data/predictors/TRAIN/${class} &
done
wait
echo
echo "TRAINING COMPLETED.  P=$P  e=$e"

echo
echo "CLASSIFYING TRAINING PREDICTORS"
ecoz2 vq classify --codebooks data/codebooks/[A-Z]*/eps_${e}_M_1024.cbook --predictors data/predictors/TRAIN

echo
echo "CLASSIFYING TEST PREDICTORS"
ecoz2 vq classify --codebooks data/codebooks/[A-Z]*/eps_${e}_M_1024.cbook --predictors data/predictors/TEST

echo "** DONE **"
