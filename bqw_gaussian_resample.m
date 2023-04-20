

function outdata=gaussian_resmaple_Qin(data,outpath)
if nargin<2
    outdir=pwd;
    outpath=[outdir,filesep,'gauss_data.mat'];
end
if nargin<1
    fprintf('=========resample data into Gaussain distribution=========\nFormat: outdata=gaussian_resmaple(data,outpath)');
    fprintf('\nInput\n --data: input data [nSample nFeature]\n');
    fprintf(' --outpath: output filepath(*.mat)\nOutput\n --outdata: output data\n');
    fprintf('-------Written by Qin Wen at 20190828------\n');
    return;
end
msize=size(data);
GS=randn(msize(1),1);
zGS=sort(zscore(GS));
resamp_data=[];
for f =1:msize(2)
    fdata=data(:,f);
    [ofdata,ind]=sort(fdata);
    GS_fdata(ind)=zGS;
    resamp_data(:,f)=GS_fdata;%modify at 20200918
end
outdata.resamp_data=resamp_data;
outdata.gauss_ref=zGS;
save(outpath,'-struct','outdata')
end