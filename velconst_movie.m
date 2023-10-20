%‘¬“xˆê’è‚Ì§Œä‘ÎÛ‚É‚Â‚¢‚ÄŒo˜H’Ç]‚Ìó‘Ô‚ğ‚İ‚é‚½‚ß‚Ì}ì¬
function velconst(vel)
%syoki = [g1,g2,g3,syoki_sr,alpha1,alpha2];
%para = [0,0,0,0,10,25];

vid = VideoWriter('newfile.avi');
%vid.CompressionRatio = 1;

open(vid);

para  = [0 ,0,0 ,0,3,2];
options=[];
v=vel;
alpha1=para(5);
alpha2=para(6);
%x_syoki = [beta,dpsi,v ,th, s,z,betad,dpsid,thd,zd,realth,xd,yd,thki,xki,yki];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%x_syoki =  [0,0,10,0,0,3,0,0,0,3,0,0,3,0,0,0];
x_syoki =   [0.3,0,10,0,0,3,0,0,0,3,0,0,3,0,0,0];

%x_syoki =   [0.3,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0];
%x_syoki =  [0   ,0   ,v,0 ,0 ,0,0     ,0 ,0 ,0   ,0  ,0  ];
etime = 300/v;
%x_syoki=[1;1;0];
[t,x]=ode45(@main,0:0.01:etime,x_syoki,options,para);
figure(2)
plot(x(:,5),x(:,10))
figure(1)
axis([-20 45 -3 52])
xlabel('X [m]')
ylabel('Y [m]')
for i = 1:length(t)/10
%plot(x(10*i,12),x(10*i,13),'k-','LineWidth',2)
line([cos(x(10*i,11))+x(10*i,12), -cos(x(10*i,11))+x(10*i,12)],[sin(x(10*i,11))+x(10*i,13), -sin(x(10*i,11))+x(10*i,13)]);
hold on
line([-sin(x(10*i,11))+x(10*i,12), sin(x(10*i,11))+x(10*i,12)],[cos(x(10*i,11))+x(10*i,13), -cos(x(10*i,11))+x(10*i,13)]);
hold on
plot(x(:,15),x(:,16),'k-.','LineWidth',2)
hold off
axis([-20 45 -3 52])
 M = getframe(gcf);
 
writeVideo(vid,M);

 hold off
end


close(vid);

