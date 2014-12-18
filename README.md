# Is Absolute Separability Determined by the Partial Transpose?

A small collection of MATLAB scripts that supplement the content in the following paper:

[AJR14] S. Arunachalam, N. Johnston, V. Russo Is Absolute Separability Determined by the Partial Transpose? [arXiv:1405.5853][1]

See Lemma 2 and Lemma 5 in [AJR14] for more information in regards to the MATLAB scripts.

Tested with MATLAB 7.10.0 (R2010a)

Requires:

- CVX -- [www.cvxr.com](www.cvxr.com)
- QETLAB -- [http://www.qetlab.com](http://www.qetlab.com)
 
[1]: http://arxiv.org/abs/1405.5853

## Usage

In `ChoiExample.m`, the script determines the eigenvalue range described in Lemma 5 for the Choi Map by using
`EigenInterval.m`, and also runs the semidefinite program (SDP) described in Eq. (4) of [1] in `EigenRangeSDP.m`. 
A second example of using the reduction map is also given. 

In `IsWernerAbsPPTCheck.m` the script cycles through all Werner -1/(n-1) states and determines if the constraint
matrices generated are absolutely PPT. For n = 1...140 this has been checked to be true. Checking for higher 
values of `n` is computationally taxing. 