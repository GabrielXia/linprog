function [A,cbindex,cnindex,arti,transf,n] =simplexe(A,cbindex,cnindex,arti,transf)
[line,col]=size(A);
Num = ((col-1)-(line-1))/2;
cindextotal = [cbindex,cnindex];
[max_lastline,max_index]=max(A(line,1:col-1));
[min_index,min_col]=findPivot(A,arti,max_index);

if min_col ==0%Etape5: if it's the cas degenere
    max_index = find(A(line,1:col-1)>0,1);
    [min_index,min_col]=findPivot(A,arti,max_index);
end
A(min_index,:)=A(min_index,:)/A(min_index,max_index);
for i = [1:min_index-1,min_index+1:line]
    A(i,:)=A(i,:)-A(min_index,:)*A(i,max_index);
end
disp(A);
if ismember(transf(min_index+2*Num),arti)&&A(line,max_index)<=0
    A(:,min_index+2*Num)=[];
    col=col-1;
    arti=setdiff(arti,transf(min_index+2*Num));    
    if min_index +2*Num ~=col
        for i = min_index +2*Num : col-1
            transf(i)=transf(i+1);%col number to x number
        end
    end
    transf(col)=[];
   
    %update cbindex,cnindex
    cbindex(min_index) = transf(max_index);
    cnindex=setdiff(cnindex,transf(max_index));

else
    cbindex(min_index) = transf(max_index);
    cnindex=setdiff(cindextotal,cbindex);
end
n=col-1;