%%%%%%%%%%%%%%%%%%%%%%% ‰¡²‚ª‚“‚’‚ÅŠŠ‚èŠp‚ğ¦‚µ‚½}@%%%%%%%%%%%%%%%%%%@‚l‚`‚s‚k‚`‚a•\¦‚É”ÏG‚È‚Ì‚Åˆê“I‚ÉÁ‚µ‚Ä‚¢‚é
%figure(5)
%plot(x(:,5),x(:,1))
%hold on
function xd = main(t,x,para)
xd=zeros(16,1);
	 g1 = para(1);
	 g2 = para(2);
	 g3 = para(3);
	 %str_kappa = kappa_fun2(para(4),x(5));
     str_kappa = kappa_fun(para(4),x(5));
     kappa = str_kappa(1);
	 kdash = str_kappa(2);
	 gamma = kdash;
     beta = x(1); %% ‚·‚×‚èŠp beta ‚Ì‚±‚Æ
	 dpsi = x(2);  %% ƒˆ[Šp‘¬“x psidot ‚Ì‚±‚Æ
	 v = x(3);
	 th = x(4);
     sr = x(5);
	 z = x(6);
     betad = x(7); %% ‚·‚×‚èŠp beta ‚Ì‚±‚Æ
	 dpsid = x(8);  %% ƒˆ[Šp‘¬“x psidot ‚Ì‚±‚Æ
	 thd = x(9);
	 zd = x(10);
  	 realth = x(11);
     xreal = x(12);
     yreal = x(13);
     thki = x(14);
     xki = x(15);
     yki = x(16);
	 co = cos(th);
	 si = sin(th);
	 ta = tan(th);
     cod = cos(thd);
     sid = sin(thd);
     tad = tan(thd);
     Kfd = 45372.9;
     Krd = 74405.5;
     lrd = 1.122;
     lfd = 1.428;
     Id = 2205;
     md = 1507;
     Kf = Kfd;%*(1-0.2);
     Kr =Krd;%*(1-0.2);
     lr = lrd;
     lf = lfd;
     %I = Id*(1+0.3);
     I = Id;
     %m = md*(1+0.2);
     m = md;
	 a11 = -(Kf+Kr)/m;
	 a12 = (-lf*Kf+lr*Kr)/m;
	 a13 = Kf/m;
	 a21 = (-lf*Kf+lr*Kr)/I;
	 a22 = -(lf^2*Kf+lr^2*Kr)/I;
	 a23 = lf*Kf/I;
     a31 = -(Kf+Kr)/m;
	 a32 = (-lf*Kf+lr*Kr)/m;
	 a33 = Kf/m;
     a11d = -(Kfd+Krd)/md;
	 a12d = (-lfd*Kfd+lrd*Krd)/md;
	 a13d = Kfd/md;
	 a21d = (-lfd*Kfd+lrd*Krd)/Id;
	 a22d = -(lfd^2*Kfd+lrd^2*Krd)/Id;
	 a23d = lfd*Kfd/Id;
     a31d = -(Kfd+Krd)/md;
	 a32d = (-lfd*Kfd+lrd*Krd)/md;
	 a33d = Kfd/md;
     alpha1=para(5);
     alpha2=para(6);
     %% ‘€‘ÇŠp
    %delta = -alpha1*v*tad/a13d-alpha2*zd/cod/a13d-a11d*betad/a13d-a12d*(dpsid)/a13d/v+kappa*v^2*cod/a13d/(1-kappa*zd)+10*(v*tad/a13d-v*ta/a13)+25*(zd/a13d/cod-z/a13/co);
    %delta = -alpha1*v*tad/a13d-alpha2*zd/cod/a13d-a11d*betad/a13d-a12d*(dpsid)/a13d/v+kappa*v^2*cod/a13d/(1-kappa*zd)+alpha1*(v*tad/a13d-v*ta/a13)+alpha2*(zd/a13d/cod-z/a13/co);
    delta = -alpha1*v*ta/a13d-alpha2*z/co/a13d-a11d*beta/a13d-a12d*dpsi/a13d/v+kappa*v^2*co/a13d/(1-kappa*z);
    deltanom = -alpha1*v*tad/a13d-alpha2*zd/cod/a13d-a11d*betad/a13d-a12d*(dpsid)/a13d/v+kappa*v^2*cod/a13d/(1-kappa*zd);
     
xd(1)=a11/v*beta+(a12/v/v-1)*dpsi+a13/v*delta;
xd(2)=a21*beta+a22/v*dpsi+a23*delta;
xd(3)=0;
xd(4)=a31/v*beta+a32/v/v*dpsi+a33/v*delta-kappa*v*co/(1-kappa*z);
xd(5)=v*co/(1-kappa*z);
xd(6)=v*si;
xd(7)=a11d/v*betad+(a12d/v/v-1)*dpsid+a13d/v*deltanom;
xd(8)=a21d*betad+a22d/v*dpsid+a23d*deltanom;
xd(9)=a31d/v*betad+a32d/v/v*dpsid+a33d/v*deltanom-kappa*v*cod/(1-kappa*zd);
xd(10)=v*sid;
xd(11)=a31/v*beta+a32/v/v*dpsi+a33/v*delta;
xd(12)=v*cos(realth);
xd(13)=v*sin(realth);
xd(14)=kappa*v*cos(th)/(1-kappa*z);
xd(15)=v*cos(th)/(1-kappa*z)*cos(thki);
xd(16)=v*cos(th)/(1-kappa*z)*sin(thki);