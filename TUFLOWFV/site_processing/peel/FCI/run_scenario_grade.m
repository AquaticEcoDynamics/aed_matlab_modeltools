
int = 1
themonths(int).val = [04 04];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';

int = int + 1;
 
themonths(int).val = [05 05];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';

int = int + 1;

themonths(int).val = [6 6];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [7 7];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [08 08];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [09 9];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [10 10];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [11 11];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [12 12];
themonths(int).year = [2016 2016];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [1 1];
themonths(int).year = [2017 2017];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [2 2];
themonths(int).year = [2017 2017];
themonths(int).lab = 'Winter';
int = int + 1;

themonths(int).val = [3 3];
themonths(int).year = [2017 2017];
themonths(int).lab = 'Winter';
int = int + 1;

for i = 1:length(themonths)
    
    change(1).val = themonths(i).val;
    change(1).year = themonths(i).year;

    scenario_delMap_v2_grade(change)
end