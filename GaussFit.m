function [ B,H,R,Xc,Yc,Flag ] = GaussFit( imageinput )
%UNTITLED3 ����һ��ͼ�������и�˹��Ϻ󷵻ض��Ľ��xc,yc��H�Լ�R��ֵ��
%   image Ϊ����ͼ�����BΪָ������ձ���ֵ
[m,~]=size(imageinput);
imageinput=double(imageinput);
%�趨�����ĳ�ʼֵ
B0=mean(imageinput(:));[H0,pxy]=max(imageinput(:));
if rem(pxy,m)==0
    x0=fix(pxy/m)-0.5;
    y0=m-0.5;
else
    x0=fix(pxy/m)+0.5;
    y0=rem(pxy,m)-0.5;
end
R0=1.5;
Flag = 1;
p = 1;
while 1
    [dB,dH,dR,dXc,dYc]=gaussfitcore( imageinput,B0,H0,R0,x0,y0);
    if abs(dB)<0.01 && abs(dH)<0.01 && abs(dR)<0.01 && abs(dXc)<0.001 && abs(dYc)<0.001
        B=B0;H=H0;R=R0;Xc=x0;Yc=y0;
        break
    elseif p>50
         B=B0;H=H0;R=R0;Xc=x0;Yc=y0;
         Flag = 0;
        break
    else
        B0=B0+dB;
        H0=H0+dH;
        R0=R0+dR;
        x0=x0+dXc;
        y0=y0+dYc;
        p = p+1;
    end
end

end

