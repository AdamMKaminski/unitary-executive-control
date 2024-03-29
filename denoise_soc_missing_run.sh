for d in /media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/orig/*/; do

	FILE1_in=${d}sub-DCNLRDOC${d:72:3}_task-SocStroop1_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii
	FILE1_out=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/DCNL-RDOC-${d:72:3}/denoised-out_0_5-noHPF/sub-DCNLRDOC${d:72:3}_task-SocStroop1_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold-denoised-out_0_5-noHPF.nii
	echo "Doing $FILE1_in ..."
	if test -f "$FILE1_in"; then
		subdir=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/DCNL-RDOC-${d:72:3}
		3dTproject -polort 2 -input $FILE1_in -ort $subdir/soc1_confounds_ortvec.1D -censor $subdir/soc1_censor_0_5mm.1D -cenmode NTRP -prefix $FILE1_out
	fi

        FILE2_in=${d}sub-DCNLRDOC${d:72:3}_task-SocStroop2_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii
        FILE2_out=/media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/DCNL-RDOC-${d:72:3}/denoised-out_0_5-noHPF/sub-DCNLRDOC${d:72:3}_task-SocStroop2_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold-denoised-out_0_5-noHPF.nii
        echo "Doing $FILE2_in ..."
        if test -f "$FILE2_in"; then
                subdir = /media/jm3080/Naider/RDOC/fx/new_fMRIprep/data/SocStroop/adam_denoised/DCNL-RDOC-${d:72:3}/
                3dTproject -polort 2 -input $FILE2_in -ort $subdir/soc1_confounds_ortvec.1D -censor $subdir/soc1_censor_0_5mm.1D -cenmode NTRP -prefix $FILE2_out
        fi
done
