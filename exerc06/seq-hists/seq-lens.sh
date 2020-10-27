function generate() {
  seqs_dir=$1
  file=$2
  class=$3
  echo "generate: ${seqs_dir}"

  # echo "length" > ${file}
  # find ${seqs_dir} -name \*.seq \
  #     -exec seq-hists/seq-len.sh {} \; \
  # >> ${file}

  python3 seq-hists/seq-histogram.py ${file} ${class}
}

# individual classes:
for class in `ls data/sequences/M2048`; do
  generate data/sequences/M2048/${class} seq-hists/seq-lengths-M2048-${class}.csv ${class}
done

# all M2048 sequences:
generate data/sequences/M2048 seq-hists/seq-lengths-M2048.csv ALL
