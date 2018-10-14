function plot_tielines(data)
% function plot_tielines(data)
% used to be: function plot_tielines(x,aC,bC,cC,bdy,bdyconfig,tlconfig)
if isstruct(data) 
    if isfield(data,'comps')
        comps_data = data.comps;
        if isfield(comps_data,'invariant_pts')
            invariant_pts = comps_data.invariant_pts;
        else
            error('data structure must have a field "invariant_pts" containing the invariant pts(cpt,epts)');
        end
        if isfield(comps_data,'aC')
            aC = comps_data.aC;
        else
            error('data structure must have a field "aC" containing the alpha phase comps');
        end
        if isfield(comps_data,'bC')
            bC = comps_data.bC;
        else
            error('data structure must have a field "bC" containing the beta phase comps');
        end
        if isfield(comps_data,'cC')
            cC = comps_data.cC;
        else
            error('data structure must have a field "cC" containing the coexistence comps');
        end
        if isfield(comps_data,'bdy')
            bdy = comps_data.bdy;
        else
            error('data structure must have a field "bdy" containing the boundary comps');
        end
    else
        error('data structure must have a field "comps" containing the composition data');
    end
    
    if isfield(data,'configs')
        config_data = data.configs;
        if isfield(config_data,'bdyconfig')
            bdyconfig = config_data.bdyconfig;
        else
            error('data structure must have a field "bdyconfig" containing the boundary configuration');
        end
    else
        error('data structure must have a field "configs" containing the simulation configurations');
    end
else
    error('input must be a data structure');
end

figure;
ntl = size(cC,1);
% t = [1:2:ntl]';
t = [1:ntl]';
% t = [13:16 25:28]';
% ternary_plot(bdy,'-k.','linewidth',2,'markersize',20);
ternary_plot(bdy,'-k','linewidth',3);
for i = 1:length(t)
%     line([aC(t(i),1);bC(t(i),1)],[aC(t(i),2);bC(t(i),2)],'linestyle','-','color','k','linewidth',2);
    line([aC(t(i),1);bC(t(i),1)],[aC(t(i),2);bC(t(i),2)],'linestyle','-','color','m','linewidth',2);
%             ternary_plot([aC(t(i),:);bC(t(i),:)],'-m','linewidth',3);
end
% ternary_plot(aC(t,:),'vk','markersize',10,'markerfacecolor','k');
% ternary_plot(bC(t,:),'dk','markersize',10,'markerfacecolor','k');
ternary_plot(aC(t,:),'.r','markersize',20);
ternary_plot(bC(t,:),'.b','markersize',20);
% ternary_plot(cC(t,:),'.k','markersize',20);
        
switch bdyconfig
    case '2critpts'
%         ternary_plot(invariant_pts.cpt1,'sk','markersize',10,'markerfacecolor','k');
%         ternary_plot(invariant_pts.cpt2,'sk','markersize',10,'markerfacecolor','k');
        ternary_plot(invariant_pts.cpt1,'.g','markersize',20);
        ternary_plot(invariant_pts.cpt2,'.g','markersize',20);
    case '1critpt/1endtl'
        ternary_plot(invariant_pts.cpt,'.g','markersize',20);
        ternary_plot(invariant_pts.ept1,'.y','markersize',20);
        ternary_plot(invariant_pts.ept2,'.y','markersize',20);
    case '2endtls'
        
    otherwise
        error('invalid boundary configuration');
end

return