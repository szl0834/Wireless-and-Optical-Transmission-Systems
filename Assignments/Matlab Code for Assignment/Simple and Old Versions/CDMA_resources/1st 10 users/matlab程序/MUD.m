%在DS-spread spectrum系统中,噪声为加性高斯白噪声,传统单用户检测,线性解相关多用户检测和最小均方误差多用户检测的性能比较
clear all
close all
clc;
prompt={'Enter the numbers of user:','Enter the length of user code:','Enter the power of the user code','Enter the power of Noise','Enter the kth user which you want to test?'};
name=['CDMA MUD TEST'];
line=1;
defaultanswer={'10','5000','1 2 3 4 5 6 7 8 9 10', '10','1'};
glabel=inputdlg(prompt,name,line,defaultanswer);
num1=str2num(char(glabel(1,1)));
num2=str2num(char(glabel(2,1)));
num3=str2num(char(glabel(3,1)));
num4=str2num(char(glabel(4,1)));
k=str2num(char(glabel(5,1)));
UserNumber=num1;%用户数
inflength=num2;%用户信息序列长度
a=num3;  %用户信息功率
Pn=num4; %噪声功率
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

    A=diag(a);
    y=R*A*b+n;  %传统单用户检测
    ydec=inv(R)*y;   %线性解相关多用户检测
    ymmse=inv(R+sigma^2*inv(A))*y;  %最小均方误差多用户检测
   for i=1:UserNumber
    ylen(i)=length(find(sign(real(y(i,:)))-b(i,:)));  
    ydeclen(i)=length(find(sign(real(ydec(i,:)))-b(i,:)));
    ymmselen(i)=length(find(sign(real(ymmse(i,:)))-b(i,:)));
    BER_y(i)=ylen(i)/inflength;
    BER_ydec(i)=ydeclen(i)/inflength;
    BER_ymmse(i)=ymmselen(i)/inflength;
   end
  
    snr=20*log10(a(1)/Pn);
    disp('信噪比为');
    disp(snr);
    disp('误码个数为');
    disp(ylen(k));
    disp(ydeclen(k));
    disp(ymmselen(k));
    disp('误码率为');
    disp( BER_y(k));
    disp(BER_ydec(k));
    disp(BER_ymmse(k)); 

