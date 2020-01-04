clc;

d=0.01;
nt=1000;

a=2.02; 
b=3.5;  %b/2 due to symmetry
w=0.5;  %w/2 due to symmetry
h=1.0;

er=9.6;
e0=8.85E-12;
u=3.0E+8;

e1=e0;
e2=e0;

nx=b/d;
ny=a/d;
nw=w/d;
nh=h/d;

vd=100;
err=1.0;

for L=1:2
e2=e0*err;
v = zeros(ny+1,nx+1);  %v matrix shows the nodes according to what is explained in the report, with v(1,1) being top left and v(ny+1,nx+1) being the bottom right.

sy1=ny+1-nh;   %strip position from top of the matrix 
sy2=ny-nh;     %accounting fro strip's thickness. vertically 2 nodes.
sx=nw+1;       %accounting for width of the strip
v(sy1,1:nw+1) = vd; %initializing, assiging voltage to the strip (Vd)
v(sy2,1:nw+1) = vd;
p1= e1/(2*(e1+e2));  %FDM coefficients on dielectric surface.
p2= e2/(2*(e1+e2));

for k=1:nt
    for i=1:nx
        for j=2:ny
           if (((j==sy1)||(j==sy2)) && (i<=sx)) 
               %nothing
           elseif (j==sy1)
               v(j,i)=0.25*(v(j,i-1)+v(j,i+1))+p2*v(j+1,i)+p1*v(j-1,i);
           elseif ((i==1) && (j>1)) 
               v(j,i)=0.25*(2*v(j,i+1)+v(j+1,i)+v(j-1,i));
           else
               v(j,i)=0.25*(v(j+1,i)+v(j-1,i)+v(j,i+1)+v(j,i-1));
            
           end
        end
    end
end

figure(L),imagesc(v),title('potential - V (volt)'),grid

sumout= v(69,1)*(e1/2.0)+sum(v(69,2:100))*e1+sum(v(70:102,101))*e1+v(103,101)*((e1+e2)/2.0)+sum(v(104:135,101))*e2+v(136,1)*(e2/2)+sum(v(136,2:100))*e2;

sumin= v(70,1)*(e1/2.0)+sum(v(70,2:100))*e1+sum(v(70:102,100))*e1+v(103,100)*((e1+e2)/2.0)+sum(v(104:135,100))*e2+v(135,1)*(e2/2)+sum(v(135,2:100))*e2;

Q(L)=sumout-sumin;

if L==1
    err=9.4; 
end

end

c0= abs(2*Q(1)/vd)
c1= abs(2*Q(2)/vd)
z0=1.0/(u*sqrt(c0*c1))
               

               
            