function HAdata=harmonization_ROI(data,batch,covariates,method)
fprintf('--------HAdata=harmonize multi-batches(centers) ROI data based on Combat---------\n');
fprintf('Format: HAdata=harmonization_ROI(data,batch,covariates,method)\n');
fprintf('--data:\tdata need harmonization (mandatory),canbe mat variable, or csv,xls or text file\n');
fprintf('--batch:\tbatch (center) effects that need be removed(mandatory),vector or text file[Ndatas]\n');
fprintf('--covariates:\tcovariates of Biological information that need preserved (optional),matrix or text file[Ncovariates,Nsample]\n');
fprintf('--method;\tharmonization method (optional),''parametric''(default) or ''non-parametric''\n');
fprintf('-------Written by QinWen 20200707--------\n');
fprintf('This script depend on ''ComBatHarmonization''(by  Jfortin1) at github:\nhttps://github.com/Jfortin1/ComBatHarmonization/tree/master/Matlab\n');
if nargin<1
    data=spm_select(1,'any','Select a text(csv,xls,mat) data file needs harmonization:');
end
if nargin<2
    batch=spm_select(1,'any','Select a text(mat) file defining the batch (center) effect:');
end
if nargin<3
    covariates=spm_select(1,'any','Select a text(mat) file defining the Boilogical covariates:');
end
if nargin<4
    method='parametric';
end
%check data
if ischar(data)
    if exist(data,'file')
        data_is_file=1;
        [outdir,filename,ext]=fileparts(data);
        switch ext
            case '.txt'
                data=load(data);
            case '.csv'
                data=csvread(data);
            case '.xls'
                data=xlsread(data);
            case '.xlsx'
                data=xlsread(data);
            otherwise
                data=load(data);
        end
    else
        error('no exist data file %n',data);
    end
end

%check batch
if exist(batch,'file')
    batch=load(batch);
    if isstruct(batch)
        batch=struct2array(batch);
    end
elseif exist(batch,'1')
    batch=batch;
else
    error('Bad format of batch \n');
end
%check covariates
if exist(covariates,'file')
    covariates=load(covariates);
    if isstruct(covariates)
        covariates=struct2array(covariates);
    end
end
if isempty(covariates)
covariates=[];
end

% maincode
HAdata=harmonization_run(data,batch,covariates,'',method);
if ~data_is_file
    outpath=[pwd,filesep,'harmonized_data.mat'];
else
outpath=[outdir,filesep,'Ha_',filename,'.mat'];
end
    save(outpath,'HAdata','batch','covariates');
