# SPACEWHALE

SPACEWHALE is a workflow for using high-resolution satellite imagery and computer vision techniques to locate whales. It's a collaboration between a team at Stony Brook University (aborowicz, lmhieu612, and hlynch from lynch-lab) and a team from BioConsult and HiDef Aerial Surveying (blackbawks, G. Nehls, C. Höschle, V. Kosarev). It employs pytorch as a framework to train models how to identify whales in imagery. They train on aerial imagery and then can be used on very high-resolution satellite imagery. We used WorldView-3 and -4 imagery (31cm/px) but other sensors could be used. We provide proprietary aerial imagery (of minke whales) from HiDef down-sampled to 31cm/px and other resolutions could be made available. Similarly, aerial imagery from other providers could be used in place of what is here. 

## Getting Started

SPACEWHALE runs on the command line. 

```31cmAerialImagery.zip``` contains the aerial imagery

'''gen_training_patches.py''' takes in images and chops them into 32px x 32px tiles. It takes as arguments the directory of images to tile ```--root```, the step (how many pixels before starting a new tile) ```--step```, the square tile size in pixels ```---size```, and the output directory ```--output```. For example 
```python gen_training_patches.py --root './water_training' --step 16 --size 32 --output './water_tiles'``` 

```m_util.py``` houses functions etc. that are called by other scripts

```training_tester_weighted.py``` trains a model using a set of aerial images that you define. Example:
``` python training_tester_weighted.py --name model_1 --data_dir './the_data' --lr 0.001 --verbose True --epochs 24```
```name``` is what you want to call the model you're about to train
```data_dir``` is the directory with your training data in it. In this case your training data need to be in a dir called *train* and you should point to the dir above it. Inside *train* you need a dir with each of your classes (e.g. *whale* and *water*)
```verbose``` asks whether you want info printed out in the terminal
```lr``` is the learning rate
```model``` is the model type: ResNet-18, 34, or 152 and DenseNet. See model.py for details.
```epochs``` asks for how many epochs you'd like the model to train

```test_script.py``` validates the model with a test set that you define and kicks out some output such as the precision and recall at each epoch. It also writes out 3 CSVs with the filename, label, and prediction for each image in a separate CSV. Example:
```python test_script.py --data_dir './test_dir' --model model_1 --epochs 24```
```data_dir``` should include two dirs labeled with your classes (exactly as they were for training, e.g. *water* and *whale* in our case). 
```model``` is the trained model that you'll use to test with
```modtype``` is the model type as in the training script
```epochs``` refers to the epoch (model weights) you want to use to test with. If you want to test with all of them, you can run test_script in a loop over all the epochs you have.

The ```shell_scripts``` dir houses scripts used to send training and validation jobs to the SeaWulf cluster at IACS at Stony Brook U (with proper credentials) for Slurm and Torq
The ```Revision_PLOS``` dir houses the working draft of the revised manuscript for this project.

```SPACEWHALE_confusionMatrix.R``` is an R script for building a confusion matrix in ggplot2.

The ```Revision_PLOS``` dir houses the working draft of the revised manuscript for this project.

```SPACEWHALE_confusionMatrix.R``` is an R script for building a confusion matrix in ggplot2.

## Pre-trained Models Used for Training:

Both ```DenseNet161``` and ```ResNet18``` can be downloaded via torchvision ModelZoo at :

https://pytorch.org/docs/stable/torchvision/models.html

A ResNeXt101 model pre-trained on ImageNet can be downdloaded at:

https://drive.google.com/open?id=1EDUcaGNiakWO9Xvk9kWgkkcnTYZ6VQoT

Please download this pre-trained ResNeXt101 model to the ```RESNEXT''' folder.
