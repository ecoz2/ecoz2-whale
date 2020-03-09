This space captures VQ/HMM classification exercises
on labelled whale song unit data.

## Status

Preliminary. No model tuning per se at all.
Main goal has been to capture initial tests of the VQ/HMM 
code I wrote many years ago, which I'm revising and updating 
as I play with the whale song files (https://github.com/ecoz2/ecoz2). 

These notes are pretty terse in general.
A general presentation about VQ/HMM and its application in these exercises 
can be found at https://github.com/ecoz2/ecoz2-doc/blob/master/exploration/vqhmm-whale.pdf.

# About the labelled files

The following files constitute the initial set of 10 labelled files
used as a basis for the exercises described here:

```
Wave file                     selection file (TSV)
========================      ===================
HBSe_20151023T122324.wav      20151023T122324.txt
HBSe_20151121T040102.wav      20151121T040102.txt
HBSe_20151207T070326.wav      20151207T070326.txt
HBSe_20151228T103639.wav      20151228T103639.txt
HBSe_20161101T153358.wav      20161101T153358.txt
HBSe_20161207T115528.wav      20161207T115528.txt
HBSe_20170107T085150.wav      20170107T085150.txt
HBSe_20170116T054541.wav      20170116T054541.txt
HBSe_20170424T102157.wav      20170424T102157.txt
```

These original files are not captured in this repository.
However, using a separate tool (written in scala), all unit selections 
were extracted as individual WAV files and committed into this repository.
They are located under corresponding class name subdirectories at `data/signals/*`:

```
$ ls data/signals

ascending_grunt            groan                      modulated_cry_(D)
ascending_moan             groan_+_purr               modulated_moan
ascending_moan?            groan_+purr                modulated_moan_+_upsweep
ascending_moan_(D)         growl                      modulated_moans_(F)
ascending_moan_+_purr      growl+gurgle               pulse
ascending_shriek           grumble                    pulses
ascending_shriek,_higher   grunt                      purr
ascending_shriek_(D)       grunt_(long)               purr_(D)
bark                       grunt_(s)                  purr_+_modulated_moan
bark?                      grunt_(short)              scream
bark_(D)                   grunt_+_modulated_moan     screech_?
bellow                     grunt_echo                 short_moan
broadband_burst            grunts                     sigh
creek                      gurgle                     siren
croak                      gurgle?                    snort
cry                        gurgle?_ascending__        thwop
descending_grunt           gurgle_+_descending_shriek trill
descending_moan            gurgle_+_trill             trill?
descending_moan_(F)        gurgle_+modulated_moan     trill_(D)
descending_shriek          long_grunt                 trumpet?
descending_shriek?         low_yaps                   violin?
descending_shriek_(D)      modulated_cry              wops
```

Each subdirectory contains all WAV files corresponding to the associated
class name, which is the value of the `Description` column in all
selection files, except in the case of `20151207T070326.txt`, where the
selected column was `Description (Dunlop & Fournet)`.

(Spaces have been converted to underscores in all class names.)

As an example, these are the selection WAV files for the `croak` class:

```
$ ls data/signals/croak
from_HBSe_20151228T103639__333.30273_334.11978.wav
from_HBSe_20151228T103639__345.19217_346.69003.wav
from_HBSe_20151228T103639__356.40396_359.39975.wav
from_HBSe_20151228T103639__367.97855_371.31476.wav
from_HBSe_20151228T103639__380.1414_383.13718.wav
from_HBSe_20151228T103639__391.79767_395.0658.wav
from_HBSe_20151228T103639__405.1632_408.0228.wav
from_HBSe_20151228T103639__417.58368_419.21774.wav
from_HBSe_20151228T103639__430.50308_431.8648.wav
from_HBSe_20151228T103639__441.06293_443.17358.wav
from_HBSe_20151228T103639__453.8636_455.7019.wav
from_HBSe_20170116T054541__387.63336_389.26135.wav
```

The name of each extracted file indicates the original WAV file name
and the corresponding begin and end times.

## The exercises

The exercises described here are:

- [`whale1`](whale1): Only uses selections from one of the song files.
- [`whale10`](whale10): Uses selections from the set of 10 song files.

To reproduce these exercises you will need to have the ECOZ2 executables 
(`lpc`, `vq.learn`, `hmm.classify`, etc.) on your machine.
See https://github.com/ecoz2/ecoz2.
 
Note that only the various "report" files (`.rpt`) generated during 
codebook and HMM model training are committed in this repo
(but no other generated files).
