clear all, close all, clc

realLUX = [0 180 320 478 860 955 1112 1203 1383 1580]; % lux
V = [0.110 0.738 1.02 1.46 2.065 2.605 2.96 3.45 4.03 4.70]; % volts
for i=2:length(V)
    sensibility(i) = (V(i)-V(i-1))/(realLUX(i)-realLUX(i-1))/270000;
end
mean(sensibility)

calc = linspace(0.1,5,1000);
c = polyfit(V,realLUX,1);
lux = polyval(c,calc);

for i=2:length(V)
    interpolatedSensibility(i) = (calc(i)-calc(i-1))/(lux(i)-lux(i-1))/270000;
end

plot(calc,lux,'LineWidth',2), hold on
plot(V,realLUX,'-o','LineWidth',2), hold off

xlabel('Vu (V)'), ylabel('Luminous Intensity (lux)')
legend("Interpolated", "Measured")
xlim([0.1 5])