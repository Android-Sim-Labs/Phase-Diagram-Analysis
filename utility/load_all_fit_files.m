files = dir(['*.spc']);

if ~isempty(files)
    nf = length(files);

    for i = 1:nf
        load(files(i).name,'-ascii');
    end
end

clear files nf i;
return

% files = dir('*.spc');
% nf = length(files);
% 
% for i = 1:nf
%     load(files(i).name,'-ascii');
% end
% 
% clear files nf i 