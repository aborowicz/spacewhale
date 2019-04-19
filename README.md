# SPACEWHALE

SPACEWHALE is a workflow for using high-resolution satellite imagery and computer vision techniques to locate whales. It's a collaboration between a team at Stony Brook University (aborowicz, lmhieu612, and hlynch from lynch-lab) and a team from BioConsult and HiDef Aerial Surveying (blackbawks, G. Nehls, C. Höschle, V. Kosarev). It employs pytorch as a framework to train models how to identify whales in imagery. They train on aerial imagery and then can be used on very high-resolution satellite imagery. We used WorldView-3 and -4 imagery (31cm/px) but other sensors could be used. We provide proprietary aerial imagery (of minke whales) from HiDef down-sampled to 31cm/px and other resolutions could be made available. Similarly, aerial imagery from other providers could be used in place of what is here. 

## Getting Started

SPACEWHALE runs on the command line. 

gen_training_patches.py takes in images and chops them into 32px x 32px tiles. It takes as arguments the directory of images to tile ```--root```, the step (how many pixels before starting a new tile) ```--step```, the square tile size in pixels ```---size```, and the output directory ```--output```. For example ```python gen_training_patches.py --root './water_training' --step 16 --size 32 --output './water_tiles'``` 

m_util.py houses functions etc. that are called by other scripts

training_tester_weighted.py trains a model using a set of aerial images that you define.

test_script.py validates the model with a test set that you define.

31cmAerialImagery.zip contains the aerial imagery

shell_scripts houses scripts used to send training and validation jobs to the SeaWulf cluster at IACS at Stony Brook U (with proper credentials)

Revision_PLOS houses the working draft of the revised manuscript for this project.

