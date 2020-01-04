

d=0.05;
nt=1000;

a=1.0;
A=3.0;
b=1.0;  
B=3.0;

e0=8.85E-12;
u=3.0E+8;

nx=A/d;
ny=B/d;
nxc=a/d;
nyc=b/d;

vd=100;



v = zeros(ny+1,nx+1);  %v matrix shows the nodes according to what is explained in the report, with v(1,1) being top left and v(ny+1,nx+1) being the bottom right.

sy=ny+1-nyc;   
sx=nxc+1;     
      
v(sy:ny+1,1:sx) = vd; %initializing, assiging voltage to the core

for k=1:nt
    for i=1:nx
        for j=2:ny+1
           if ((j>=sy) && (i<=sx))
               %nothing
           elseif ((i==1) && (j<sy))
               v(j,i)=0.25*(2*v(j,i+1)+v(j+1,i)+v(j-1,i));
           elseif ((i>sx) && (j==ny+1)) 
               v(j,i)=0.25*(2*v(j-1,i)+v(j,i+1)+v(j,i-1));
           else
               v(j,i)=0.25*(v(j+1,i)+v(j-1,i)+v(j,i+1)+v(j,i-1));
            
           end
        end
    end
end

figure(1),imagesc(v),title('potential - V (volt)'),grid


jo=round(sy/2.0);
io=round((sx+nx)/2.0);

sumout=0.5*v(jo,1)+sum(v(jo,2:io))+sum(v(jo+1:ny,io+1))+0.5*v(ny+1,io+1);
sumin=0.5*v(jo+1,1)+sum(v(jo+1,2:io))+sum(v(jo+1:ny,io))+0.5*v(ny+1,io);


Q=e0*(sumout-sumin);

c0= abs(4*Q/vd)
z0= 1.0/(u*c0)
               

               
            