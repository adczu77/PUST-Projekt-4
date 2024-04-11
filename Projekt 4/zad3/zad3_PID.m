clear;

%Inicjalizacja zmiennych:
T=0.5;
E=0;
wersja=3;

% Parametry w zależności od wersji 
% (który uchyb wpływa na które wyjście)
if wersja==1
    K=[1 1 1];
    Ti=[inf inf inf];
    Td=[0 0 0];
elseif wersja==2
    K=[1 1 1];
    Ti=[inf inf inf];
    Td=[0 0 0];
elseif wersja==3
    K=[1 1 1];
    Ti=[inf inf inf];
    Td=[0 0 0];
end

%Obliczenie parametrów regulatorów:
r0(1)=K(1)*(1+T/(2*Ti(1))+Td(1)/T);
r1(1)=K(1)*(T/(2*Ti(1))-2*Td(1)/T-1);
r2(1)=K(1)*Td(1)/T;
r0(2)=K(2)*(1+T/(2*Ti(2))+Td(2)/T);
r1(2)=K(2)*(T/(2*Ti(2))-2*Td(2)/T-1);
r2(2)=K(2)*Td(2)/T;
r0(3)=K(3)*(1+T/(2*Ti(3))+Td(3)/T);
r1(3)=K(3)*(T/(2*Ti(3))-2*Td(3)/T-1);
r2(3)=K(3)*Td(3)/T;

% Określenie warunków początkowych:
kk=1000;
y1(1:kk)=0;
y2(1:kk)=0;
y3(1:kk)=0;
u1(1:kk)=0;
u2(1:kk)=0;
u3(1:kk)=0;
u4(1:kk)=0;
e1(1:kk)=0;
e2(1:kk)=0;
e3(1:kk)=0;

% Określenie trajektorii zadanej:
yzad(1:kk)=0;
yzad(100:kk)=2;
yzad(400:kk)=-6;
yzad(700:kk)=5;

% Algorytm PID:
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
    
    % Obliczenie uchybu:
    e1(k)=yzad(k)-y1(k);
    e2(k)=yzad(k)-y2(k);
    e3(k)=yzad(k)-y3(k);

    % Wyliczenie sterowań dla danych wersji:
    if wersja==1
        u1(k)=r2(1)*e1(k-2)+r1(1)*e1(k-1)+r0(1)*e1(k)+u1(k-1);
        u2(k)=r2(2)*e2(k-2)+r1(2)*e2(k-1)+r0(2)*e2(k)+u2(k-1);
        u3(k)=r2(3)*e3(k-2)+r1(3)*e3(k-1)+r0(3)*e3(k)+u3(k-1);
    elseif wersja==2
        u4(k)=r2(1)*e1(k-2)+r1(1)*e1(k-1)+r0(1)*e1(k)+u4(k-1);
        u2(k)=r2(2)*e2(k-2)+r1(2)*e2(k-1)+r0(2)*e2(k)+u2(k-1);
        u1(k)=r2(3)*e3(k-2)+r1(3)*e3(k-1)+r0(3)*e3(k)+u1(k-1);
    elseif wersja==3
        u4(k)=r2(1)*e1(k-2)+r1(1)*e1(k-1)+r0(1)*e1(k)+u4(k-1);
        u2(k)=r2(2)*e2(k-2)+r1(2)*e2(k-1)+r0(2)*e2(k)+u2(k-1);
        u3(k)=r2(3)*e3(k-2)+r1(3)*e3(k-1)+r0(3)*e3(k)+u3(k-1);
    end
    % Wyliczenie błędu:
    E=E+(yzad(k)-y1(k))^2+(yzad(k)-y2(k))^2+(yzad(k)-y3(k))^2;
end

% Pokazanie przebiegu:
if wersja==1
    figure
    hold on;
    stairs(1:kk,u1)
    stairs(1:kk,u2)
    stairs(1:kk,u3)
    hold off;
    title("Przebiegi sterowania PID, E="+num2str(E)+":")
    xlabel('k')
    ylabel('u')
    legend('u1','u2','u3','Location','southeast')

    figure
    hold on
    stairs(1:kk,y1)
    stairs(1:kk,y2)
    stairs(1:kk,y3)
    stairs(1:kk,yzad, '--')
    hold off;
    title("Przebiegi wyjścia PID, E="+num2str(E)+":")
    xlabel('k')
    ylabel('y')
    legend('y1','y2','y3','yzad','Location','southeast')
elseif wersja==2
    figure
    hold on;
    stairs(1:kk,u4)
    stairs(1:kk,u2)
    stairs(1:kk,u1)
    hold off;
    title("Przebiegi sterowania PID, E="+num2str(E)+":")
    xlabel('k')
    ylabel('u')
    legend('u4','u2','u1','Location','southeast')

    figure
    hold on
    stairs(1:kk,y1)
    stairs(1:kk,y2)
    stairs(1:kk,y3)
    stairs(1:kk,yzad, '--')
    hold off;
    title("Przebiegi wyjścia PID, E="+num2str(E)+":")
    xlabel('k')
    ylabel('y')
    legend('y1','y2','y3','yzad','Location','southeast')
elseif wersja==3
    figure
    hold on;
    stairs(1:kk,u4)
    stairs(1:kk,u2)
    stairs(1:kk,u3)
    hold off;
    title("Przebiegi sterowania PID, E="+num2str(E)+":")
    xlabel('k')
    ylabel('u')
    legend('u4','u2','u3','Location','southeast')

    figure
    hold on
    stairs(1:kk,y1)
    stairs(1:kk,y2)
    stairs(1:kk,y3)
    stairs(1:kk,yzad, '--')
    hold off;
    title("Przebiegi wyjścia PID, E="+num2str(E)+":")
    xlabel('k')
    ylabel('y')
    legend('y1','y2','y3','yzad','Location','southeast')
end
