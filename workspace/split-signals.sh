set -ue

PATH="$HOME/.cargo/bin:$PATH"

train_fraction=0.8
OUT=tt-list.csv

echo "Writing TRAIN and TEST instance lists to ${OUT}  (train_fraction=${train_fraction})"
echo "tt,class,selection" > ${OUT}
for class in `ls data/signals/`; do
  ecoz2 util split \
          --file-ext .wav \
          --train-fraction=${train_fraction} \
          --files data/signals/${class} >> ${OUT}
done
echo "Done.  Total train instances: `grep TRAIN ${OUT} | wc -l`"
echo "       Total  test instances: `grep  TEST ${OUT} | wc -l`"
