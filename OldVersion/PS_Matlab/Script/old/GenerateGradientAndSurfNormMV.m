clear;
clc;
close all;
for n=6
    for Volume=1:32
        width=2^n;
        height=2^n;
        x=1:width;
        y=1:height;
        dstPath=['F:\Files\Paper\Fast 3D reconstruction algorithm based on wavelet\Sample\MVolume3\' num2str(2^n) '\' num2str(Volume)  '\'];
        if ~exist(dstPath,'dir')
            error('File not exist');
        end
        [Num PathArray NameArray] =LoadMatFiles(dstPath);
        for i=1:Num
            leftName=NaN;
            leftNamelong=NameArray(i,:);
            leftName= StrDelTail(leftNamelong);
            leftNameLen=length(leftName)-4;
            leftName=leftName(1,1:leftNameLen);
            [dstPath leftName '.mat']
            Z=load([dstPath leftName '.mat'],'Z');
            Z=Z.Z;
            X=load([dstPath leftName '.mat'],'X');
            X=X.X;
            Y=load([dstPath leftName '.mat'],'Y');
            Y=Y.Y;
            [P,Q] = Deep2Gradient(Z,1);
            save([dstPath leftName '.mat'],'P','-append');
            save([dstPath leftName '.mat'],'Q','-append');
            [PP,QQ] = Deep2Gradient(Z,0);
            save([dstPath leftName '.mat'],'PP','-append');
            save([dstPath leftName '.mat'],'QQ','-append');
            [Nx, Ny, Nz] = Deep2SurfNorm(Z);
            save([dstPath leftName '.mat'],'Nx','-append');
            save([dstPath leftName '.mat'],'Ny','-append');
            save([dstPath leftName '.mat'],'Nz','-append');
            [VolumeUp VolumeDown] = MyVolume(Z);
            save([dstPath leftName '.mat'],'VolumeUp','-append');
            save([dstPath leftName '.mat'],'VolumeDown','-append');
        end
    end
end