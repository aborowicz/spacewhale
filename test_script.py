#######################################################################################################
#### Script for testing a pytorch, convolutional neural net, using the pre-trained resnet18 model  ####
#### Authors:  Hieu Le & Grant Humphries
#### Date: August 2018
#### This script was written for the Spacewhale project 
#### This script was written based on the Pytorch transfer learning tutorial: https://pytorch.org/tutorials/beginner/transfer_learning_tutorial.html 
#######################################################################################################
#### Usage examples (Linux)
####
####  $python testing_script.py --data_dir /home/ghumphries/spacewhale/test --modtype densenet --model MODEL1 --epoch 24
####
#######################################################################################################
#### Setup information
####    To run this script, ensure that you have folders named exactly the same as those in the training data folder
####    For example: 
####    ./test/Water 
####    ./test/Whale
####    IMPORTANT:
####        The images that you want to test should all live in the target folder. For example, if you only want to test for
####        water, then place all the images in the ./test/Water folder. If you want to test for whales, place all the images in 
####        the ./test/Whale folder
####        The data_dir argument should point to the directory ABOVE the training folders.
####        For example, if your directory is:  /home/user/spacewhale/testingdata/Water
####        then --data_dir /home/user/spacewhale/testingdata
#######################################################################################################
### Library imports

from __future__ import print_function, division

from PIL import Image
from PIL import ImageFilter
import torch
import torch.nn as nn
import torch.optim as optim
from torch.optim import lr_scheduler
import numpy as np
import torchvision
from torchvision import datasets, models, transforms
from m_util2 import *
import matplotlib.pyplot as plt
import time
import os
import copy
import argparse
from model import define_model
from collections import OrderedDict

parse = argparse.ArgumentParser()
parse.add_argument('--data_dir')
parse.add_argument('--model')
parse.add_argument('--modtype', type=str)
parse.add_argument('--epoch',type=int,default=24)
opt = parse.parse_args()
s = spacewhale(opt)

epoch_to_use = 'epoch_'+str(opt.epoch)+'.pth' #Added this
trained_model = os.path.join('./trained_model',opt.model,epoch_to_use)#Added here

#trained_model = os.path.join('./trained_model',opt.model,'epoch_24.pth')
data_dir = opt.data_dir  
print(data_dir)
#epoch_to_use = 'epoch_'+str(opt.epoch)+'.pth' 

#trained_model = '/home/ghumphries/Projects/whale/trained_model/MODEL_NO_W1/'+epoch_to_use
#data_dir = '/home/ghumphries/Projects/whale/Data/fulldata/test/single_whale'




test_transforms = s.data_transforms['test']
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
dev = ("gpu" if torch.cuda.is_available() else "cpu")
print('Data loaded into', dev)

torch.set_default_tensor_type('torch.cuda.FloatTensor')

#model_ft = torchvision.models.resnet18(pretrained=True)
model_ft = define_model(name = opt.modtype)

## Scrubbed these because they're in model.py now
#num_ftrs = model_ft.fc.in_features
#model_ft.fc = nn.Linear(num_ftrs, 2)

model_ft = model_ft.to(device)
print(os.getcwd())
if opt.modtype == 'resneXt':
    state_dict=torch.load(trained_model)
    temp_state_dict=OrderedDict()
    for k,v in state_dict.items():
        name = k[4:] # remove `net.`
        temp_state_dict[name] = v
    model_ft.load_state_dict(temp_state_dict)
else:
    model_ft.load_state_dict(torch.load(trained_model))
model_ft.eval()


#image_dataset = datasets.ImageFolder(data_dir, s.data_transforms['test'])
image_datasets = ImageFolderWithPaths(data_dir, s.data_transforms['test'])
#image_datasets = datasets.ImageFolder(data_dir, s.data_transforms['test'])
dataloaders = torch.utils.data.DataLoader(image_datasets, batch_size=9,shuffle=True, num_workers=4,drop_last = True)
print(dataloaders)

class_names = image_datasets.classes
keylist = [x for x in range(len(class_names))]
d = {key: value for (key, value) in zip(keylist,class_names)}

print(epoch_to_use)
print(d)


#data_dir = '/home/ghumphries/Projects/whale/Data/fulldata/test/single_whale/Water'
#fils = os.listdir(data_dir)
#for f in fils:
#    print(f)
#    im = os.path.join(data_dir,f)
#    s.test_im(device,model_ft,class_names,test_transforms,im)


s.test_dir(device,model_ft,dataloaders)

#im = 'whale.png'
#s.test_im(model_ft,class_names,test_transforms,im)
#im = 'water.png'
#s.test_im(device,model_ft,class_names,test_transforms,im)


