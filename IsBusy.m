function count = IsBusy
global scom
t = 'B';
count = -1;
while (contains(t,'B'))
    fprintf(scom,'/');
    t = fscanf(scom);
    count = count + 1;
end
return