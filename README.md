This space captures VQ/HMM classification exercises
on labelled whale song unit data.

## Status

Complete exercises with some level of model tuning.

A general presentation about VQ/HMM and its application on the
initial set of exercises described here can be found at
https://github.com/ecoz2/ecoz2-doc/blob/master/exploration/vqhmm-whale.pdf.

## Exercises

- [exerc00](exerc00): On 10 labelled files.

- [exerc01](exerc01): On a 4.5 hour recording.

- [exerc02](exerc02): As exerc01 but with some underlying adjustments in
  programs parameters and file organization.

- exerc03: related with the "windy" interval in the 4.5 recording:

  - [exerc03a](exerc03a): excluding the windy interval
  - [exerc03b](exerc03b): only considering the windy interval

- [exerc04](exerc04): As exerc01 but with number of refinements iterations
  set to 120

- exerc05: As exerc01 but with order of prediction P = 20
  according to rule of thumb P = 4 + f<sub>s</sub> / 1000,
  where the sampling frequency f<sub>s</sub> is 16kHz in our case.

  - [exerc05](exerc05a): Other parameters as in previous exercises
  - [exerc05b](exerc05b): Only considering classes with at least 100 instances
  - [exerc05c](exerc05c): Only considering classes with at least 200 instances

- exerc06: As exerc05c but merging classes "I" and "I2" into a "II" class.
  - [exerc06](exerc06)

## Signal inspection

See [signal-inspection](signal-inspection).
