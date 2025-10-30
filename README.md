# MedNet-PVS
<img width="335" height="257" alt="image-removebg-preview (1)" src="https://github.com/user-attachments/assets/c09ee3df-6be2-468a-b4ab-7e32937d1875" />

Pretrained models for automated 3D perivascular space (PVS) segmentation in **T1- and T2-weighted MRI**.
- **T2w models (MedNeXt-L-k5, nnU-Net):**
  + Trained on 200 T2w MRIs (HCP Aging)
  + Best suited for **healthy populations**
  + Segment *white matter PVS only*
- **T1w model (MedNeXt-L-k5):**
  + Trained on 40 T1w MRIs from a heterogeneous dataset (mild cognitive impairment, dementia, and healthy controls)
  + More generalizable, suited for **clinical cohorts**
  + Segments PVS in *white matter and basal ganglia*

# Installation
This project requires Conda to manage its dependencies. The following commands will set up a dedicated environment and install MedNet-PVS.
```
git clone https://github.com/iBrain-Lab/MedNet-PVS.git MedNet-PVS
cd MedNet-PVS

conda env create -f environment.yml
conda activate MedNet-PVS 

pip install -e .
```

# Inference Usage
**1. Download and set up pretrained weights:**
   + Download weights from the [Releases](https://drive.google.com/drive/folders/16aoNihCSb5QtX9Zp7VCDeEsAoKM4ge69?usp=drive_link) page or [Bridges](https://bridges.monash.edu/account/items/29588624).
   + Your directory should look like this:
```
your/chosen/path/
└── MedNet-PVS_weights
   └── nnUNet_preprocessed
   └── nnUNet_raw_data_base
   └── nnUNet_trained_models
       └── nnUNet/
           └── 3d_fullres/
               ├── Task004_3DStratifiedSplits/
               │    └── fold_0/
               │        └── debug.json
               │        └── model_final_checkpoint.model
               │        └── model_final_checkpoint.model.pkl
               │    ... (folds 1-4)
               ├── Task019_HCP_T2w/
               │    └── fold_0/
               │        └── debug.json
               │        └── model_final_checkpoint.model
               │        └── model_final_checkpoint.model.pkl
               │    ... (folds 1-4)
               └── Task030_nnunet_HCP_T2w/
                    └── fold_0/
                        └── debug.json
                        └── model_final_checkpoint.model
                        └── model_final_checkpoint.model.pkl
                    ... (folds 1-4)
```

**2. Prepare your input images:**
   + Place your T1w or T2w NIfTI images (named `*_0000.nii.gz`) into a single input folder.

**3. Choose the appropriate script:**
   + For T1w images using MedNeXt-L-k5-trained MedNet-PVS: `run_MedNet-PVS_T1w_mednext.sh`
   + For T2w images using MedNeXt-L-k5-trained MedNet-PVS: `run_MedNet-PVS_T2w_mednext.sh`
   + For T2w images using nnU-Net-trained MedNet-PVS: `run_MedNet-PVS_T2w_nnunet.sh`

**4. Open the script and edit script variables to match your setup:**
   + `WEIGHTS_DIR`: Set to the full path where you downloaded the weights, including the `MedNet-PVS_weights` folder.
   + `INPUT_DIR`: Path to your input images.
   + `OUTPUT_DIR`: Where predictions will be saved.

**5. Run the script!**

# Model Performance

| Region        | Modality | Model                          | Dice (Voxel) | Dice (Count) | Sen. (Voxel) | Sen. (Count) | Prec. (Voxel) | Prec. (Count) | Corr. (Voxel) | Corr. (Count) |
|---------------|----------|-------------------------------|:------------:|:------------:|:-------------------:|:-------------------:|:-----------------:|:-----------------:|:-------------:|:-------------:|
| Basal Ganglia | T1w      | MedNet-PVS_T1w_mednext (Internal dataset)       | 0.53 (0.11)  | 0.65 (0.16)  | 0.46 (0.14)         | 0.58 (0.18)         | 0.72 (0.12)       | 0.73 (0.13)       | 0.88          | 0.67          |
| White Matter  | T1w      | MedNet-PVS_T1w_mednext (Internal dataset)       | 0.51 (0.14)  | 0.64 (0.18)  | 0.44 (0.18)         | 0.60 (0.21)         | 0.72 (0.16)       | 0.73 (0.15)       | 0.80          | 0.76          |
|               | T2w      | MedNet-PVS_T2w_mednext (HCP-Aging)      | 0.88 (0.06)  | 0.88 (0.09)  | 0.84 (0.08)         | 0.86 (0.13)         | 0.92 (0.06)       | 0.90 (0.07)       | 0.99          | 0.88          |
|               | T2w      | MedNet-PVS_T2w_nnunet (HCP-Aging)           | 0.89 (0.06)  | 0.89 (0.09)  | 0.85 (0.08)         | 0.86 (0.13)         | 0.93 (0.05)       | 0.91 (0.07)       | 0.99          | 0.88          |



<sub>
Models were evaluated with 5-fold cross validation. All values are mean (SD). “Voxel” = per-voxel comparison; “Count” = PVS count comparison.<br>
<b>HCP-Aging</b> = test set of 200 healthy T2w MRIs.<br>
<b>Internal dataset</b> = diverse clinical/internal T1w MRIs (n=40, incl. MCI/dementia/controls).
</sub>

