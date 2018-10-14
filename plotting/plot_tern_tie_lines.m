function [alpha_pts,beta_pts,tie_lines] = plot_tern_tie_lines(bdy_pts,bdy_rep,nt,gamma1,gamma2)
% plot_tern_tie_lines plots tie lines within the boundary specified by
% bdyy_pts within a ternary coordinate system

[bdy_length,bdy_intervals] = tern_bdy_fxn(bdy_pts,bdy_rep);
a_pts=zeros(nt,2);
b_pts=zeros(nt,2); 
x=linspace(0,1,nt);

if (gamma1 <= gamma2)
    sa=gamma1+x*(gamma2-gamma1);
    sb=1+gamma1-x*(1-gamma2+gamma1);
else
    store=gamma1;
    gamma1=gamma2;
    gamma2=store;
    sb=gamma1+x*(gamma2-gamma1);
    sa=1+gamma1-x*(1-gamma2+gamma1);
end

for i=1:nt
    alpha_pts(i,:)=get_tern_bdy_pt(bdy_pts,bdy_rep,sa(i),bdy_length,bdy_intervals);
    beta_pts(i,:)=get_tern_bdy_pt(bdy_pts,bdy_rep,sb(i),bdy_length,bdy_intervals);
    tie_lines(:,:,i) = [alpha_pts(i,:);beta_pts(i,:)];
    line(tie_lines(:,1,i),tie_lines(:,2,i),'linestyle','-','color',[1 0 0]);
end