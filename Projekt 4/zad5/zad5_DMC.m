clear;

% Załadowanie odpowiedzi skokowych:
s11=load("odp_skok_y1_dla_u1.txt");
s12=load('odp_skok_y1_dla_u2.txt');
s13=load("odp_skok_y1_dla_u3.txt");
s14=load("odp_skok_y1_dla_u4.txt");
s21=load('odp_skok_y2_dla_u1.txt');
s22=load('odp_skok_y2_dla_u2.txt');
s23=load("odp_skok_y2_dla_u3.txt");
s24=load("odp_skok_y2_dla_u4.txt");
s31=load("odp_skok_y3_dla_u1.txt");
s32=load("odp_skok_y3_dla_u2.txt");
s33=load("odp_skok_y3_dla_u3.txt");
s34=load("odp_skok_y3_dla_u4.txt");

% Inicjalizacja parametrów DMC oraz błędu:
D=300;
N=10; %300, 150, 50, 25, 10, 1
Nu=1; %300, 150, 50, 25, 10, 1
E=0;

% Inicjalizacja zmiennych ilościowych (liczba wejść i wyjść):
nu=4;
ny=3;

% Stworzenie macierzy odpowiedzi skokowych:
S=cell(1,D);
for i=1:D
    S{i}=[s11(i) s12(i) s13(i) s14(i);
        s21(i) s22(i) s23(i) s24(i);
        s31(i) s32(i) s33(i) s34(i)];
end

% Tworzenie macierzy M:
M=cell(N,Nu);
for i=1:N
    for j=1:Nu
        if (i>=j)
            M{i,j}=S{min(i-j+1,D)};
        else
            M{i,j}=zeros(ny,nu);
        end
    end
end

% Tworzenie macierzy Mp:
Mp = cell(N, D-1);
for i=1:N
    for j=1:D-1
        if i + j <= D
            Mp{i,j}=S{i+j}-S{j};
        else
            Mp{i,j}=S{D}-S{j};
        end
    end
end

% Tworzenie macierzy lambda:
wektor_lambda=[0.0282 4.4605 6.3088 -0.0977];
lambda=eye(nu);
for i=1:nu
    for j=1:nu
        if i==j
            lambda(i,j)=wektor_lambda(i);
        end
    end
end
Lambda=cell(Nu,Nu);
for i=1:Nu
    for j=1:Nu
        if i==j
            Lambda{i,j}=lambda;
        else
            Lambda{i,j}=zeros(nu,nu);
        end
    end
end

% Tworzenie macierzy psi:
wektor_psi=[0.5478 9.9498 2.5941];
psi=eye(ny);
for i=1:ny
    for j=1:ny
        if i==j
            psi(i,j)=wektor_psi(i);
        end
    end
end
Psi=cell(N,N);
for i=1:N
    for j=1:N
        if i==j
            Psi{i,j}=psi;
        else
            Psi{i,j}=zeros(ny,ny);
        end
    end
end

% Konwersja obliczonych powyżej macierzy:
M=cell2mat(M);
Mp=cell2mat(Mp);
Psi=cell2mat(Psi);
Lambda=cell2mat(Lambda);

% Obliczenie macierzy K:
K=(M'*Psi*M+Lambda)^(-1)*M'*Psi;
K=mat2cell(K,nu*ones(1,Nu),ny*ones(1,N));
% Wyznaczenie parametru Ke
Ke=zeros(nu,ny);
K1=K(1,:);
for i = 1:length(K1)
    Ke=Ke+K1{i};
end
% Wyznaczenie wektora Ku
Ku=cell(1,D-1);
for i = 1: D -1
    Ku{i}=cell2mat(K1)*Mp(:,(nu*i-nu+1):(nu*i));
end
Ku=cell2mat(Ku);


% Określenie warunków początkowych:
kk=1000;
y1(1:kk)=0;
y2(1:kk)=0;
y3(1:kk)=0;
u1(1:kk)=0;
u2(1:kk)=0;
u3(1:kk)=0;
u4(1:kk)=0;

% Określenie trajektorii zadanej:
yzad(1:kk)=0;
yzad(100:kk)=2;
yzad(400:kk)=-6;
yzad(700:kk)=5;

% Algorytm DMC:
for k=5:kk
    % Pomiar wyjścia:
    [y1(k),y2(k),y3(k)]=symulacja_obiektu15y_p4( ...
        u1(k-1),u1(k-2),u1(k-3),u1(k-4), ...
        u2(k-1),u2(k-2),u2(k-3),u2(k-4), ...
        u3(k-1),u3(k-2),u3(k-3),u3(k-4), ...
        u4(k-1),u4(k-2),u4(k-3),u4(k-4), ...
        y1(k-1),y1(k-2),y1(k-3),y1(k-4), ...
        y2(k-1),y2(k-2),y2(k-3),y2(k-4), ...
        y3(k-1),y3(k-2),y3(k-3),y3(k-4));

    % Wyliczenie wektora dUp:
    dUp=cell(D-1,1);
    for i=1:D-1
        dUp{i}=[0;0;0;0];
        if k-i-1>0
            dUp{i}=[u1(k-i)-u1(k-1-i);u2(k-i)-u2(k-1-i);u3(k-i)-u3(k-1-i);u4(k-i)-u4(k-1-i)];
        end
    end
    dUp=cell2mat(dUp);
    % Wyliczenie przyrostów sterowań:
    dU =Ke*[yzad(k)-y1(k);yzad(k)-y2(k);yzad(k)-y3(k)]-Ku*dUp;
    % Obliczenie poszczególnych sterowań:
    u1(k)=u1(k-1)+dU(1);
    u2(k)=u2(k-1)+dU(2);
    u3(k)=u3(k-1)+dU(3);
    u4(k)=u4(k-1)+dU(4);
    % Wyliczenie błędu:
    E=E+(yzad(k)-y1(k))^2+(yzad(k)-y2(k))^2+(yzad(k)-y3(k))^2;
end

% Pokazanie przebiegów:
figure
hold on;
stairs(1:kk,u1)
stairs(1:kk,u2)
stairs(1:kk,u3)
stairs(1:kk,u4)
hold off;
title("Przebiegi sterowania DMC, E="+num2str(E)+":")
xlabel('k')
ylabel('u')
legend('u1','u2','u3','u4','Location','southeast')
%print("dmc_u_N_10_Nu_1_mi_lambda_ga.png",'-dpng','-r400')

figure
hold on
stairs(1:kk,y1)
stairs(1:kk,y2)
stairs(1:kk,y3)
stairs(1:kk,yzad, '--')
hold off;
title("Przebiegi wyjścia DMC, E="+num2str(E)+":")
xlabel('k')
ylabel('y')
legend('y1','y2','y3','yzad','Location','southeast')
%print("dmc_y_N_10_Nu_1_mi_lamda_ga.png",'-dpng','-r400')