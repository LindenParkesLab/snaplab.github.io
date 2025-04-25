---
layout: default
title: Nodes and storage
parent: Amarel
has_toc: true
---

# Nodes and storage
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

All data and projects are to be stored on Amarel. There are three key terms to understand
1. `p_dz268_1`. This is the *node partition* shared across all members of CAHBIR. Note, the `p_` denotes that this permission group grants access to the a set of **compute nodes** on Amarel reserved exclusively for CAHBIR members. Please contact Linden to be added to this permission group. The original owner of this partition is David Zald, hence the `dz268`.
2. `f_lp756_1`. This is the primary *storage partition* for the SNaP Lab. Note, the `f_` denotes that this permissions group grants access to **storage space**. This permission group consists of 50TB of storage with a 5 million file count limit. All projects led by members of the SNaP Lab should be stored here in a lab member's own subfolder: `/projectsp/f_lp756_1/[yourname]/[projectname]`
3. `f_ah1491_1`. This *storage partition* is owned and operated by the Holmes lab. Avram and Linden share this partition to centralize all storage of open access data. This permission group consists of two separate partitions comprising 50TB each:
- `/projectsp/f_ah1491_1/`. This partition has a 5 million file count limit and is reserved for members of the Holmes lab to store their projects. In general, members of the SNaP Lab should avoid using this partition.
- `/scratch/f_ah1491_1/`. This partition has a much larger 50 million file count limit. This is where we store open access datasets shared between the labs. In general, people should avoid using this partition for their own project-specific needs.

You can always check the status of the above storage partitions using the following commands:

```bash
mmlsquota -j f_lp756_1 --block-size=auto projectsp
mmlsquota -j f_ah1491_1 --block-size=auto projectsp
mmlsquota -j f_ah1491_1 --block-size=auto scratch
```
