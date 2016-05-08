function [min_index,min_col] =findPivot(A,arti,max_index)
[line,col]=size(A);
Num = ((col-1)-(line-1))/2;

firstPos=find(A(1:line-1,max_index)>0,1);
if isempty(firstPos) 
    error('pas de solution optimal');
end
%we set the priority to eliminate the variable artificiel here
if ~isempty(arti)
    min_index=firstPos;
    min_col= A(firstPos,col)/A(firstPos,max_index);
    for i = arti -2*Num
        if A(i,max_index)>0
            if A(i,col)/A(i,max_index) < min_col
                min_index = i;
                min_col = A(i,col)/A(i,max_index);
            end
        end
    end
    for i = setdiff(1:line-1,arti- 2*Num)
        if A(i,max_index)>0
            if A(i,col)/A(i,max_index) < min_col
                min_index = i;
                min_col = A(i,col)/A(i,max_index);
            end
        end
    end
    
else   
    min_index=firstPos;
    min_col= A(firstPos,col)/A(firstPos,max_index);
    for i = 1:line-1
        if A(i,max_index)>0
            if A(i,col)/A(i,max_index) < min_col
                min_index = i;
                min_col = A(i,col)/A(i,max_index);
            end
        end
    end
end

