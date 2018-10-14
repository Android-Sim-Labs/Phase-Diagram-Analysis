function plot_data(x,data)
% plot_data plots data matrix in a specific format

figure;
% set(gca,'LineStyleOrder', '');
set(gca,'ColorOrder',[0 0 0;1 0 0;0 0 1;0 1 0]);
set(gca,'Nextplot','replacechildren');
if isempty(x)
    plot(data,'.','markersize',15);
else
    plot(x,data,'.','markersize',15);
end

return