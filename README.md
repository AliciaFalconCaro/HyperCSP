[![DOI:10.5281/zenodo.10523774](https://zenodo.org/badge/DOI/10.5281/zenodo.10523774.svg)](https://doi.org/10.5281/zenodo.10523774) 


# HyperCSP
Implementation of a new formulation of Common Spatial Patterns for EEG hyperscanning data (also known as EEG multi-brain data) named hyperCSP. 
The EEG hyperscanning dataset is also available.

The code provided here was tested on MATLAB2022b and EEGLAB2021.


# Citation
**Please cite this repository as:**

Falcon-Caro, A., Shirani, S., Ferreira, J. F., Bird, J. J., & Sanei, S. (2024). Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI. IEEE Transactions on Biomedical Engineering. [doi: 10.1109/TBME.2024.3356665](https://ieeexplore.ieee.org/document/10411071) 

Any publication that analyzes the dataset presented in this repository, should cite the above paper as a reference of the recording.

This resource is released under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/).

---

## Abstract
This work proposes a new formulation for common spatial patterns (CSP), often used as a powerful feature extraction technique in brain-computer interfacing (BCI) and other neurological studies. In this approach, applied to multiple subjects’ data and named as hyperCSP, the individual covariance and mutual correlation matrices between multiple simultaneously recorded subjects’ electroencephalograms are exploited in the CSP formulation. This method aims at effectively isolating the common motor task between multiple heads and alleviate the effects of other spurious or undesired tasks inherently or intentionally performed by the subjects. This technique can provide a satisfactory classification performance while using small data size and low computational complexity. By using the proposed hyperCSP followed by support vector machines classifier, we obtained a classification accuracy of 81.82% over 8 trials in the presence of strong undesired tasks. We hope that this method could reduce the training error in multi-task BCI scenarios. The recorded valuable motor-related hyperscanning dataset is available for public use to promote the research in this area.

## DATASET DESCRIPTION
EXPERIMENT INFORMATION

The data were recorded under the ethical approval from the Nottingham Trent University School of Science and Technology non-invasive Ethical Committee, under the application number 20/21/103. All the volunteers gave their written consents.

The dataset contains the EEG hyperscanning data recorded from a total of four subjects, distributed in two pairs (Subjects 1 and 2, and Subjects 3 and 4). For each pair, all the experiments were recorded on the same day. All the subjects were healthy and between 20-30 years old. Out of the four subjects, there were three males and one female. The data were recorded using two g.tec Nautilus systems with 32 wet electrodes each, at 250Hz sampling frequency. Therefore, in total, 64 channels were recorded, 32 channels for each subject. The electrode locations for each system followed the standard 10-20 international EEG electrode placement. The full description of the experiments can be found in the paper [1].

DATA STRUCTURE

The EEG data are in .MAT format and are archived in folders, divided by each experiment. Each .MAT file contains the EEG data from one pair (Subject 1 and 2, or Subject 3 and 4) and one trial.

Each of the EEG files contains three variables:

SR: The sampling rate of the system given in samples/second (Hz)

y: M×N matrix containing the raw EEG data and the annotations about the target cue information. The columns are the N sample points. The array is stored in datatype double. The M rows are divided as follows:
- Rows 1 to 32: continuous EEG data representing the 32 channels from the first subject of the pair (Subject 1 or Subject 3).
- Rows 33 to 64: continuous EEG data representing the 32 channels from the second subject of the pair (Subject 2 or Subject 4).
- Row 65: NumId
- Row 66: Group task at each time instant of the recording.

taskInfo: table structure explaining the target cue information. The table contains 3 columns:
- NumId: contains the number ID given to each cue.
- StringId: provides a summary of the target/task given to the subjects.
- Group: represents the target class:
  - 0: represents the pre-paradigm time.
  - 1: represents class one (move left hand for experiments 1 and 2, move hands for experiments 3, 4 and 5).
  - 2: represents class two (move right hand for experiments 1 and 2, perform secondary movement for experiments 3, 4 and 5).
  - 3: represents class three (move freely).
  - 4: represents the post-paradigm time.  

## Contact us

The easiest way to get in touch is via our [GitHub issues](https://github.com/AliciaFalconCaro/HyperCSP/issues).

You are also welcome to email us at [aliciafalconcaro@gmail.com](aliciafalconcaro@gmail.com), to discuss this project, make suggestions, or just say "Hi"!


[1] Falcon-Caro, A., Shirani, S., Ferreira, J. F., Bird, J. J., & Sanei, S. (2024). Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI. IEEE Transactions on Biomedical Engineering. doi: 10.1109/TBME.2024.3356665.  

