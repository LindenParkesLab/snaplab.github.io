---
layout: default
title: Essential Reading
has_children: false
has_toc: true
---

# Essential Reading
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

At the SNaP Lab, our research cuts across the fields of neuroimaging, network science, dynamical systems theory, machine learning, and more. This page contains a selection of papers from each of these fields that are considered essential reading. Each lab member should set aside time to read the papers on this list early in their tenure at the lab.

Note, the lists below are far from exhaustive. The below should be taken as a starting point for further reading.

# Neuroimaging
Most of our research uses Magnetic Resonance Imaging (MRI) data. The MRI provides diverse insight into the human brain, including recording information about brain structure and function. The MRI is capable of numerous scan types; a complete discussion of which is beyond the scope of this page. Most relevant to us are the scans that produce T1-weighted images (T1w), the diffusion-weighted images (DWI), and the echo-planar images (EPI). These three scan index brain structure (sMRI), white matter (dMRI), and function (fMRI), respectively. The processing and analysis of MRI data is complex, requiring multiple steps and careful attention for each scan type. Here, we provide a selection of papers that should orient you to these processes, with emphasis on some of the available software that we use.

## Foundational papers
### T1w (sMRI)
TBD

### DWI (dMRI)
TBD

### EPI (fMRI)
1. Biswal. Functional connectivity in the motor cortex of resting human brain using echo-planar mri. [*Magnetic Resonance in Medicine*](http://doi.wiley.com/10.1002/mrm.1910340409) (1995).
1. Van Dijk. Intrinsic Functional Connectivity As a Tool For Human Connectomics: Theory, Properties, and Optimization.  [*Journal of Neurophysiology*](https://www.physiology.org/doi/10.1152/jn.00783.2009) (2010).

## Image processing
1. Fischl. FreeSurfer. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811912000389?via%3Dihub) (2012).
- FreeSurfer is a software package primarily for the processing and analysis of T1w scans.
1. Esteban *et al*. fMRIPrep: a robust preprocessing pipeline for functional MRI. [*Nature Methods*](https://www.nature.com/articles/s41592-018-0235-4) (2018).
- fMRIPrep is a software package for the processing of EPI scans.
1. Cieslak *et al*. QSIPrep: an integrative platform for preprocessing and reconstructing diffusion MRI data. [*Nature Methods*](https://www.nature.com/articles/s41592-021-01185-5) (2021).
- QSIPrep is a software package for the processing of DWI scans.

## Quality control of MRI derivatives
### T1w (sMRI)
1. Rosen *et al*. Quantitative assessment of structural image quality. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811917310832?via%3Dihub) (2018).

### DWI (dMRI)
1. Roalf *et al*. The impact of quality assurance assessment on diffusion tensor imaging outcomes in a large-scale population-based cohort. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811915009854?via%3Dihub) (2016).
1. Oldham *et al*. The efficacy of different preprocessing steps in reducing motion-related confounds in diffusion MRI connectomics. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811920307382?via%3Dihub) (2020).

