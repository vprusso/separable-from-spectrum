%%  WernerAbsPPT    Determines whether or not the Werner -1/(n-1) state is absolutely PPT
%   requires: nothing
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QETLAB
%   last updated: December 11, 2014

function appt = WernerAbsPPT(n)

    appt = 1;
    a = -2/n;
    b = (2*n-4)/n;
    c = 2;
    
    offdent = [0,a,0];
    dent = [0,b,c];
    
    X = zeros(n,n);
    fill_matrix(n,n);
    
    function fill_matrix(i,j)
        X(i,j) = 1;
        
        if(nnz(X) >= n) % add new constraint matrix
            Y = min(X+X.',1)+1;
            Yd = diag(diag(Y));
            Y = Y - Yd;
            Y = Y + 1;
            Yd = Yd + 1;
            if(~IsPSD(offdent(Y) + dent(Yd)))
                appt = 0;
                return;
            end
            
        else % we're not done building the constraint matrix yet
            for k = 0:1 % k = 0: go up, k = 1: go left
                if(k == 0) % go up
                    if(i >= 1 && (j == n || X(i-1,j+1) == 1))
                        fill_matrix(i-1,j);
                    end
                else % go left
                    if(i < j)
                        fill_matrix(j-1,j-1);
                    end
                end
            end
        end
        
        X(i,j) = 0;
    end

    return;
end