#!/bin/bash

# MedNet-PVS
# Version: T2w_mednext
# Runs PVS segmentation on T2-weighted MRI images (White Matter PVS only)

# --- REQUIRED: Edit these variables to your own directories! ---
WEIGHTS_DIR="/home/zlow/by84/Brandon/MedNet-PVS/MUPPET_weights/"
INPUT_DIR="/home/zlow/by84/Brandon/MedNet-PVS/input_images_T2w/"
OUTPUT_DIR="/home/zlow/by84/Brandon/MedNet-PVS/output_images/"

# --- Export environment variables ---
export nnUNet_raw_data_base=$WEIGHTS_DIR/nnUNet_raw_data_base
export nnUNet_preprocessed=$WEIGHTS_DIR/nnUNet_preprocessed
export RESULTS_FOLDER=$WEIGHTS_DIR/nnUNet_trained_models

# --- Run prediction ---
mednextv1_predict -i $INPUT_DIR \
    -o $OUTPUT_DIR \
    -tr nnUNetTrainerV2_MedNeXt_L_kernel5_lr_3e_4_500epochs \
    -ctr nnUNetTrainerV2CascadeFullRes \
    -m 3d_fullres \
    -p nnUNetPlansv2.1_trgSp_0.8x0.8x0.8 \
    -t Task019_HCP_T2w
