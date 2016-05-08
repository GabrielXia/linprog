function [A] = Aform(AStd,BStd,fStd,cbindex,cnindex,transf)
    line = size(AStd,1);
    n=size(AStd,2);
    %cb is the coefficient of base in fStd
    cb=zeros(line,1); 
    cbindexreal =zeros(1,line);
    for i= 1:line
        cbindexreal(i)=find(transf==cbindex(i),1);
        cb(i) =fStd(cbindex(i));
    end
    %B is consisted of the colone of base
    B = AStd(:,cbindexreal);
    %cn is the coefficient of not base in fStd
    cn=zeros(n-line,1);
    cnindexreal =zeros(1,n-line);
    for i= 1:n-line
        cnindexreal(i)=find(transf==cnindex(i),1);
        cn(i)=fStd(cnindex(i));
    end
    N = AStd(:,cnindexreal);
    %we get the lastline in the matrix here
    temps = (cb')*(B^-1)*N-cn';
    lastline = zeros(1,n);
    %in the lastline,only the colone of not base has value
    for i = 1:size(cnindex,2)
        lastline(find(transf==cnindex(i),1)) =temps(i);
    end      
    %the initial value of the question(solution possible)
    val =cb'*BStd;
    %Finally we get the big matrice A, we will operate in A to get the soution
    A = [AStd,BStd;lastline,val];
