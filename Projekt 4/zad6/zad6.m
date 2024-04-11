[u1a,u2a,u3a,u4a,y1a,y2a,y3a,yzada]=zad6_DMC_analityczny();
[u1k,u2k,u3k,u4k,y1k,y2k,y3k,yzadk]=zad6_DMC_klasyczny();

% Pokazanie przebiegów:
blad=sum((u1a-u1k).^2);
figure
hold on;
stairs(1:kk,u1a)
stairs(1:kk,u1k)
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - u1:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('u')
legend('u1_a','u1_k','Location','southeast')
print("dmc_a_k_u1.png",'-dpng','-r400')

blad=sum((u2a-u2k).^2);
figure
hold on;
stairs(1:kk,u2a)
stairs(1:kk,u2k)
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - u2:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('u')
legend('u2_a','u2_k','Location','southeast')
print("dmc_a_k_u2.png",'-dpng','-r400')

blad=sum((u3a-u3k).^2);
figure
hold on;
stairs(1:kk,u3a)
stairs(1:kk,u3k)
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - u3:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('u')
legend('u3_a','u3_k','Location','southeast')
print("dmc_a_k_u3.png",'-dpng','-r400')

blad=sum((u4a-u4k).^2);
figure
hold on;
stairs(1:kk,u3a)
stairs(1:kk,u3k)
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - u4:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('u')
legend('u4_a','u4_k','Location','southeast')
print("dmc_a_k_u4.png",'-dpng','-r400')

blad=sum((y1a-y1k).^2);
figure
hold on
stairs(1:kk,y1a)
stairs(1:kk,y1k)
stairs(1:kk,yzad, '--')
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - y1:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('y')
legend('y1_a','y1_k','yzad','Location','southeast')
print("dmc_a_k_y1.png",'-dpng','-r400')

blad=sum((y2a-y2k).^2);
figure
hold on
stairs(1:kk,y2a)
stairs(1:kk,y2k)
stairs(1:kk,yzad, '--')
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - y2:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('y')
legend('y2_a','y2_k','yzad','Location','southeast')
print("dmc_a_k_y2.png",'-dpng','-r400')

blad=sum((y3a-y3k).^2);
figure
hold on
stairs(1:kk,y3a)
stairs(1:kk,y3k)
stairs(1:kk,yzad, '--')
hold off;
title(["Porównanie analitycznej i klasycznej wersji DMC - y3:","Błąd="+num2str(blad)])
xlabel('k')
ylabel('y')
legend('y3_a','y3_k','yzad','Location','southeast')
print("dmc_a_k_y3.png",'-dpng','-r400')