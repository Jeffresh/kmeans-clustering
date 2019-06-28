clear;
clc;
close all;

rand('seed',0); 

randn('seed',0);

load iris1;

y = y+1;

N = length(y); % numero patrones
M = max(y); % numero de clases
K = M;

first = 1;
last = 4;

N_features = 4;
step = round(last/N_features);
i = 1;

for j = first:step:last
        xtst(i,:)=x(j,:);
        i = i+1;
end


for i=1:M
    ind = find(y==i);
    C{i} = covpat(xtst(:,ind));
end





%centroides = kmeans(x1,K);

centroides1 = kmeans(x(1:2,:),K);
centroides2 = kmeans(x(3:4,:),K);

centroides = kmeans(x,K);
for i=1:K
    CC{i} = centroides(:,i);
end

for i=1:K

    d(i,:) = d_mahal(xtst,CC{i},C{i});
end

[~,clase] = min(d);

c1= find(y == 1);
c2 = find(y == 2);
c3 = find(y == 3);

matriz_confusion =  [100*sum(y(c1)==clase(c1))/length(c1); 
                     100*sum(y(c2)==clase(c2))/length(c2);
                      100*sum(y(c3)==clase(c3))/length(c3)]

100*sum(y==clase)/N

%%

hold on;
color=['rgbkymc'];
for i=1:M
    ind = find(y==i);
    plot(x(1,ind),x(2,ind),['.' color(i)]);hold on
    plot(x(3,ind),x(4,ind),['.' color(i)]);
end

plot(centroides1(1,:),centroides1(2,:),'.b','MarkerSize',30);
plot(centroides2(1,:),centroides2(2,:),'.b','MarkerSize',30);

