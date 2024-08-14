#!/bin/bash
# first, choose partition (note the space between # and SBATCH!)
#SBATCH --partition=main
# SBATCH --partition=p_dz268_1
# SBATCH --partition=gpu

# If partition=gpu, then you need to specify how many GPUs you want and what type. 
# Here, gres=gpu:1 means "give me 1 gpu of any type". 
# Note, this will throw an error if partition=main.
# SBATCH --gres=gpu:1

# then, set the rest of params
#SBATCH --job-name=my_array         # Assign a short name to your job
#SBATCH --requeue                   # Return job to the queue if preempted
#SBATCH --cpus-per-task=1           # Cores per task (>1 if multithread tasks)
#SBATCH --nodes=1                   # Number of nodes you require
#SBATCH --ntasks=1                  # Total # of tasks across all nodes
#SBATCH --mem=4000                  # Real memory (RAM) required (MB)
#SBATCH --time=6:00:00              # Total run time limit (D-HH:MM:SS)
#SBATCH --output=slurm_%A_%a.out    # STDOUT output file
#SBATCH --array=0-499               # Set your array job iterator. Note that 0-499 is the MAX is for the main partition and 0-249 is the MAX for the gpu partition

# Print the task id.
echo "SLURM_ARRAY_TASK_ID:" ${SLURM_ARRAY_TASK_ID}

# sleep the job for some time
sleep $((SLURM_ARRAY_TASK_ID))  
# This is optional. I use this to stagger the start time of each array job. This is helpful if your code has high i/o demands.
# In high i/o cases, running 500 versions of your code at one time might bog down the cluster. Staggering start time will reduce this burden

####################################################################################################
# run some code
scriptsdir='/path/to/my/python/scripts'

python ${scriptsdir}/my_python_script.py --option_a 'foo' --option_b 123 --option_c ${SLURM_ARRAY_TASK_ID}
####################################################################################################