### EPI (fMRI)
1. Ciric *et al*. Benchmarking of participant-level confound regression strategies for the control of motion artifact in studies of functional connectivity. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811917302288?via%3Dihub) (2017).
1. Parkes *et al*. An evaluation of the efficacy, reliability, and sensitivity of motion correction strategies for resting-state functional MRI. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811917310972?via%3Dihub) (2018).
1. Ciric *et al*. Mitigating head motion artifact in functional connectivity MRI. [*Nature Protocols*](http://www.nature.com/articles/s41596-018-0065-y) (2018).

# Network (neuro)science
## Fundamentals
The primary way that we analyze neuroimaging data is through the lense of network science. Network science casts neuroimaging data as a graph of nodes (discrete brain regions taken from sMRI) interconnected by edges (white matter pathways from dMRI *or* functional connectivity from fMRI). This graph is stored as an N×N adjacency matrix, A, wherein the N nodes are stored on the rows/columns and the N<sup>2</sup> edges are stored in the entries. We refer to this matrix as the human connectome, and this connectome gives rise to complex topology that we study using tools from network science.

### Journal articles
1. Sporns, *et al*. The Human Connectome: A Structural Description of the Human Brain. [*PLOS Comp. Bio.*](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.0010042) (2005).
1. Sporns. The human connectome: a complex network. [*Ann. N. Y. Acad.*](https://nyaspubs.onlinelibrary.wiley.com/doi/10.1111/j.1749-6632.2010.05888.x) (2011).
1. Fornito *et al*. The connectomics of brain disorders. [*Nature Reviews Neuroscience*](http://www.nature.com/articles/nrn3901) (2015).
1. Bassett & Sporns. Nature neuroscience. [*Nature Neuroscience*](http://www.nature.com/articles/nn.4502) (2017).
1. Bassett *et al*. On the nature and use of models in network neuroscience. [*Nature Reviews Neuroscience*](http://www.nature.com/articles/s41583-018-0038-8) (2018).
1. Srivastava *et al*. The expanding horizons of network neuroscience: From description to prediction and control. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811922003743?via%3Dihub) (2022).

### Books
1. Sporns. [Networks of the Brain](https://mitpress.mit.edu/9780262528986/networks-of-the-brain/) (2010).
1. Barabasi. [Network Science](https://networksciencebook.com/) (2015).
1. Fornito, Zalesky, Bullmore. [Fundamentals of Brain Network Analysis](https://www.sciencedirect.com/book/9780124079083/fundamentals-of-brain-network-analysis) (2016).

{: .note-title }
> Note
>
> We have hard copies of each of these books that you may borrow. Please contact Linden.
>

## Advanced topics

### Null models
1. Váša *et al*. Null models in network neuroscience. [*Nature Reviews Neuroscience*](https://www.nature.com/articles/s41583-022-00601-9) (2022).

### Using network science to study neural dynamics
1. Seguin *et al*. Brain network communication: concepts, models and applications. [*Nature Reviews Neuroscience*](https://www.nature.com/articles/s41583-023-00718-5) (2023).
1. Parkes *et al*. A network control theory pipeline for studying the dynamics of the structural connectome. [*Nature Protocols*](https://www.nature.com/articles/s41596-024-01023-w) (2024).

# Dynamical systems theory
In our research, dynamical systems theory (DST) is closely tied to network science; in fact, the above *using network science to study neural dynamics* advanced topic intersects with DST.

### Journal articles
1. Breakspear. Dynamic models of large-scale brain activity. [*Nature Neuroscience*](http://www.nature.com/articles/nn.4497) (2017).
1. Kim & Bassett. Linear Dynamics and Control of Brain Networks. [*arXiv*](https://arxiv.org/abs/1902.03309) (2019).
1. Kim *et al*. Shaping dynamical neural computations using spatiotemporal constraints. [*Biochemical and Biophysical Research Communications*](https://www.sciencedirect.com/science/article/pii/S0006291X24008386?via%3Dihub) (2024).

### Books
1. Strogatz. [Nonlinear Dynamics and Chaos](https://www.amazon.com/Nonlinear-Dynamics-Chaos-Steven-Strogatz/dp/0367026503/ref=pd_lpo_sccl_1/130-4187038-6765145?pd_rd_w=BthxS&content-id=amzn1.sym.4c8c52db-06f8-4e42-8e56-912796f2ea6c&pf_rd_p=4c8c52db-06f8-4e42-8e56-912796f2ea6c&pf_rd_r=HTAVNYR0TBKTNYHG0G3D&pd_rd_wg=sLZqU&pd_rd_r=1eb2087c-d39e-46f4-aad4-6d7e9770c317&pd_rd_i=0367026503&psc=1) (2024).

{: .note-title }
> Note
>
> We have hard copies of each of these books that you may borrow. Please contact Linden.
>

# Machine learning
A core focus of our research is on studying how individual differences in brain connectivity map onto behavior, cognition, and mental health symptoms. We use various machine learning techniques to address this goal. In particular, we take connectomes from thousands of subjects and use these data to train predictive models that explain variance in non-imaging phenotypes out-of-sample. This approach is sometimes called *brain-based predictive modeling*.

1. Marquand *et al*. Understanding Heterogeneity in Clinical Cohorts Using Normative Models: Beyond Case-Control Studies. [*Biological Psychiatry*](https://www.biologicalpsychiatryjournal.com/article/S0006-3223(16)00002-0/fulltext) (2016).
1. Varoquaux *et al*. Assessing and tuning brain decoders: Cross-validation, caveats, and guidelines. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S105381191630595X?via%3Dihub) (2017).
1. Poldrack *et al*. Establishment of Best Practices for Evidence for Prediction: A Review. [*JAMA Psychiatry*](https://jamanetwork.com/journals/jamapsychiatry/fullarticle/2756204) (2020).
1. He *et al*. Deep neural networks and kernel regression achieve comparable accuracies for functional connectivity prediction of behavior and demographics. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811919308675?via%3Dihub) (2020).
1. He *et al*. Meta-matching as a simple framework to translate phenotypic predictive models from big to small data. [*Nature Neuroscience*](https://www.nature.com/articles/s41593-022-01059-9) (2020).
1. Dhamala *et al*. One Size Does Not Fit All: Methodological Considerations for Brain-Based Predictive Modeling in Psychiatry. [*Biological Psychiatry*](https://www.biologicalpsychiatryjournal.com/article/S0006-3223(22)01632-8/fulltext) (2023).

{: .note-title }
> Work from our lab
>
> While not essential reading, below are some examples of our work that incoporate brain-based predictive modeling:
> 1. Parkes *et al*. Transdiagnostic dimensions of psychopathology explain individuals’ unique deviations from normative neurodevelopment in brain structure. [*Translational Psychiatry*](http://www.nature.com/articles/s41398-021-01342-6) (2021).
> 1. Parkes *et al*. Network Controllability in Transmodal Cortex Predicts Psychosis Spectrum Symptoms. [*Biological Psychiatry*](https://www.biologicalpsychiatryjournal.com/article/S0006-3223(21)01026-X/abstract) (2021).
> 1. Parkes *et al*. Asymmetric signaling across the hierarchy of cytoarchitecture within the human connectome. [*Science Advances*](https://www.science.org/doi/10.1126/sciadv.add2185) (2022).

# Open access data
We leverage multiple open access datasets to complete our research.

### ABCD
1. Casey *et al*. The Adolescent Brain Cognitive Development (ABCD) study: Imaging acquisition across 21 sites. [*Developmental Cognitive Neuroscience*](https://www.sciencedirect.com/science/article/pii/S1878929317301214?via%3Dihub) (2018).

### HBN
1. Alexander *et al*. An open resource for transdiagnostic research in pediatric mental health and learning disorders. [*Scientific Data*](http://www.nature.com/articles/sdata2017181) (2017).

### HCP
1. Van Essen *et al*. The WU-Minn Human Connectome Project: An overview. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811913005351?via%3Dihub) (2013).

### PNC
1. Satterthwaite *et al*. Neuroimaging of the Philadelphia Neurodevelopmental Cohort. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S1053811913008331?via%3Dihub) (2014).

### UKBiobank
1. Mansour *et al*. Connectomes for 40,000 UK Biobank participants: A multi-modal, multi-scale brain network resource. [*NeuroImage*](https://www.sciencedirect.com/science/article/pii/S105381192300558X?via%3Dihub) (2023).
