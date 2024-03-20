function ts=AK_extractTS(niifiles, ROIlist, dim) 

% if isempty(which('maroi'))
%     addpath('/nas/data/app/spm12/toolbox/marsbar')
%     addpath /nas/data/app/spm12/toolbox/marsbar/spm5; 
% end

imgindex=1;

samplescan = niifiles(1,:);
imagesample = niftiinfo(samplescan);

%
% If ROI dimension doesn't match the spm input file, then match the dimension
%
for roii=1:length(ROIlist)
    
    anatomicalmaskname=ROIlist{roii};
    roihdr = niftiinfo(anatomicalmaskname);
    
    if ~isequal(imagesample.ImageSize(1:3),roihdr.ImageSize)
        o = maroi_image(struct('vol', spm_vol(anatomicalmaskname), 'binarize',1,'func', ''));
        sp = mars_space([SPMfolder '/con_0001.nii']);
        anatomicalmaskname=[ anatomicalmaskname(1:end-4) '_sp.nii'];
   
        save_as_image(o, anatomicalmaskname, sp);
    end
    
    roi3d = niftiread(anatomicalmaskname);
    ROImat(:,roii)=reshape(roi3d,imagesample.ImageSize(1)*imagesample.ImageSize(2)*imagesample.ImageSize(3),1); %#ok<AGROW>
    
end

%
% Extract timeseries data for each TR (i.e., scan)
%
% If data is 3d:
if strcmp(dim,'3d')

    %fprintf('Extracting timeseries from 3d data... \n')
    
    for TR = 1:length(niifiles(:,1))
        
        fullscanname = niifiles(TR,:);
        samplescan=niftiread(fullscanname);
        
        %fprintf(['Extracting timeseries from ' fullscanname '... TR ' int2str(TR) '/' int2str(length(niifiles(:,1))) '\n'])
        tsi=reshape(samplescan,1,imagesample.ImageSize(1)*imagesample.ImageSize(2)*imagesample.ImageSize(3));
        ts(imgindex,:)=  double(tsi)*double(ROImat); %#ok<AGROW>
        imgindex=imgindex+1;
    end
% If data is 4d:
elseif strcmp(dim,'4d')
    
    %fprintf('Extracting timeseries from 4d data... \n')
    
    fullscanname = niifiles(1,:);
    samplescan=niftiread(fullscanname);
    samplescansize=size(samplescan);
    
    for TR=1:samplescansize(4)
        %fprintf(['Extracting timeseries from ' fullscanname '... TR ' int2str(TR) '/' int2str(samplescansize(4)) '\n'])
        tsi=reshape(samplescan(:,:,:,TR),1,imagesample.ImageSize(1)*imagesample.ImageSize(2)*imagesample.ImageSize(3));
        ts(imgindex,:)=  double(tsi)*double(ROImat); %#ok<AGROW>
        imgindex=imgindex+1;
    end
    
else
    fprintf('ERROR: Dimension (3rd argument) must be "3d" or "4d" \n')
end