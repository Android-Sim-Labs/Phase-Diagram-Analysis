function varargout = plot_tie_lines(bdy_pts,bdy_rep,alpha_p,beta_p,ntpts) 
% plot_tern_tie_lines plots tie lines within the boundary specified by
% bdy_pts within a ternary coordinate system

% [p1 p2 ntie] = deal(beta_specs(1),beta_specs(2),beta_specs(3));
% [ntie ntpts] = deal(tline_specs(1),tline_specs(2));
% bp = [0:0.02:1]';
% [bdy_length,bdy_intervals] = bdy_fxn(bdy_pts,'linear');
% ibdy_pts = interp1(bp,bdy_pts,s,bdy_rep);
% ibdy_pts = interp1(bdy_intervals(:,1),bdy_pts,bp,bdy_rep);
% s = [0:0.01:1]';
% [bdy_length,bdy_intervals] = bdy_fxn(ibdy_pts,'linear');
% ibdy_pts = interp1(bdy_intervals(:,1),ibdy_pts,s,bdy_rep);
% ternary_plot(ibdy_pts);

[nbdypts,dbdy] = size(bdy_pts);
[bdy_len,bdy_int] = bdy_fxn(bdy_pts,'linear');
s = bdy_int(:,1);
ibdy_pts = bdy_pts;

if any(size(alpha_p) == 1)
    if any(alpha_p < 0 | alpha_p > 1)
        error('alpha point parameter must be between 0 and 1');
    else
        if size(alpha_p,2) > 1
            % alpha_p not parameter but pt(s)
            alpha_pts = alpha_p;
            [na,da] = size(alpha_pts);
        else
            na = length(alpha_p);
            da = dbdy;
            alpha_pts = interp1(s,ibdy_pts,alpha_p,bdy_rep);
        end
    end
else
    if any(any(alpha_p < 0 | alpha_p > 1))
        error('alpha point coordinates must be between 0 and 1');
    else
        % alpha_p not parameter but pt(s)
        alpha_pts = alpha_p;
        [na,da] = size(alpha_pts);
    end
end

if iscell(beta_p)
    if size(beta_p) == [1 2] | size(beta_p) == [2 1]
        ntie = beta_p{2};
        beta_p = beta_p{1};
        
        if any(size(beta_p) == 1)
            if any(beta_p < 0 | beta_p > 1)
                error('beta point parameter must be between 0 and 1');
            else
                nb = length(beta_p);
                
                if nb < 2
                    beta_pts = interp1(s,ibdy_pts,beta_p,bdy_rep);
                elseif nb == 2 
                    if ntie < 2
                        ntie = nb;
                    end
            
                    [begin_bp end_bp] = deal(beta_p(1),beta_p(2));
    
                    if begin_bp < end_bp
                        beta_p = linspace(begin_bp,end_bp,ntie)';
                    else
                        beta_p = linspace(begin_bp,1+end_bp,ntie)';
                        beta_p(beta_p >= 1) = beta_p(beta_p >= 1)-1;
                    end
    
                    beta_pts = interp1(s,ibdy_pts,beta_p,bdy_rep);
                elseif nb > 2
                    beta_p(beta_p == 1) = 0;
                    beta_pts = interp1(s,ibdy_pts,beta_p,bdy_rep);
                end
                
                [nb,db] = size(beta_pts);
            end
        else
            if any(any(beta_p < 0 | beta_p > 1))
                error('beta point coordinates must be between 0 and 1');
            else
                % beta_p not parameter but pt(s)
                beta_pts = beta_p;
                [nb,db] = size(beta_pts);
            end
        end
    else
        error('invalid form for 4th argument');
    end
else
    if any(size(beta_p) == 1)
        if any(beta_p < 0 | beta_p > 1)
            error('beta point parameter must be between 0 and 1');
        else
            if size(beta_p,2) > 1
                % beta_p not parameter but pt(s)
                beta_pts = beta_p;
                [nb,db] = size(beta_pts);
            else
                nb = length(beta_p);
                db = dbdy;
                beta_p(beta_p == 1) = 0;
                beta_pts = interp1(s,ibdy_pts,beta_p,bdy_rep);
            end
        end
    else
        if any(any(beta_p < 0 | beta_p > 1))
            error('beta point coordinates must be between 0 and 1');
        else
            % beta_p not parameter but pt(s)
            beta_pts = beta_p;
            [nb,db] = size(beta_pts);
        end
    end
end

% [na,da] = size(alpha_pts);
% [nb,db] = size(beta_pts);

% if ternary coords, convert to ternary cartesian
if da == 3
    alpha_pts = tern2cart(alpha_pts,1);
elseif da ~= 2
    error('dimensions of alpha pts must equal 2 or 3 currently');
end

if db == 3
    beta_pts = tern2cart(beta_pts,1);
elseif db ~= 2
    error('dimensions of beta pts must equal 2 or 3 currently');
end

% each alpha point get connected to all beta pts     
for a = 1:na
    for b = 1:nb
        tie_lines{a}(:,:,b) = [linspace(alpha_pts(a,1),beta_pts(b,1),ntpts)',...
                               linspace(alpha_pts(a,2),beta_pts(b,2),ntpts)'];
    end
end          

ternary_plot(bdy_pts,'-k','linewidth',3);
ternary_plot(cart2tern(alpha_pts,1),'.r','markersize',20);
ternary_plot(cart2tern(beta_pts,1),'.b','markersize',20);
    
hold on;      
for a = 1:na
    for b = 1:nb
        line([alpha_pts(a,1);beta_pts(b,1)],[alpha_pts(a,2);beta_pts(b,2)],'linestyle','-','color',[1 0 1]);     
    end
end       
hold off;

% if ternary coordinates, convert back
if da == 3
    alpha_pts = cart2tern(alpha_pts,1);
end

if db == 3
    beta_pts = cart2tern(beta_pts,1);
end

if dbdy == 3
    for a = 1:na
        for b = 1:nb
            t_l{a}(:,:,b) = cart2tern(tie_lines{a}(:,:,b),1);
        end
    end
end
tie_lines = t_l;
clear t_l;

if nargout == 1 
    varargout{1} = tie_lines;
elseif nargout == 2
    varargout{1} = alpha_pts;
    varargout{2} = beta_pts;
elseif nargout == 3
    varargout{1} = alpha_pts;
    varargout{2} = beta_pts;
    varargout{3} = tie_lines;
elseif nargout > 3
    error('too many output arguments');
end

return