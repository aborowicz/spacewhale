# spacewhale

SPACEWHALE is a workflow for using high-resolution satellite imagery and computer vision techniques to locate whales.

We use aerial imagery of minke whales to train a model, and then deploy that model on satellite imagery.

gen_training_patches.py takes in images and chops them into 32px x 32px tiles.

m_util.py houses functions etc. that are called by other scripts

training_tester_weighted.py trains a model using a set of aerial images that you define.

test_script.py validates the model with a test set that you define.

31cmAerialImagery.zip contains the aerial imagery

shell_scripts houses scripts used to send training and validation jobs to the SeaWulf cluster at IACS at Stony Brook U (with proper credentials)

Revision_PLOS houses the working draft of the revised manuscript for this project.

