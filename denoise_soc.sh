declare -i count=0
for d in /media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/*/; do

        sub_ID=${d:101:3}

        echo "Denoising DCNL-RDOC-${sub_ID}..."

        orig_data_one=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/orig/DCNL-RDOC-${sub_ID}/sub-DCNLRDOC${sub_ID}_task-SocStroop1_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii
	orig_data_two=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/orig/DCNL-RDOC-${sub_ID}/sub-DCNLRDOC${sub_ID}_task-SocStroop2_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii

        echo ${orig_data_one}
	echo ${orig_data_two}

        denoised_data_one=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/DCNL-RDOC-${sub_ID}/sub-DCNLRDOC${sub_ID}_task-SocStroop1_space-MNI152NLine6Asym_desc-smoothAROMAnonaggr_bold-denoised-out_0_5-noHPF.nii
	denoised_data_two=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/DCNL-RDOC-${sub_ID}/sub-DCNLRDOC${sub_ID}_task-SocStroop2_space-MNI152NLine6Asym_desc-smoothAROMAnonaggr_bold-denoised-out_0_5-noHPF.nii

        echo ${denoised_data_one}
	echo ${denoised_data_two}

       ortvec1D_one=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/DCNL-RDOC-${sub_ID}/SocStroop1_confs.1D
       ortvec1D_two=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/DCNL-RDOC-${sub_ID}/SocStroop2_confs.1D

       echo ${ortvec1D_one}
       echo ${ortvec1D_two}

       censor1D_one=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/DCNL-RDOC-${sub_ID}/soc1_censor.1D
       censor1D_two=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/additional_denoised/DCNL-RDOC-${sub_ID}/soc2_censor.1D

        echo ${censor1D_one}
        echo ${censor1D_two}

        3dTproject -polort 2 -input $orig_data_one -ort $ortvec1D_one -censor $censor1D_one -cenmode NTRP -prefix $denoised_data_one
	3dTproject -polort 2 -input $orig_data_two -ort $ortvec1D_two -censor $censor1D_two -cenmode NTRP -prefix $denoised_data_two

        echo "Finished denoising DCNL-RDOC-${sub_ID}!"

        count=count+1
        echo $count

done

