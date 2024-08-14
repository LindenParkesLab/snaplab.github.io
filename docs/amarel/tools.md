---
layout: default
title: Tools
parent: Amarel
has_toc: true
---

# Updating the Docs
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
This page includes simple tools you can setup on your Amarel account

# Editing your `.bashrc`

Many of the tools outlined below require you to modify your `.bashrc` on Amarel. If you aren't familiar, your `.bashrc` (as well as your `.bash_profile`) is basically just a short text file that issues a set of commands to the system every time you open a terminal (or in the case of `.bash_profile`, every time you log in). To edit your `.bashrc`, open it like so:

```bash
$ nano ~/.bashrc
```

This will open the file in your terminal and allow you edit to it. You should see something like this:

<img src="/assets/images/nano_bashrc.png" alt="" width="750">

Once you've edited your `.bashrc`, press CTRL-X, and then the Y key, and then ENTER (one at a time, not all together). This will save and close the file. Now, the next time you open a terminal on Amarel, the new lines of code will run automatically in the background, enabling new functionality.

# Slurm scheduler

Amarel uses the popular Slurm Workload Manager. Slurm has it's own excellent documentation, which you can find [here](https://slurm.schedmd.com/documentation.html). Here, we include a template shell script that will allow you to submit jobs to Amarel using Slurm.

Template Slurm script: [submit_array_jobs.sh](/assets/scripts/submit_array_jobs.sh)

There are a few things to pay attention to in this script. First is the Slurm header, which comprises all the lines at the top that start with `#SBATCH`. Each of these lines stores information that the Slurm scheduler uses to determine the settings for your job (e.g., how many CPU cores to use, how much time to run the job for etc.)

{: .note-title }
> Important
>
> If there is a *space* after the `#` (e.g., `# SBATCH`), then that specific line of the header is **not active** (i.e., it is just a bog standard code comment). If there is *no space* (e.g., `#SBATCH`), then the line is **active** and will be read appropriately by the Slurm scheduler.

## Choose your partition

The first thing to consider is which Amarel partition you want to submit your jobs to. In the script, there are three options that you can toggle by adding/removing spaces in the Slurm header:

```shell
# first, choose partition (note the space between # and SBATCH!)
#SBATCH --partition=main
# SBATCH --partition=p_dz268_1
# SBATCH --partition=gpu

# If partition=gpu, then you need to specify how many GPUs you want and what type.
# Here, gres=gpu:1 means "give me 1 gpu of any type". 
# Note, this will throw an error if partition=main.
# SBATCH --gres=gpu:1
```

If you use `partition=main`, your job will be submitted to the main Amarel pool, which is a pool shared by all of Rutgers. It is a very large pool but we do not have exclusive access to it. If you use `partition=p_dz268_1`, your job will be submitted to the CAHBIR pool. This pool only has 640 cores (main has many more than this), but only members of CAHBIR have access to this pool, so there is less competition. Finally, if you use `partition=gpu`, your job will be submitted a pool of nodes that have gpu support. Like main, this pool is shared with all of Rutgers; but in our experience it doesn't get used much! Amarel is really well equipped with gpus, so this pool can be powerful if your jobs require CUDA acceleration.

{: .note-title }
> Important
>
> If you're having trouble submitting to `partition=p_dz268_1`, that means you haven't been added to the CAHBIR pool yet! Let Linden know and he will fix that.

## Array jobs

After choosing your partition, the rest of the Slurm header has a bunch of settings to consider. They're reasonably self explanatory, but consult the [Slurm](https://slurm.schedmd.com/documentation.html) and [Amarel](https://sites.google.com/view/cluster-user-guide) guides if you need more info. One additional setting we explain here is the **array job iterator**, which is active by default in our template script.

Array jobs are a very useful HPC feature that allows you to spawn multiple jobs from a single job submission. If you submit `submit_array_jobs.sh` to Amarel in its current configuration, it will duplicate and run itself 500 times, creating 500 separate jobs on Amarel in the process. The only thing that will vary across those duplicates is an integer value stored in the variable `SLURM_ARRAY_TASK_ID`; it will be set to 0 for the first job, 1 for the second, 2 for the third, etc. This is a consequence of the following line in the Slurm header:

```shell
#SBATCH --array=0-499
```

This simple feature is very powerful, because it allows you to efficiently run a single script multiple times in parallel while leveraging the `SLURM_ARRAY_TASK_ID` to do different things. For example, say you have a script that processes neuroimaging data for a single subject, you can leverage array jobs to process 500 subjects at once by using `SLURM_ARRAY_TASK_ID` to read in different subjects from a list or a data structure.

Unfortunately, array jobs are capped on Amarel. You can run 500 jobs at once on the main partition and 250 jobs at once on the gpu partition. But, we can code our way around this! The simplest solution is to just do serial processing inside your `submit_array_jobs.sh` script. You'll still only get 500 (250) jobs running at once, but each job will now run through multiple `SLURM_ARRAY_TASK_ID` values. This would like something like this:

```shell
for i in {0..1500..500}; do
    NEW_SLURM_ARRAY_TASK_ID=$((${SLURM_ARRAY_TASK_ID} + ${i}))
    echo "NEW_SLURM_ARRAY_TASK_ID:" ${NEW_SLURM_ARRAY_TASK_ID}
    python ${scriptsdir}/my_python_script.py --option_a 'foo' --option_b 123 --option_c ${SLURM_ARRAY_TASK_ID}
done
```

Now, `NEW_SLURM_ARRAY_TASK_ID` will loop through [0, 500, 1000, 1500] in the first job and [1, 501, 1001, 1501] in the second job, etc. This will result in your 500 array jobs performing 2000 jobs worth of processing (when `SLURM_ARRAY_TASK_ID=499`, `NEW_SLURM_ARRAY_TASK_ID` will loop through [499, 999, 1499, 1999]). They will also each take 4 times longer.

If you don't need an array job, just add a space after the `#` to the corresponding header line, and `SLURM_ARRAY_TASK_ID` will never be generated (and Amarel will only one job).

# Slurm tricks

Below, you'll find some simple tools that we use every day.

## `myq`

Add the following to your `.bashrc`:

```bash
#--------------------------------------------------
# squeue alias
alias myq='squeue --me -r'
#--------------------------------------------------
```

Now, if you ever want to quickly check the status of jobs, just type:

```bash
$ myq
```

## `qcount`

Just need a count of running and pending jobs? Add the following `qcount` function to your `.bashrc`:

```bash
#--------------------------------------------------
# qcount
qcount () {
counts="$(squeue --me -h -r -o '%T' | uniq -c)"
total=$(echo "$counts" | awk '{sum+=$1;}END{print sum};')
echo "$counts"
echo "      ----------"
echo "      $total TOTAL"
}

qcounttot () {
qcount | tail -1 | awk '{print $1}'
}
#--------------------------------------------------
```