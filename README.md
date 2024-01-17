[![DOI:10.5281/zenodo.5826183](https://zenodo.org/badge/DOI/10.5281/zenodo.5826183.svg)](https://doi.org/10.5281/zenodo.5826182)

# HyperCSP
Implementation of a new formulation of Common Spatial Patterns for EEG hyperscanning data (also known as EEG multi-brain data) named hyperCSP. 
The EEG hyperscanning dataset is available at: under .


***A guide for researchers to follow in designing their study with a view to sharing data on the [WIN XNAT Open Data server](https://cassgvp.github.io/WIN-Open-Neuroimaging-Community/docs/tools/data.html).***

This is the GitLab repository for the development and early consultation on the WIN data sharing decision tree.

---

## Abstract
This work proposes a new formulation for common spatial patterns (CSP), often used as a powerful feature extraction technique in brain-computer interfacing (BCI) and other neurological studies. In this approach, applied to multiple subjects’ data and named as hyperCSP, the individual covariance and mutual correlation matrices between multiple simultaneously recorded subjects’ electroencephalograms are exploited in the CSP formulation. This method aims at effectively isolating the common motor task between multiple heads and alleviate the effects of other spurious or undesired tasks inherently or intentionally performed by the subjects. This technique can provide a satisfactory classification performance while using small data size and low computational complexity. By using the proposed hyperCSP followed by support vector machines classifier, we obtained a classification accuracy of 81.82% over 8 trials in the presence of strong undesired tasks. We hope that this method could reduce the training error in multi-task BCI scenarios. The recorded valuable motor-related hyperscanning dataset is available for public use to promote the research in this area.


## The solution
We are developing a flow chart which researchers can walk through to address the question "Can I share my data on the [WIN XNAT Open Data server](https://open.win.ox.ac.uk/pages/open-science/community/Open-WIN-Community/docs/tools/data/)?".

*Working through this flow chart will aid researchers in designing their projects and conducting the necessary stages of data preparation in order to share their data without compromising their ethical and legal obligations to participants and research funders.*

## What are we doing?

The Open WIN Steering Committee have been working to delineate the stages a researcher should (and in some cases *must*) go through in order to share their data in accordance with University of Oxford Best Practice and GDPR.

We are now opening this work up to the community to provide feedback on bottlenecks, missing guidance and further refinements.

This consultation will start by inviting a small number of researchers (with a range of data types) to comment on the proposed guidance. Notes from these consultation meetings are shared below.

- [Meeting 1: Process 1-3](./docs/CallNotes-SoftLaunch-process1-3.md)
- [Meeting 2: Process 4-5](./docs/CallNotes-SoftLaunch-process4-5.md)

**You can track our progress in this project in our [issues task list](https://git.fmrib.ox.ac.uk/open-science/community/data-sharing-decision-tree/-/issues) and [milestones](https://git.fmrib.ox.ac.uk/open-science/community/data-sharing-decision-tree/-/milestones).**

## What do we need

We need researchers to walk through these documents with their existing or hypothetical research projects, to help us to identify gaps, issues and solutions.

Take a look at these documents:
- [The decision tree](./docs/decision-tree.md)
- [Appendices and notes](./docs/decision-tree-appendicies.md)

If you'd like to comment on these documents or contribute to the development of this resource, please take a look at the [CONTRIBUTING](CONTRIBUTING.md) guide.


## Who are we

This project is being lead by the [Open WIN Steering Group](https://www.win.ox.ac.uk/open-win)

Contributions to the development of this resource will be solicited from the [Open WIN Community](https://open.win.ox.ac.uk/pages/open-science/community/Open-WIN-Community/docs/community/)

The XNAT Open Data Server is being developed by the [Open Data Team](https://open.win.ox.ac.uk/pages/open-science/community/Open-WIN-Community/docs/tools/data/#working-group-members-alphabetically)


## Contact us

The easiest way to get in touch is via our [GitLab issues](https://git.fmrib.ox.ac.uk/open-science/data-sharing-decision-tree/-/issues). Leave a comment or feedback and we'll be in touch!

You are also welcome to email the Open WIN Community Engagement Coordinator  at [cassandra.gouldvanpraag@psych.ox.ac.uk](mailto:cassandra.gouldvanpraag@psych.ox.ac.uk), to discuss this project, make suggestions, or just say "Hi"!

## Thank you!

Thank you for taking the time to look at these documents. We are excited to build this essential tool to help you deliver on your ambitions to share your data with the world.

# Acknowledgements and citation

Please review our [acknowledgements and requirements for citing this resource](ACKNOWLEDGEMENTS.md).





**REFERENCE: A. Falcon-Caro, S. Shirani, J.F. Ferreira, J.J. Bird, and S. Sanei, "Formulation of Common Spatial Patterns for Multi-task Hyperscanning BCI", Jan. 2024, available:**





