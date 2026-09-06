# Entropy Analysis of Epileptic EEG Signals

**January 2026**

## Overview

This project presents the implementation and methodological analysis of **Approximate Entropy (ApEn)** for the analysis of epileptic Electroencephalography (EEG) signals using MATLAB.

The study investigates the ability of entropy-based analysis to characterize the complexity and dynamical behavior of EEG recordings and to distinguish between epileptic and non-epileptic brain activity.

## Dataset

The analysis was conducted using the **Bonn EEG dataset**, consisting of **500 EEG recordings** distributed across five categories, with **4,097 samples per recording**.

The dataset includes EEG recordings representing both epileptic and non-epileptic brain activity, enabling the investigation of differences in signal complexity through entropy-based measures.

## Methodology

The project includes:

* Implementation of the **Approximate Entropy (ApEn)** algorithm in MATLAB.
* Preprocessing and analysis of EEG recordings.
* Computation of entropy measures for individual EEG signals.
* Statistical and methodological investigation of ApEn values across the different EEG categories.
* Comparison of entropy characteristics between epileptic and non-epileptic EEG signals.
* Visualization and analysis of the obtained results.

## Project Structure

```text
ApEn-Analysis-of-Epileptic-EEG-Signals/
│
├── entropy_EEG_analysis.m
├── BonnEEGdata.mat
├── variance_test.fig
├── Γράφημα_Εντροπίας.png
└── README.md
```

## Authors

**Nikolaos Theodoros Papadopoulos**
**Athanasios Sdougkos**

## References

1. R. G. Andrzejak, K. Lehnertz, F. Mormann, C. Rieke, P. David, and C. E. Elger,
   *Indications of nonlinear deterministic and finite-dimensional structures in time series of brain electrical activity: Dependence on recording region and brain state*,
   **Physical Review E, Volume 64, 061907**.

2. U. Rajendra Acharya, H. Fujita, V. K. Sudarshan, S. Bhat, and J. E. W. Koh,
   *Application of entropies for automated diagnosis of epilepsy using EEG signals: A review*.

3. M. Borowska,
   *Entropy-Based Algorithms in the Analysis of Biomedical Signals*.

## Copyright

© 2026 Nikolaos Theodoros Papadopoulos and Athanasios Sdougkos. All rights reserved.

This repository and its contents are protected by copyright. No part of this project, including the source code, datasets, figures, documentation, or other materials, may be reproduced, modified, distributed, or used for commercial purposes without prior written permission from the copyright holders.
