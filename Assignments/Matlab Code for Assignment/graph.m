y = gaussmf(x,[sig c]);
x = 0:0.1:10;
y = gaussmf(x,[2 5]);
figure;
plot(x,y)
xlabel('gaussmf, P=[2 5]')