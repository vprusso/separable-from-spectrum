%%  EIGENRANGESDP    Calculates the primal and dual values of the SDP in Eq. (4) in [2]
%   This function has four required arguments:
%       M: the dimension of the firt subsystem
%       N: the dimension of the second subsystem
%       LB: the lower bound obtained from Lemma 2
%       UB: the upper bound obtained from Lemma 2
%
%   [M,N,LB,UB] = EigenRangeSDP(M,N,LB,UB) computes the primal and dual
%   values of the SDP in Eq. (4). An example of use for the standard Choi
%   Map is given as:
%
%   [LB,UB] = EigenInterval(3,ChoiMap());
%   [P_OPT,D_OPT] = EigenRangeSDP(3,3,LB,UB);
%
%   This function has no optional arguments.
%
%   References:
%   [1] CVX: (http://cvxr.com/cvx/)
%   [2] Is Separability from Spectrum Determined by the Partial Transpose?
%       - S. Arunachalam, N. Johnston, V. Russo

%   requires: CVX [1]
%   authors: Srinivasan Arunachalam (S.Arunachalam@cwi.nl)
%            Nathaniel Johnston (nathaniel@njohnston.ca)
%            Vincent Russo (vincentrusso1@gmail.com)
%   version: 1.00
%   last updated: May 9, 2014

function [primal_opt, dual_opt] = EigenRangeSDP(m,n,lb,ub)

%#ok<*EQEFF> 
%#ok<*VUNUS> 
k = ceil((1 - lb)/ub - 1); %#ok                             
mn = m*n;

% Primal Problem:
cvx_begin sdp quiet
    cvx_precision high;
    variable L(mn)
    minimize sum(L((mn+1)-k:mn))*ub + L(1)*lb + L(mn-k) - L(mn-k)*lb - k*L(mn-k)*ub
    subject to
        sum(L) == 1;                                   
        [ 2*L(mn),L(mn-1)-L(1); L(mn-1)-L(1), 2*L(mn-2)] >= 0;                 
     
        for j = 1:mn-1
            L(j) >= L(j+1);
        end
        L(mn) >= 0;
cvx_end

primal_opt = cvx_optval;

% Dual Problem:
cvx_begin sdp quiet
    cvx_precision high
    variables t a b b_bar c
    variable y(mn)
    maximize t
    subject to
        t - b - b_bar + y(1) <= lb;
        t + b + b_bar + y(mn-1) - y(mn-2) <= min(ub,1-ub-lb);
        t + 2 * c + y(mn-2) - y(mn-3) <= max(0,1-2*ub-lb);
        t + 2 * a - y(mn-1) <= ub;
         
        for i=1:mn-4
            t + y(i+1) - y(i) <= 0;
        end
         
        for i=1:mn-1
            y(i) >= 0;
        end
         
        [a b; b_bar c] >= 0;
cvx_end

dual_opt = cvx_optval;

end
