function [x,val]=projet(f,Aeq,Beq,Aineq,Bineq)
% min(f'.x)
% Aeq .x = Beq ; A .x = B
%eqNum is the number of equation
[eqNum,Num2]=size(Aeq);
%ineqNum is the number of inequation
[ineqNum,Num]=size(Aineq);
%line is the number of row in the matrice not include the lastrow
line=eqNum+ineqNum;

%text if the dimension is right
if (~isempty(Aeq))&&(~isempty(Aineq))
    if((Num~=Num2)||~isequal(size(f),[Num,1])||~isequal(size(Beq),[eqNum,1])||~isequal(size(Bineq),[ineqNum,1]))
        error('Dimension error');
    end
else if isempty(Aineq)
        Num = Num2;
    end
end
%we make this peroblem in standard form,which is xi = ui - vi and ui>=0,vi>0
fStd = [f;-f;zeros(line,1)]; 

AStd = [Aeq, -Aeq,eye(eqNum),zeros(eqNum,ineqNum);Aineq, -Aineq,zeros(ineqNum,eqNum),eye(ineqNum)];
BStd = [Beq; Bineq];

%n is the number of colone not include the last colone
n = size(AStd,2);
%transf is a list whose index is the index of colone of matrice and whose value is the index of xi, it's used when we delete a colone
transf= 1: n;
% if it's the cas 2 phrase
if ~isempty(Aeq)
    %Etape 0:change c
    arti = 2*Num+1:2*Num+eqNum;
    %ff is the new fStd here
    ff=zeros(n,1);
    for i =arti;
        ff(i)=1;
    end
    %index of base
    cbindex = (2*Num+1):n;
    cnindex = 1:2*Num;
    %Etape 1
    A = Aform(AStd,BStd,ff,cbindex,cnindex,transf);disp(A);
    %Etape 2,Etape 3,Etape 4
    while ~isempty(arti)
        [A,cbindex,cnindex,arti,transf,n]=simplexe(A,cbindex,cnindex,arti,transf);
    end
    if abs(A(line+1,n+1))>0.001
        error('pas de solution optimal');
    end
    %Etape 7
    A = Aform(A(1:line,1:n),A(1:line,n+1),fStd,cbindex,cnindex,transf);disp(A);

    max_lastline=max(A(line+1,1:n));
    %Etape2,Etape3,Etape4
    while max_lastline>0
        [A,cbindex,cnindex,arti,transf,n]=simplexe(A,cbindex,cnindex,arti,transf);
        max_lastline = max(A(line+1,1:n));
    end
% if it's the cas non variable artificiel
else
    %index of base
    cbindex = (2*Num+1):n;
    cnindex = 1:2*Num;
    %Etape 1
    A = Aform(AStd,BStd,fStd,cbindex,cnindex,transf);
    max_lastline =max(A(line+1,1:n));
    %Etape2,Etape3,Etape4
    while max_lastline>0
        [A,cbindex,cnindex,arti,transf,n]=simplexe(A,cbindex,cnindex,[],transf);
        max_lastline = max(A(line+1,1:n));
    end
end

%Etape 6: we get the result here
val = A(line+1,n+1);
x=zeros(1,Num);
for i = 1:line
    if cbindex(i)<=2*Num
        if cbindex(i) <=Num
            x(cbindex(i)) = x(cbindex(i)) + A(i,n+1);
        else
            x(cbindex(i)-Num) = x(cbindex(i)-Num) + A(i,n+1);
        end
    end
end
            
            
            





