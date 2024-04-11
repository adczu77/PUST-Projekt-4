kk=200;
u1(1:kk)=0;
u2(1:kk)=0;
u3(1:kk)=0;
u4(1:kk)=0;
y1(1:kk)=0;
y2(1:kk)=0;
y3(1:kk)=0;
for k=5:kk
    [y1(k),y2(k),y3(k)]=symulacja_obiektu15y_p4( ...
        u1(k-1),u1(k-2),u1(k-3),u1(k-4), ...
        u2(k-1),u2(k-2),u2(k-3),u2(k-4), ...
        u3(k-1),u3(k-2),u3(k-3),u3(k-4), ...
        u4(k-1),u4(k-2),u4(k-3),u4(k-4), ...
        y1(k-1),y1(k-2),y1(k-3),y1(k-4), ...
        y2(k-1),y2(k-2),y2(k-3),y2(k-4), ...
        y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end

figure
stairs(1:kk,u1)
title('Punkt pracy u_{1}:')
xlabel('k')
ylabel('u_{1}(k)')
print('zad1_pp_u1.png','-dpng','-r400')

figure
stairs(1:kk,u2)
title('Punkt pracy u_{2}:')
xlabel('k')
ylabel('u_{2}(k)')
print('zad1_pp_u2.png','-dpng','-r400')


figure
stairs(1:kk,u3)
title('Punkt pracy u_{3}:')
xlabel('k')
ylabel('u_{3}(k)')
print('zad1_pp_u3.png','-dpng','-r400')

figure
stairs(1:kk,u4)
title('Punkt pracy u_{4}:')
xlabel('k')
ylabel('u_{4}(k)')
print('zad1_pp_u4.png','-dpng','-r400')


figure
stairs(1:kk,y1)
title('Punkt pracy y_{1}:')
xlabel('k')
ylabel('y_{1}(k)')
print('zad1_pp_y1.png','-dpng','-r400')


figure
stairs(1:kk,y2)
title('Punkt pracy y_{2}:')
xlabel('k')
ylabel('y_{2}(k)')
print('zad1_pp_y2.png','-dpng','-r400')

figure
stairs(1:kk,y3)
title('Punkt pracy y_{3}:')
xlabel('k')
ylabel('y_{3}(k)')
print('zad1_pp_y3.png','-dpng','-r400')