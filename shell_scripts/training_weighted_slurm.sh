#!/bin/bash
#
#SBATCH --job-name=sat_training1
#SBATCH --output=training_res.txt
#SBATCH --ntasks=28
#SBATCH --nodes=1
#SBATCH --time=04:00:00
#SBATCH -p gpu

pwd
#cd ../..
#cd projects/LynchGroup/spacewhale

# Let's train our whalefinder model!
# --name  is a new name for your model!
# --data_dir is where your images are
# !!!!: They must be in a directory named training!
# So if --data_dir training_images, then training images must contain
#        a dir called training, and inside is a whale and a water dir
# --epochs is the number of epochs you want

module load shared
module load anaconda/3
module load cuda91/toolkit/9.1

cd ../..
pwd
source activate ./space_env

cd whale
date

python training_tester_weighted.py --name alexnet_0009 --data_dir tiled_air32/fold_1  --epochs 24
date
