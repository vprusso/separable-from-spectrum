%%  IsWernerAbsPPTCheck    Checks absolute PPT condition on the constraint matrices for the Werner -1/(n-1) states
%   requires: nothing
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QETLAB
%   last updated: December 18, 2014

function is_abs_ppt = IsWernerAbsPPTCheck(start_dim, end_dim)

is_abs_ppt = {end_dim};
for i = start_dim:end_dim
    is_abs_ppt{i} = WernerAbsPPT(i);
end

save('is_abs_ppt.mat');

end

