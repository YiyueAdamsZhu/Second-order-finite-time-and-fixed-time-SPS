 function dx=huliu(x,P,n,t,alpha2,beta2,s,alpha1,beta1,tau,a)
dx=zeros(3*n,1);
w=x(1:n)-gz1(x(1:n),s);
aa=x(n+1:2*n)+a*(eye(n)-P)*((sign(w).*abs(w).^(alpha1)))+a*(eye(n)-P)*((sign(w).*abs(w).^(beta1)));
dx(1:n)=(eye(n)-P)*x(n+1:2*n);
dx(n+1:2*n)=-1/tau*((sign(aa).*abs(aa).^alpha2+sign(aa).*abs(aa).^beta2));
 end