function kk = crossValidation(A,B,m)
error1=[];

for l = 1:40 %the settled upper bound
    error_sparsity=[];
    for count = 1:20% the 
        
    rand=randperm(size(A,1),m);
    
    %creating the test set
    A_test=A(rand,:);
    B_test=B(rand);
    
    %deleting the test set values from the training set
    A2=A;
    B2=B;    
    A2(rand,:)=[];
    B2(rand,:)=[];
P=A2'/(A2*A2')*A2;
q1=A2'/(A2*A2')*B2;
q2=[q1;zeros(n,1);zeros(n,1)];
[t5,x1]=ode113(@(t,y)qq2(y,P,n,t,0.5,kk,0.5,1,1),0:0.1:100,q2);% For Self-trained second-order fixed system, it should be t5,x1]=ode113(@(t,y)q5(y,P,n,t,0.5,1.5,kk,0.5,1.5,1,1),0:0.1:100,q2);
    DCT=x1(end,1:size(A,2)^2)';
rec_measure = A_test * DCT;%measure the error
    error_sparsity(count) =norm(B_test - rec_measure,2);%sum the error

    end
    error1(l)=sum(error_sparsity);

end  

[~,position] = min(error1(1:end));
kk = position;%find the most suitable one
    
end