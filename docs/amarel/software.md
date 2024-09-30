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

fmriprep is a popular tool for processing fMRI data. You can read about it [here](https://fmriprep.org/en/stable/index.html). The authors of fmriprep recommend using it via a [Docker](https://www.docker.com/) or [Singularity](https://docs.sylabs.io/guides/3.5/user-guide/introduction.html) container. We agree with this recommendation. Amarel does not have Docker (many HPCs don't!), but it does have Singularity. Let's walkthrough how to use fmriprep on Amarel via Singularity.

## Setup Singularity:fmriprep

Start by loading an interactive session on Amarel, like so:

```shell
srun --partition=p_dz268_1 --ntask=4 --mem=12000 --time=01:00:00 --pty bash
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