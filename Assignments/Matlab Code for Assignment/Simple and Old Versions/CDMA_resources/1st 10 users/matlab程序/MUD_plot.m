%在DS-spread spectrum系统中,噪声为加性高斯白噪声,传统单用户检测,线性解相关多用户检测和最小均方误差多用户检测的性能比较
clear all
close all
clc;
%prompt={'Enter the numbers of user:','Enter the length of user code:','Enter the power of the user code','Enter the power of Noise'};
%name=['CDMA MUD TEST'];
%line=1;
%defaultanswer={'10','5000','1 2 3 4 5 6 7 8 9 10', '10'};
%glabel=inputdlg(prompt,name,line,defaultanswer);
%num1=str2num(char(glabel(1,1)));
%num2=str2num(char(glabel(2,1)));
%num3=str2num(char(glabel(3,1)));
%num4=str2num(char(glabel(4,1)));
UserNumber=10;%用户数
inflength=5000;%用户信息序列长度
a=[1 1 1 1 1 1 1 1 1 1];  %用户信息功率
Pn=30; %噪声功率
sigma=1;%噪声标准差
N=31;
R=(ones(UserNumber)+(N-1)*eye(UserNumber))/N; %相关系数矩阵
b=2*randint(UserNumber,inflength)-1;   %用户信息矩阵(随机+1，-1矩阵)

%******Generate M sequence******************
coefficients=[1 0 1 0 0]; %5级左移m序列码发生器的反馈系数
mseq=mseries(coefficients); %生成31×31的m序列码矩阵
mseq=mseq(1:UserNumber,1:N);
%*******************************************



%**********Generate noise*******************
n1=Pn*normrnd(0,1,1,inflength*N);
n=zeros(UserNumber,inflength);
for j=1:inflength
   ntemp=n1(1,((j-1)*N+1):j*N);
   n(:,j)=(mseq*ntemp')/N;
end
%*******************************************

for k=1:1000
    a1=a+a*0.1*k;
    A=diag(a1);
    y=R*A*b+n;  %传统单用户检测
    ydec=inv(R)*y;   %线性解相关多用户检测
    ymmse=inv(R+sigma^2*inv(A))*y;  %最小均方误差多用户检测
    ylen=length(find(sign(real(y(1,:)))-b(1,:)));  
    ydeclen=length(find(sign(real(ydec(1,:)))-b(1,:)));
    ymmselen=length(find(sign(real(ymmse(1,:)))-b(1,:)));
    BER_y(1,k)=ylen/inflength;
    BER_ydec(1,k)=ydeclen/inflength;
    BER_ymmse(1,k)=ymmselen/inflength;
    snr(1,k)=20*log10(a1(1)/Pn);
    disp('误码个数为');
    disp(ylen);
    disp(ydeclen);
    disp(ymmselen);
    disp('误码率为');
    disp( BER_y(1,k));
    disp(BER_ydec(1,k));
    disp(BER_ymmse(1,k));    
end

%***画出两种检测方法的BER-SNR对比图********
plot(snr,BER_y,'r-',snr,BER_ydec,'g:',snr,BER_ymmse,'y-.');
legend('\it匹配滤波器','\it解相关检测','\it最小均方误差检测');
xlabel('信噪比(dB)'),ylabel('误码率');