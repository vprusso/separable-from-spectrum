%%  EIGENINTERVAL    Calculates the upper and lower eigenvalue bounds via SDP from Lemma 2 in [3]
%   This function has two required arguments:
%       DIM: the dimension of the Choi matrix
%       CHOI_MAT: the Choi matrix of the positive map
%
%   [LB,UB] = EigenInterval(DIM,CHOI_MAT) computes the
%   upper and lower eigenvalue bounds described in Lemma 2. As an example,
%   the result of Lemma 5 for the Choi map may be replicated by:
%
%   [LB,UB] = EigenInterval(3,ChoiMap());
%
%   This function has no optional arguments.
%
%   References:
%   [1] CVX: (http://cvxr.com/cvx/)
%   [2] QETLAB: (http://www.qetlab.com/)
%   [3] Is Separability from Spectrum Determined by the Partial Transpose?
%       - S. Arunachalam, N. Johnston, V. Russo

%   requires: CVX [1], QETLAB [2]
%   authors: Srinivasan Arunachalam (S.Arunachalam@cwi.nl)
%            Nathaniel Johnston (nathaniel@njohnston.ca)
%            Vincent Russo (vincentrusso1@gmail.com)
%   version: 1.00
%   last updated: May 9, 2014

function [lb,ub] = EigenInterval(dim,choi_mat)

% properly rescales things and works for trace preserving positive maps
choi_mat = dim * choi_mat / trace(choi_mat);

% add the identity to ensure choi_mat is PSD
[~,~,upper_bound,~] = SkOperatorNorm(choi_mat + eye(dim^2));

lb = 1/2 * (1 - DiamondNorm(choi_mat)); 
ub = (upper_bound-1);

end