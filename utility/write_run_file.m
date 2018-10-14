function write_run_file(runfname,datfname,sprobe,P)
% write_run_file: writes a run file for NLSL simulations
% arguments: runfname(string) = filename of .run file
%            datfname(string) = filename of .dat file
%            sprobe(string) = spin probe to simulate
%            P(structure) = parameters for simulation

fid = fopen([runfname '.run'],'w');

fprintf(fid,'echo off\n\n');
fprintf(fid,'c file %s for %s:\n',[runfname '.run'],sprobe);
fprintf(fid,'log %s\n\n',runfname);
fprintf(fid,'axial r\n');
fprintf(fid,'cartesian g,a\n\n');
% fprintf(fid,'cartesian g,a,r\n\n');
% fprintf(fid,'let gxx,gyy,gzz = %f,%f,%f\n',P.g(1),P.g(2),P.g(3));
fprintf(fid,'let gxx,gyy,gzz = %f,%f,%f\n',P.gxx,P.gyy,P.gzz);
fprintf(fid,'let in2 = %f\n',P.in2);
% fprintf(fid,'let axx,ayy,azz = %f,%f,%f\n',P.a(1),P.a(2),P.a(3));
fprintf(fid,'let axx,ayy,azz = %f,%f,%f\n',P.axx,P.ayy,P.azz);
fprintf(fid,'let nort = %f\n',P.nort);
fprintf(fid,'let gib0 = %f\n',P.gib0);
fprintf(fid,'let gib2 = %f\n',P.gib2);
fprintf(fid,'let c20 = %f\n',P.c20);
fprintf(fid,'let c22 = %f\n',P.c22);
fprintf(fid,'let rprp = %f\n',P.rprp);
fprintf(fid,'let rpll = %f\n',P.rpll);
% fprintf(fid,'let n = %f\n',P.n);
% fprintf(fid,'let rx = %f\n',P.rxx);
% fprintf(fid,'let ry = %f\n',P.ryy);
% fprintf(fid,'let rz = %f\n',P.rzz);
fprintf(fid,'let B0 = %f\n',P.B0);
% fprintf(fid,'let lemx,lomx,kmx,mmx,ipnmx = 6,5,4,4,2\n');
fprintf(fid,'let lemx,lomx,kmx,mmx,ipnmx = %d,%d,%d,%d,%d\n',P.lemx,P.lomx,P.kmx,P.mmx,P.ipnmx);
% fprintf(fid,'let nstep,cgtol,shiftr = 400,1e-4,1.0\n\n');
fprintf(fid,'let nstep,cgtol,shiftr = %f,%f,%f\n\n',P.nstep,P.cgtol,P.shiftr);
fprintf(fid,'parms %s\n\n',[runfname '.log']);
fprintf(fid,'data %s ascii nspline 512 bc 50 shift\n\n',datfname);

% fprintf(fid,'fix gib0\n');
% fprintf(fid,'vary rx,ry,rz,c20,c22\n\n');
% fprintf(fid,'fit maxitr 100 maxfun 1000\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n\n');
% fprintf(fid,'fix rx,ry,rz,c20,c22\n');
% fprintf(fid,'vary gib0\n\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n\n');
% fprintf(fid,'vary gib0,rx,ry,rz,c20,c22\n\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n');
% fprintf(fid,'fit\n\n');
% fprintf(fid,'status\n\n');

fprintf(fid,'fix gib0,gib2\n');
fprintf(fid,'vary rprp,rpll,c20,c22\n\n');
fprintf(fid,'fit maxitr 100 maxfun 1000\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n\n');
fprintf(fid,'fix rprp,rpll,c20,c22\n');
fprintf(fid,'vary gib0,gib2\n\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n\n');
fprintf(fid,'vary gib0,gib2,rprp,rpll,c20,c22\n\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n');
fprintf(fid,'fit\n\n');
fprintf(fid,'status\n\n');

% fprintf(fid,'write %s\n\n',[runfname '.spc']);
fprintf(fid,'echo on\n');

fclose(fid);

return