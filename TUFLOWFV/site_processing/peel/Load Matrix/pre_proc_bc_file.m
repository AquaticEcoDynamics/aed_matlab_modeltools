clear all; close all;

pin = tfv_readBCfile('Pinjarra.csv');
har = tfv_readBCfile('Harvey.csv');
ser = tfv_readBCfile('Serpentine.csv');


datelim = [datenum(2017,08,01) datenum(2018,10,01)];

vars = fieldnames(pin);

sss = find(pin.Date >= datelim(1) & pin.Date < datelim(2));
ttt = find(har.Date >= datelim(1) & har.Date < datelim(2));
uuu = find(ser.Date >= datelim(1) & ser.Date < datelim(2));

for i = 1:length(vars)
    ldata.Pinjarra.(vars{i}) = pin.(vars{i})(sss);
    ldata.Harvey.(vars{i}) = har.(vars{i})(ttt);
    ldata.Serpentine.(vars{i}) = ser.(vars{i})(uuu);
end

ldata.Pinjarra.ML = ldata.Pinjarra.Flow * 86400 /1000;
ldata.Harvey.ML = ldata.Harvey.Flow * 86400 /1000;
ldata.Serpentine.ML = ldata.Serpentine.Flow * 86400 /1000;

save ldata.mat ldata -mat;

