---
layout: default
title: Software
parent: Amarel
has_toc: true
---

# Software on Amarel
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

# fmriprep

[fmriprep](https://fmriprep.org/en/stable/index.html) is a popular tool for pre-processing fMRI data. The authors of fmriprep recommend using it via a [Docker](https://www.docker.com/) or [Singularity](https://docs.sylabs.io/guides/3.5/user-guide/introduction.html) container. We agree with this recommendation. Amarel does not have Docker (many HPCs don't!), but it does have Singularity. Let's walkthrough how to use fmriprep on Amarel via Singularity.

## Setup Singularity:fmriprep

Start by loading an interactive session on Amarel, like so:

```shell
srun --partition=p_dz268_1 --ntasks=4 --mem=64000 --time=01:00:00 --pty bash
```

{: .note-title }
> Important
>
> Do not setup Singularity:fmriprep on a login node!

Next, create a directory to store your Singularity images:

```shell
mkdir -p ${HOME}/singularity_images
```

Finally, load Amarel's Singularity module and build an fmriprep image:

```shell
module load singularity
singularity build ${HOME}/singularity_images/fmriprep-<version>.simg docker://nipreps/fmriprep:<version>
```

Replacing `<version>` with the version of fmriprep you want to use (see [here](https://fmriprep.org/en/stable/changes.html)). At the time of writing this tutorial, the latest version is 24.1.0:

```shell
module load singularity
singularity build ${HOME}/singularity_images/fmriprep-24.1.0.simg docker://nipreps/fmriprep:24.1.0
```

Note, setup will take a minute!

## Run fmriprep

Once setup is complete, you will have a Singularity image in your home directory that you can use to run fmriprep. You can run it like so:

```shell
module load singularity
BIDS_DIR=/path/to/bids/raw/data
OUT_DIR=/path/to/derivatives
FREESURFER_HOME=path/to/freesurfer/install
SUBJECT_ID=sub-001

singularity run --cleanenv ${HOME}/singularity_images/fmriprep-24.1.0.simg \
    ${BIDS_DIR} ${OUT_DIR} participant \
    --participant-label ${SUBJECT_ID} \
    --fs-license-file ${FREESURFER_HOME}/license.txt\
```

See [here](https://fmriprep.org/en/stable/usage.html) and [here](https://www.nipreps.org/apps/singularity/) for more usage tips.

# xcp-d

[xcp-d](https://xcp-d.readthedocs.io/en/latest/index.html) is a post-processing tool that takes the outputs of fmriprep and extracts parcellated time series for functional connectivity mapping, alongside other regional features. xcp-d is managed by Ted Satterthwaite's team at the UPenn Lifespan Informatics & Neuroimaging Center ([PennLINC](https://www.pennlinc.io/)). Like fmriprep, it is recommended to run xcp-d using a container. Again, you can do this on Amarel using Singularity.

## Setup Singularity:xcpd

Start by loading an interactive session on Amarel, like so:

```shell
srun --partition=p_dz268_1 --ntasks=4 --mem=64000 --time=01:00:00 --pty bash
```

{: .note-title }
> Important
>
> Do not setup Singularity:xcpd on a login node!

Next, load Amarel's Singularity module and build an xcpd image:

```shell
module load singularity
singularity build ${HOME}/singularity_images/xcp_d-<version>.simg docker://pennlinc/xcp_d:<version>
```

Replacing `<version>` with the version of xcp-d you want to use (see [here](https://xcp-d.readthedocs.io/en/latest/changes.html)). At the time of writing this tutorial, the latest version is 0.9.1:

```shell
module load singularity
singularity build ${HOME}/singularity_images/xcp_d-0.9.1.simg docker://pennlinc/xcp_d:0.9.1
```

Note, setup will take a minute!

## Run xcp-d

Once setup is complete, you will have a Singularity image in your home directory that you can use to run xcp-d. Assuming you have already run fmriprep beforehand, you can run xcp-d like so:

```shell
module load singularity
FMRIPREP_DIR=/path/to/derivatives/fmriprep
XCPD_DIR=/path/to/derivatives/xcpd
FREESURFER_HOME=path/to/freesurfer/install
SUBJECT_ID=001

singularity run --cleanenv ${HOME}/singularity_images/xcp_d-0.9.1.simg \
${FMRIPREP_DIR} ${XCPD_DIR} participant \
--mode linc -w ${XCPD_DIR}/work --input-type fmriprep --nuisance-regressors 36P --task_id rest \
--participant-label ${SUBJECT_ID} \
--fs-license-file ${FREESURFER_HOME}/license.txt \
--file-format nifti --nthreads 2 --low-mem --mem-gb 16
```

Note, the above call will only process the resting-state fMRI data.
