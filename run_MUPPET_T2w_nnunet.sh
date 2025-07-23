#!/bin/bash

# MUPPET: MedNeXt Unimodal Perivascular sPace Extractor Tool
# Version: T2w_nnunet
# Runs PVS segmentation on T2-weighted MRI images (White Matter PVS only)

# --- REQUIRED: Edit these variables to your own directories! ---
WEIGHTS_DIR="/home/zlow/by84/Brandon/mednext_muppet/MUPPET_weights/"
INPUT_DIR="/home/zlow/by84/Brandon/mednext_muppet/input_images_T2w/"
OUTPUT_DIR="/home/zlow/by84/Brandon/mednext_muppet/output_images/"

# --- Export environment variables ---
export nnUNet_raw_data_base=$WEIGHTS_DIR/nnUNet_raw_data_base
export nnUNet_preprocessed=$WEIGHTS_DIR/nnUNet_preprocessed
export RESULTS_FOLDER=$WEIGHTS_DIR/nnUNet_trained_models

# --- Run prediction ---
mednextv1_predict -i $INPUT_DIR \
    -o $OUTPUT_DIR \
    -tr nnUNetTrainerV2 \
    -ctr nnUNetTrainerV2CascadeFullRes \
    -m 3d_fullres \
    -p nnUNetData_plans_v2.1_trgSp_0.8x0.8x0.8 \
    -t Task030_nnunet_HCP_T2w
