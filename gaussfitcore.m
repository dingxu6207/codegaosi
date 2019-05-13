function [dB,dH,dR,dXc,dYc] = gaussfitcore( image,B0,H0,R0,x0,y0 )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n]=size(image);
M=zeros(5,5);Y=zeros(5,1);
for i=0.5:m-0.5
    for j=0.5:n-0.5
        tb=1;
        th=exp(double((-((j-x0)^2+(i-y0)^2)/(2*R0^2))));
        tx=H0*th*(j-x0)/R0^2;
        ty=H0*th*(i-y0)/R0^2;
        tr=H0*th*((j-x0)^2+(i-y0)^2)/R0^3;
        M(1,1)=M(1,1)+1+1e-8;
        M(1,2)=M(1,2)+tb*th;
        M(1,3)= M(1,3)+tb*tr;
        M(1,4)=M(1,4)+tb*tx;
        M(1,5)=M(1,5)+tb*ty;
        M(2,1)=M(2,1)+th*tb;
        M(2,2)=M(2,2)+th*th+1e-8;
        M(2,3)=M(2,3)+th*tr;
        M(2,4)=M(2,4)+th*tx;
        M(2,5)=M(2,5)+th*ty;
        M(3,1)=M(3,1)+tr*tb;
        M(3,2)=M(3,2)+tr*th;
        M(3,3)=M(3,3)+tr*tr+1e-8;
        M(3,4)=M(3,4)+tr*tx;
        M(3,5)=M(3,5)+tr*ty;
        M(4,1)=M(4,1)+tx*tb;
        M(4,2)=M(4,2)+tx*th;
        M(4,3)=M(4,3)+tx*tr;
        M(4,4)=M(4,4)+tx*tx+1e-8;
        M(4,5)=M(4,5)+tx*ty;
        M(5,1)=M(5,1)+ty*tb;
        M(5,2)=M(5,2)+ty*th;
        M(5,3)=M(5,3)+ty*tr;
        M(5,4)=M(5,4)+ty*tx;
        M(5,5)=M(5,5)+ty*ty+1e-8;
        Ytemp=image(i+0.5,j+0.5)-B0-H0*th;
        Y(1)=Y(1)+Ytemp*tb;
        Y(2)=Y(2)+Ytemp*th;
        Y(3)=Y(3)+Ytemp*tr;
        Y(4)=Y(4)+Ytemp*tx;
        Y(5)=Y(5)+Ytemp*ty;        
    end
end
dp=M\Y;
dB=dp(1);
dH=dp(2);
dR=dp(3);
dXc=dp(4);
dYc=dp(5);
end

