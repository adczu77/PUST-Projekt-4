clear;
kk=300;
for i=1:4
    u1(1:kk)=0;
    u2(1:kk)=0;
    u3(1:kk)=0;
    u4(1:kk)=0;
    y1(1:kk)=0;
    y2(1:kk)=0;
    y3(1:kk)=0;
    if i==1
        u1(20:kk)=1;
    end
    if i==2
        u2(20:kk)=1;
    end
    if i==3
        u3(20:kk)=1;
    end
    if i==4
        u4(20:kk)=1;
    end
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
    if i==1
        stairs(1:kk,u1)
    end
    if i==2
        stairs(1:kk,u2)
    end
    if i==3
        stairs(1:kk,u3)
    end
    if i==4
        stairs(1:kk,u4)
    end
    title("Skok u"+"_{"+num2str(i)+"}:")
    xlabel('k')
    ylabel("u_{"+num2str(i)+"}")
    print("skok_u"+num2str(i)+".png",'-dpng','-r400')
    
    s1=(y1(21:kk));
    s1(280:kk)=s1(end);
    figure
    stairs(1:kk,s1)
    title("Odpowiedź skokowa y_{1} dla u"+"_{"+num2str(i)+"}:")
    xlabel('k')
    ylabel('y_{1}(k)')
    ylim([0 3]);
    print("odp_skok_y1_dla_u"+num2str(i)+".png",'-dpng','-r400')
    fileID = fopen("odp_skok_y1_dla_u"+num2str(i)+".txt",'w');
    fprintf(fileID,'%.6f\n',s1);
    fclose(fileID);
    
    s2=(y2(21:kk));
    s2(280:kk)=s2(end);
    figure
    stairs(1:kk,s2)
    title("Odpowiedź skokowa y_{2} dla u"+"_{"+num2str(i)+"}:")
    xlabel('k')
    ylabel('y_{2}(k)')
    ylim([0 3]);
    print("odp_skok_y2_dla_u"+num2str(i)+".png",'-dpng','-r400')
    fileID = fopen("odp_skok_y2_dla_u"+num2str(i)+".txt",'w');
    fprintf(fileID,'%.6f\n',s2);
    fclose(fileID);
    
    s3=(y3(21:kk));
    s3(280:kk)=s3(end);
    figure
    stairs(1:kk,s3)
    title("Odpowiedź skokowa y_{3} dla u"+"_{"+num2str(i)+"}:")
    xlabel('k')
    ylabel('y_{3}(k)')
    ylim([0 3]);
    print("odp_skok_y3_dla_u"+num2str(i)+".png",'-dpng','-r400')
    fileID = fopen("odp_skok_y3_dla_u"+num2str(i)+".txt",'w');
    fprintf(fileID,'%.6f\n',s3);
    fclose(fileID);
end
