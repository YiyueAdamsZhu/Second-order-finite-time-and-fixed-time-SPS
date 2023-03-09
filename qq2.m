 function dx=huliu(x,P,n,t,alpha1,kk,alpha2,tau,a)

 
dx=zeros(3*n,1);
w=(eye(n)-P)*(x(1:n)-gz1(x(1:n),kk));
aa=(eye(n)-P)*(x(n+1:2*n,1)+a*((sign(w).*abs(w).^(alpha1))));
dx(1:n)=x(n+1:2*n);
dx(n+1:2*n)=-1/tau*(eye(n)-P)*(sign(aa).*abs(aa).^alpha2);
 end