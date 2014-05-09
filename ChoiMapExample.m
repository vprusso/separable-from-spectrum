%%  CHOIMAPEXAMPLE     Primary example script for [3]
%   
%   This script gives an example of how one may use the supplementary
%   MATLAB functions for [3]. The first example illustrates how the 
%   eigenvalue interval in Lemma 5 is calculated as well as the SDP in Eq.
%   (4) for the Choi map. The second example calculates the same
%   quantities, but for the reduction map. 
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

%% Standard Choi Map : EXAMPLE 1
% uses QETLAB to define the standard Choi matrix of the Choi map
choi_mat = ChoiMap();

% calculates the eigenvalue interval for this map given by Lemma 5
[c_lb,c_ub] = EigenInterval(3,choi_mat);

% determines the primal and dual objective values of SDP in Eq. (4)
[c_primal, c_dual] = EigenRangeSDP(3,3,c_lb,c_ub);

%% Generalized Choi Map : EXAMPLE 2
% the Choi map function may also be parameterized for instance for b=c=1,
% the map corresponds to the reduction map
reduct_mat = ChoiMap(0,1,1);

% calculates the eigenvalue interval for this map given by Lemma 5
[r_lb,r_ub] = EigenInterval(3,reduct_mat);

% determines the primal and dual objective values of SDP in Eq. (4)
[r_primal, r_dual] = EigenRangeSDP(3,3,r_lb,r_ub);
