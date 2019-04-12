#PBS -l walltime=08:00:00

#PBS -N training_images_job

#PBS -q gpu

module load shared
module load torque/6.0.2
module load anaconda/3

cd ../..
cd projects/LynchGroup/spacewhale

# Let's train our whalefinder model!
# --name  is a new name for your model!
# --data_dir is where your images are
# !!!!: They must be in a directory named training!
# So if --data_dir training_images, then training images must contain
#        a dir called training, and inside is a whale and a water dir
# --epochs is the number of epochs you want

source activate ./space_env

cd whale

python training_tester_weighted2.py --name full_32_001_s12 --data_dir tiled_air32/full_air  --epochs 32

