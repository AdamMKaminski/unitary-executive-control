
%
% Purpose: extract timeseries from list of ROIs
%
% Required: - directory with .nii or .nii.gz func files
%           - directory with .nii ROI files
%           - directory for output _ts.mat files
%
% Note: func data must be 4d at the moment! 
%

%
% Set directory with .nii or .nii.gz func files
% ...such that the final path = [path task]
% ...and all func files begin with filesuf
%
path='/home/adam/Desktop/projects/unitary/pipeline_2023/data/Oliver_data/denoised_data/';
%task={'NBack','SocStroop1','SocStroop2','StopSignal'};
task={'SocStroop2','StopSignal'};
filesuf='DCNLRDOC*';

%
% Set list of ROIs
% 
ROIdir='/home/adam/Desktop/projects/unitary/pipeline_2023/data/ROIs';
roilist=dir([ROIdir '/ROI_*.nii']);
for roii=1:length(roilist)
    ROIlist{roii}=[ROIdir '/' roilist(roii).name]; %#ok<SAGROW>
end

%
% Set output directory
%
%out_dir = '/home/adam/Desktop/projects/unitary/pipeline_2023/data/Oliver_data/denoised_data/NBack/ts';

%
% Extract timeseries for all tasks for all subjects
%
for t=1:length(task)

    out_dir = ['/home/adam/Desktop/projects/unitary/' ...
        'pipeline_2023/data/Oliver_data/denoised_data/' task{t}...
        '/ts'];

    cd([path task{t} '/']);
    niis = dir(filesuf);
    for sub=1:length(niis)
        tic;
        fprintf(['Extracting timeseries from ' niis(sub).name '... ' int2str(sub) '/' int2str(length(niis)) '\n'])
        roi_ts{sub}=AK_extractTS(niis(sub).name,ROIlist,'4d');  %#ok<NASGU,SAGROW>
        fprintf(['Done with ' niis(sub).name '\n'])
        toc;
    end
    cd(out_dir);
    save([task{t} '_ts.mat'],'roi_ts'); clear roi_ts; clear gzs;
    fprintf(['Finished with task ' int2str(t) ' (' task{t} ') of ' int2str(length(task)) '\n'])
end

