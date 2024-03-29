declare -i count=0
for d in /media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/StopSignal/adam_denoised/*/; do

	sub_ID=${d:82:3}

	echo "Denoising DCNL-RDOC-${sub_ID}..."

	orig_data=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/StopSignal/orig/DCNL-RDOC-${sub_ID}/sub-DCNLRDOC${sub_ID}_task-StopSignal_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii

	echo ${orig_data}

	denoised_data=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/StopSignal/adam_denoised/DCNL-RDOC-${sub_ID}/denoised-out_0_5-noHPF/sub-DCNLRDOC${sub_ID}_task-StopSignal_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold-denoised-out_0_5-noHPF.nii

	echo ${denoised_data}

	ortvec1D=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/StopSignal/adam_denoised/DCNL-RDOC-${sub_ID}/stopsignal_confounds_ortvec.1D

	echo ${ortvec1D}

	censor1D=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/StopSignal/adam_denoised/DCNL-RDOC-${sub_ID}/stopsignal_censor_0_5mm.1D

	echo ${censor1D}

	3dTproject -polort 2 -input $orig_data -ort $ortvec1D -censor $censor1D -cenmode NTRP -prefix $denoised_data

	echo "Finished denoising DCNL-RDOC-${sub_ID}!"

	count=count+1
	echo $count

done
