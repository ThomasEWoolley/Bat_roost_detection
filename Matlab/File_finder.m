ccc


Files=dir('C:/Users/Thomas Woolley/Dropbox/Lucys_thesis_bats/**/*.jl');
% files = dir('D:\Data\**\*.mat')
Loc={Files.folder};
Filenames={Files.name};
Ttf='rf_detector_distribution';
Ttf='calc_dist_stoch';
Ttf='rf_buckfastleigh_det_hedges'
Ttf='buckfastleigh'
Ttf='return_countdf'
Ttf='deterministicdensity'
l=1;

for i=1:length(Filenames)
    A = fscanf(fopen([Loc{i},'\',Filenames{i}],'r'),'%s');
    fclose('all');
    
    if ~isempty(strfind(A,Ttf))
        Image_and_file(l,:)={Ttf,Loc{i},Filenames{i}};
        l=l+1;
    end
end

Image_and_file{:}

%%
for n=1:l-1
open([Image_and_file{n,2},'\',Image_and_file{n,3}])
end
%%
function output = extract_text(string, start_delim, end_delim)
start_index = strfind(string, start_delim);
if isempty(start_index)
    output = '';
    return
end
start_index = start_index + length(start_delim);
end_index = strfind(string, end_delim);
if isempty(end_index)
    output = '';
    return
end
output = string(start_index:end_index-1);
end
