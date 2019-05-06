#!/bin/bash
#
#SBATCH --job-name=modelo_testing_job
#SBATCH --output=densenet_full224_testlr001.txt
#SBATCH --ntasks=28
#SBATCH --nodes=1
#SBATCH --time=04:00:00
#SBATCH -p gpu


module load shared
#module load torque
module load anaconda/3
module load cuda91/toolkit/9.1

pwd
date
cd ../../..
#cd projects/LynchGroup/spacewhale


# Let's test a trained model!
# This script just iteratively calls test_script.py with for each epoch.
# It will be a pain to adapt, and I should write it differently.

source activate ./space_env

cd ./git_spacewhale/spacewhale

for i in {0..23}
do
     python test_script.py --data_dir ../../whale/new_pansharp/test --modtype densenet --model densenet_full224_lr001 --epoch $i
done

date
