#!/bin/bash
#
#SBATCH --job-name=modelo_testing_job
#SBATCH --output=res1.txt
#SBATCH --ntasks=28
#SBATCH --nodes=1
#SBATCH --time=04:00:00
#SBATCH -p gpu


module load shared
module load torque
module load anaconda/3
module load cuda91/toolkit/9.1

cd ../..
#cd projects/LynchGroup/spacewhale



# Let's test a trained model!
# This script just iteratively calls test_script.py with for each epoch.
# It will be a pain to adapt, and I should write it differently.

source activate ./space_env

cd whale

for i in {0..1}
do
     python test_script.py --data_dir tiled_air32/fold_4/test_4/ --model f4_32_001 --epoch $i
done

