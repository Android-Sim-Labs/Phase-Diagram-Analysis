function spc=asc2dat(filnm,B0,filnm2)
%%  This function converts data in .asc to a format, which is appropriate
%% for nlsl program to read in. The converted data is put into a .dat file.
%%  The central peak is shifted to B0.
%% 
%==> out_spc=asc2dat('filname',B0,'filname2')  (NO extension)
%% 1. filname is used for output file if filname2 is not assigned.
%% 2. If <out_spc> is assigned, filnam2 will NOT be produced.
%%
%%  filname:    name of .asc file
%%  filname2:   name for .dat file
%%  B0=3326 for 9.5GH
%%%
%% EXAMPLE:
%%      asc2dat('test',3326);
%%  With the test.asc file has been existed in your current folder, above
%%  command will create a test.dat file, which is in an appropriate format
%%  for nlsl to read in.
%%
%% by YWC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ((nargin < 2)|(nargin > 3) )
    error('invalid input');
end
    
sub_namea='.asc';sub_nameb='.dat';
if (nargin==2)
    filnm2=filnm;
end
filnmf=[filnm,num2str(sub_namea)];
filnmo=[filnm2,num2str(sub_nameb)];
fid=fopen(filnmf);
spc = fscanf(fid,'%g',[2 inf]); % It has two rows now.
spc = spc';
fclose(fid);
[m,n]=size(spc);
max_mag=400; % has been used for years. I don't know why?
spc(:,2)=spc(:,2)/max(spc(:,2))*max_mag;
%
[c1,i1]=max(spc(:,2));
spc(:,1)=spc(:,1)-(spc(i1,1)-B0);
%
%plot(spc(:,1),spc(:,2));
%set(gca, 'ytick',[]);
%box off;
%xlabel('Magnetic Field (Gauss)');
%title(filnm);
%fid = fopen('Z:\private\Matlabwork\NEWSPC.dat','w');
if (nargout==0)
    fid=fopen(filnmo,'w');
    for i=1:1:m
        y=[spc(i,1); spc(i,2)];
        fprintf(fid,'%8.3f %10.5f\n',y);
    end
    fclose(fid);
end